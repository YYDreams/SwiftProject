//
//  SPTXUploadManager.swift
//  SwiftProject
//
//  Created by flower on 2024/5/30.
// 腾讯云的上传封装

import Foundation
import PromiseKit
import QCloudCOSXML
import HandyJSON
import TXUploadSDK
public class ECLogUploadCosInfoModel: NSObject,HandyJSON {
    public var group_img_path: String?
    public var requestId: String?
    public var cos_region: String?
    public var cos_app_id: String?
    public var expiredTime: String?
    public var startTime: String?
    public var expiration: String?
    public var cos_bucket: String?
    public var credentials: Credentials?
    
    public class Credentials: NSObject,HandyJSON {
        public var sessionToken: String?
        public var tmpSecretId: String?
        public var tmpSecretKey: String?
        public override required init() {}
    }
    
    public override required init() {}
}
enum SPUploadType {
    case video
    case image
}

class SPUploadModel: NSObject{
    // 公共参数
    var localFileId: String? //本地文件id
    var progress: Double = 0.0 //当前进度
    var image:UIImage? //封面
    var url:String? //上传成功后返回url
    
    var uploadType: SPUploadType = .image //上传类型
    // 图片参数
    var imgData:Data? //上传图片需要的参数
    
    // 视频参数
    var filePath: String?
    // 上传成功后的结果数据
    var totalSize: Int = 0
    var fileLength: Int = 0
    var retCode: Int = -1

}

public class SPTXUploadManager: NSObject {
    public static let share = SPTXUploadManager()

    
    fileprivate var cosLogTokenModel: ECLogUploadCosInfoModel?

    
    /// 上传视频的数组模型
     var uploadModels = [SPUploadModel]()
    
    /// 上传视频的数组
    public var publishs =  [TXUGCPublish]()
    
    /// 上传参数的数组
    public var publishParams =  [TXPublishParam]()
    
    var videoUploadProcessBlock : ((_ model:SPUploadModel?) -> ())?
    var videoUploadFinishBlock : ((_ model:SPUploadModel?) -> ())?
    var videoUploadFailBlock : ((_ model:SPUploadModel?, _ error: Error) -> ())?

    /* 对象存储->上传对象
     官方文档:https://cloud.tencent.com/document/product/436/46381#.E7.AE.80.E5.8D.95.E4.B8.8A.E4.BC.A0.E5.AF.B9.E8.B1.A1
     
     */
    /*** 上传对象 **/
    
    /// 配置腾讯上传服务
    private func configTXQCloudService() {
        let config = QCloudServiceConfiguration.init()
        let endpoint = QCloudCOSXMLEndPoint.init()
        //服务地域简称，例如广州地区是 ap-guangzhou
        endpoint.regionName = cosLogTokenModel?.cos_region
        // 使用 HTTPS
        endpoint.useHTTPS = true
        config.endpoint = endpoint
        // 密钥提供者为自己
        config.signatureProvider = self
        
        // 初始化 COS 服务示例
        QCloudCOSXMLService.registerDefaultCOSXML(with: config)
        QCloudCOSTransferMangerService.registerDefaultCOSTransferManger(
            with: config)
    }
    func testRequest(){
        transferBatchUploadObjects(models: [SPUploadModel]())
        
    }
    ///  批量上传对象
    /// - Parameters:
    ///   - models: 需要批量上传的数组模型
    ///   - processBlock: 当前进度的回调
    ///   - finishBlock: 上传结果的回调
    ///   - failBlock:  失败的回调
    func transferBatchUploadObjects(models:[SPUploadModel],
                                    processBlock: ((_ uploadModel: SPUploadModel?) -> ())? = nil,
                                    finishBlock: ((_ uploadModel: SPUploadModel?) -> ())? = nil,
                                    failBlock: ((_ uploadModel: SPUploadModel?, _ error: Error) -> ())? = nil) {
        
        /// 请求签名
        firstly{ () -> Promise<ECLogUploadCosInfoModel?>in
            return reqeustCosToken()
        }.done { response in
            print("SPTXUploadManager----\(response)")
            if let response = response {
                self.cosLogTokenModel = response
                self.configTXQCloudService()
                models.forEach {
                    let currentUploadModel = SPUploadModel()
                    currentUploadModel.localFileId = $0.localFileId
                    let put:QCloudCOSXMLUploadObjectRequest = QCloudCOSXMLUploadObjectRequest<AnyObject>();
                    if let cosLogTokenModel = self.cosLogTokenModel {
                        put.bucket = "\(cosLogTokenModel.cos_bucket ?? "")-\(cosLogTokenModel.cos_app_id ?? "")"
                        if let obj = $0.localFileId, let data = $0.imgData {
                            let fileName = obj + "_\(Int(Date().timeIntervalSince1970))" + ".jpg"
                            put.object = "\(cosLogTokenModel.group_img_path ?? "")circleapp/files/ios_\(fileName)"
                            put.body = data as AnyObject
                        }
                        // 监听上传结果
                        put.setFinish { (result, error) in
                            currentUploadModel.url = result?.location
                            if result != nil {
                                finishBlock?(currentUploadModel)
                            } else {
                                if let err = error as? NSError {
                                    failBlock?(currentUploadModel,err)
                                }
                            }
                        }
                        // 监听上传进度
                        put.sendProcessBlock = { (bytesSent, totalBytesSent,
                                                  totalBytesExpectedToSend) in
                            let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
                            currentUploadModel.progress = progress
                            processBlock?(currentUploadModel)
                        };
                        QCloudCOSTransferMangerService.defaultCOSTransferManager().uploadObject(put);
                    }
                }
            }
        }.recover {error in
            failBlock?(nil,error)
        }
    }
    
  
    
    
    /********************************************* 上传视频(云点播) ***********************************************************/
    /// 取消上传单个视频
    /// - Parameter localFileId: 文件id
    /// - Returns: 是否取消成功
    @discardableResult
    public func cancelPublish(localFileId:String) -> Bool {
        var isSuccess = true
        if let videoPublish = publishs.first(where: { $0.publishId == localFileId }) {
            isSuccess =  videoPublish.canclePublish()
        }
        return isSuccess
    }
    
    
    /// 恢复上传单个视频
    /// - Parameter localFileId: 文件id
    public func resumePublishVideo(localFileId:String)  {
        cheakSuccess()
        if let videopublish  = publishs.first(where: {$0.publishId == localFileId}),
           let publishParam = publishParams.first(where: {$0.publishId == localFileId}){
            videopublish.publishVideo(publishParam)
        }
    }
    /// 取消全部
    public func cancelAllPublish(){
        cheakSuccess()
        publishs.forEach{ $0.canclePublish() }
    }
    
    
    /// 恢复全部
    public func resumeAllPublishVideo()  {
        cheakSuccess()
        publishParams.forEach { item in
            publishs.forEach{$0.publishVideo(item)}
        }
    }
    
    /// 检测上传成功的并将成功的话将其移除
    func cheakSuccess(){
        let localFileIds = uploadModels.filter{ $0.progress >= 1 }.map{ $0.localFileId }
        publishParams.removeAll{ localFileIds.contains($0.publishId) }
        publishs.removeAll { localFileIds.contains($0.publishId) }
    }
    
    
    func transferBatchUploadVideos(userId: String,
                                   models:[SPUploadModel],
                                    processBlock: ((_ uploadModel: SPUploadModel?) -> ())? = nil,
                                    finishBlock: ((_ uploadModel: SPUploadModel?) -> ())? = nil,
                                    failBlock: ((_ uploadModel: SPUploadModel?, _ error: Error) -> ())? = nil) {
 
        self.videoUploadProcessBlock = processBlock
        self.videoUploadFinishBlock = finishBlock
        self.videoUploadFailBlock = failBlock

        firstly{ () -> Promise<SPRequestResultModel?>in
            return self.requestSignature(appId: "", userId: userId)
        }.done { resultModel in
            if let signature = resultModel?.data  as? String{
                models.forEach {
                    // 配置上传参数
                    let  publishParam = TXPublishParam()
                    publishParam.signature = signature
                    publishParam.videoPath = $0.filePath ?? ""
                    publishParam.publishId = $0.localFileId ?? ""
                    publishParam.enableHTTPS = true
                    let videoPublish = TXUGCPublish(userID: userId)!
                    videoPublish.delegate = self
                    videoPublish.publishId = $0.localFileId ?? ""
                    videoPublish.publishVideo(publishParam)
                    self.uploadModels.append($0)
                    self.publishs.append(videoPublish)
                    self.publishParams.append(publishParam)
                }
            }
        }.recover {error in
            failBlock?(nil,error)
        }
    }
    
    
    
    
    /// 请求上传文件的costoken
    /// - Returns: 结果响应
    private func reqeustCosToken() ->  Promise<ECLogUploadCosInfoModel?> {
        return NetworkPublicApi.default.sendRequestAndDataDecode(apiMethod: "/xe.community.community_service/app/upload/get_cos_sign/1.0.0",
                                                               parameters: [:])
    }
    //获取签名
    func requestSignature(appId:String,userId:String)->Promise<SPRequestResultModel?>{
         return  NetworkPublicApi.default.sendRequestAndDataDecode(apiMethod: "/xe.community.community_service/app/upload/get_video_auth/1.0.0",
                                                                 method:.get,
                                                                 parameters: ["app_id":appId,"user_id":userId])
    }
    
    
}
extension SPTXUploadManager : TXVideoPublishListener  {
    // 上传结果
    public func onPublishComplete(_ result: TXPublishResult!) {
        if let model = uploadModels.first(where: {$0.localFileId == result.publishId}){
            model.retCode =  Int(result.retCode)
            model.url = result.videoURL
            self.videoUploadFinishBlock?(model)
        }
        
//        self.uploadModel?.remoteFileURL = result.videoURL
//        self.uploadModel?.retCode = Int(result.retCode)
//        self.uploadModel?.videoId = result.videoId
//        self.uploadModel?.descMsg = result.descMsg
//        self.uploadModel?.localFileId = result.publishId
//
//        self.delegate?.didFinishedFileUploadToTX(result: self.uploadModel)
    }
    // 上传进度
    public func onPublishProgress(_ uploadBytes: Int, totalBytes: Int, publishId: String!) {
        
        
        if let model = uploadModels.first(where: {$0.localFileId == publishId}){
            print("-----*******uploadBytes:\(uploadBytes) totalBytes:\(totalBytes) publishid:\(publishId) \(model.progress)")
            if uploadBytes != 0 && totalBytes != 0{
                model.progress = Double(uploadBytes) / Double(totalBytes)
                self.videoUploadProcessBlock?(model)
                print("onPublishProgress====1 \(model.progress)")
            }else{
                print("onPublishProgress====2 \(model.progress)")
            }
        }
        
//        self.delegate?.uploadingFileWithProgress(localFileId:publishId, total: totalBytes, current: uploadBytes)
    }
    
}
extension SPTXUploadManager : QCloudSignatureProvider  {
    
    public func signature(with fileds: QCloudSignatureFields!, request: QCloudBizHTTPRequest!, urlRequest urlRequst: NSMutableURLRequest!, compelete continueBlock: QCloudHTTPAuthentationContinueBlock!) {
     
        if let cosLogTokenModel = cosLogTokenModel {
            let credential = QCloudCredential.init()
            // 临时密钥 SecretId // COS_SECRETID
            credential.secretID = cosLogTokenModel.credentials?.tmpSecretId ?? ""
            // 临时密钥 SecretKey
            credential.secretKey = cosLogTokenModel.credentials?.tmpSecretKey ?? ""
            // 临时密钥 Token
            credential.token = cosLogTokenModel.credentials?.sessionToken ?? ""
            // 强烈建议返回服务器时间作为签名的开始时间
            // 用来避免由于用户手机本地时间偏差过大导致的签名不正确
            credential.startDate = DateFormatter().date(from: cosLogTokenModel.startTime ?? "");
            // 这里返回的时间单位是秒
            credential.expirationDate = DateFormatter().date(from: cosLogTokenModel.expiredTime ?? "")
            
            let creator = QCloudAuthentationV5Creator.init(credential: credential)
            // 注意 这里不要对urlRequst 进行copy以及mutableCopy操作
            let signature = creator?.signature(forData: urlRequst);
            continueBlock(signature,nil);
        }
        
    }
    
}
