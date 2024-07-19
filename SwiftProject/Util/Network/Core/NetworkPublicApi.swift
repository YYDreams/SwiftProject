//
//  NetworkPublicApi.swift
//  SPNetwork
//
//  Created by flowerflower on 2021/12/3.
//

import Alamofire
import PromiseKit
import HandyJSON
import UIKit
//import DeviceKit
import Moya

/// 环境配置
public enum EnvType:String,HandyJSONEnum {
    case develop = "开发环境" // 开发环境：测试店铺（包名、微信等配置使用开发的）
    case test = "测试环境" // 测试环境（包名、微信等配置使用测试的）
    case pruduct = "现网环境" // 生产环境（包名、微信等配置使用正式的）
}

class XRServerTrustPolicyManager: ServerTrustPolicyManager {
    
    init() {
        super.init(policies: [:])
    }
    
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    
}

open class NetworkPublicApi : NSObject {
    
    /// 接口请求基类单例
    public static let `default` = NetworkPublicApi()
    
    /// 基础参数 (设备信息、版本号等参数)
    public var baseParams:[String:Any] = [:]
    
    public var header: HTTPHeaders = [:]
    
    /// 自定义host
    public var requestBaseUrl = ""
    
    /// 自定义参数(eg:需要登录成功后需要用户信息等参数)
    public static var customParams: [String:Any] = [:]
    
    var sessionManager = Alamofire.SessionManager.default
    public override init() {
        super.init()
        setupConfig()
    }
    
  

    open func baseUrl()->String{
        if requestBaseUrl.count <= 0 {
            print("Error---请设置baseUrl")
        }
        return requestBaseUrl

    }
    
    private func setupConfig()  {
        header = Alamofire.SessionManager.defaultHTTPHeaders
//        requestPropertys.header["Content-type"] = "application/json"
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 20
        configuration.httpShouldSetCookies = false
        
        /// 非debug模式不允许抓包
        if isDebug == false {
            configuration.connectionProxyDictionary = [:]
        }
        sessionManager = Alamofire.SessionManager.init(configuration: configuration, serverTrustPolicyManager: XRServerTrustPolicyManager())
    }
    
    /// 添加基础参数和用户信息相关参数
    func addUserParamAndBaseParams( params: [String : Any]) -> [String : Any]  {
        
        ///拼接固定参数
        var requestParams:[String:Any] = baseParams
        ///再拼接外层参数，以外层为准
        type(of: self).customParams.forEach { requestParams[$0] = $1 }
        ///组成用户相关参数
//        if let model = userParamModel,
//           let userParams = model.toJSON() {
//            userParams.forEach{ requestParams[$0] = $1 }
//
//        }
        ///再拼接外层参数，以外层为准
        params.forEach { requestParams[$0] = $1 }
        
        return requestParams
    }
    
    
    /// 获取当前api请求需要的header参数
    /// - Parameter apiHeaders: 当前api请求自定义header
    /// - Returns: 结果
    func getApiReqeustHeaders(apiHeaders: HTTPHeaders?) -> HTTPHeaders {
        var resultHeaders:HTTPHeaders = [:]
        if envType != .pruduct {
            header["cookie"] = "app_id=" + (grayscaleAppId ?? "")  + ";"
        }
        header.forEach { resultHeaders[$0] = $1 }
        apiHeaders?.forEach { resultHeaders[$0] = $1 }
        return resultHeaders
    }
    
    
    /// 上传文件
    open func upload(fileData:Data,fileKey:String,fileName:String,contentType:String,httpHeaders:HTTPHeaders,urlStr:String,completeHandler: ((_ isSuccess:Bool, _ url:String?) -> ())?) {
        Alamofire.upload(multipartFormData: { formData in
            formData.append(fileData, withName: fileKey,fileName: fileName, mimeType: contentType)
        }, to: urlStr, method: .post, headers: httpHeaders) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if response.result.isSuccess, let jsonString = response.result.value as? [String:Any] {
                        let url = jsonString["data"] as? String
                        completeHandler?(true, url)
                    }
                }
            case .failure(_):
                completeHandler?(false, nil)
            }
        }
    }
    
    
    /// 上传图片
    open func uploadImage
    (params: [String: String]? = nil, token: String, fileData:Data, fileKey:String, fileName:String, contentType:String, urlStr:String, completeHandler: ((_ isSuccess:Bool, _ url:String?) -> ())?) {
        
        let tokenData = token.data(using: .utf8) ?? Data()
        
        let requestUrl = baseUrl() +  urlStr
        
        let httpHeaders: HTTPHeaders = [
            "app-type": "merchant_assistant_app"
        ]
        
        Alamofire.upload(multipartFormData: { formData in
            formData.append(tokenData, withName: "token")
            formData.append(fileData, withName: fileKey,fileName: fileName, mimeType: contentType)
            
            if let params = params {
                for (key, value) in params {
                    formData.append(value.data(using: .utf8) ?? Data() , withName: key)
                }
            }
        }, to: requestUrl, method: .post, headers: httpHeaders) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if response.result.isSuccess, let jsonString = response.result.value as? [String:Any] {
                        let url = jsonString["data"] as? [String:Any]
                        let headimgurl = url?["headimgurl"] as? String
                        completeHandler?(true, headimgurl)
                    }
                }
            case .failure(_):
                completeHandler?(false, nil)
            }
        }
    }
    


    /// 解析数据，返回data对应的model
    open func sendRequestAndDataDecode<T:HandyJSON>(apiMethod:String,
                                                    host: String? = nil,
                                                    method: HTTPMethod = .post,
                                                    parameters:[String:Any] = [:],
                                                    headers: HTTPHeaders? = nil) -> Promise<T?>  {
        return Promise<T?> { resolver in
            let url = getUrl(apiMethod: apiMethod, host: host)
            let param = addUserParamAndBaseParams(params: parameters)
            let headers = getApiReqeustHeaders(apiHeaders: headers)
            let encoding: ParameterEncoding = method == .post ? JSONEncoding.default : URLEncoding.default
            self.sessionManager.request(url, method: method, parameters: param, encoding: encoding, headers: headers).responseJSON { [weak self] (response) in
#if DEBUG
                print("url ---- \(url)")
                print("headers ---- \(headers)")
                print("requestParams ---- \(param)")
                print("response ---- \(response)")
#endif
                if response.result.isSuccess,
                   let json = response.result.value {
                    let (model, error) = SPRequestResultModel.decode(json: json as? NSDictionary)
                    if let model = model {
                        //成功
                        resolver.fulfill(model.model())
                    } else {
                        self?.dealError(error: error)
                        resolver.reject(error ?? AFError.responseValidationFailed(reason: AFError.ResponseValidationFailureReason.dataFileNil))
                    }
                }else{
                    //失败
                    var customError: Error?
                    if let error = response.result.error{
                        let nserror = error as NSError
                        customError = self?.dealAFCode(error: nserror, statusCode: response.response?.statusCode ?? 0, url: url)
                    }
                    resolver.reject(customError ?? response.result.error ?? AFError.responseValidationFailed(reason: AFError.ResponseValidationFailureReason.dataFileNil))
                }
            }
         }
    }
    
    /// 解析数据，返回data对应的model数组
    open func sendRequestAndDataDecode<T:HandyJSON>(apiMethod:String,
                                                      host: String? = nil,
                                               method: HTTPMethod = .post,
                                               parameters:[String:Any] = [:],
                                                    headers: HTTPHeaders? = nil) -> Promise<[T]?>  {
        return Promise<[T]?> { resolver in
            let url = getUrl(apiMethod: apiMethod, host: host)
            let param = addUserParamAndBaseParams(params: parameters)
            let headers = getApiReqeustHeaders(apiHeaders: headers)
            let encoding: ParameterEncoding = method == .post ? JSONEncoding.default : URLEncoding.default
            self.sessionManager.request(url, method: method, parameters: param, encoding: encoding, headers: headers).responseJSON {[weak self] (response) in
#if DEBUG
                print("url ---- \(url)")
                print("headers ---- \(headers)")
                print("requestParams ---- \(param)")
                print("response ---- \(response)")
#endif
                
                if response.result.isSuccess,
                   let json = response.result.value {
                    let (model, error) = SPRequestResultModel.decode(json: json as? NSDictionary)
                    if let model = model {
                        //成功
                        resolver.fulfill( model.models() ?? model.modelsByDataList())
                        
                    } else {
                        self?.dealError(error: error)
                        resolver.reject(error ?? AFError.responseValidationFailed(reason: AFError.ResponseValidationFailureReason.dataFileNil))
                    }
                }else{
                    //失败
                    var customError: Error?
                    if let error = response.result.error{
                        let nserror = error as NSError
                        customError = self?.dealAFCode(error: nserror, statusCode: response.response?.statusCode ?? 0, url: url)
                    }
                    resolver.reject(customError ?? response.result.error ?? AFError.responseValidationFailed(reason: AFError.ResponseValidationFailureReason.dataFileNil))
                }
            }
        }
    }
    open func sendRequestAndDataDecode(apiMethod:String,
                                         host: String? = nil,
                                     method: HTTPMethod = .post,
                                     parameters:[String:Any] = [:],
                                       headers: HTTPHeaders? = nil) -> Promise<SPRequestResultModel?>  {
        return Promise<SPRequestResultModel?> { resolver in
            let url = getUrl(apiMethod: apiMethod, host: host)
            let param = addUserParamAndBaseParams(params: parameters)
            let headers = getApiReqeustHeaders(apiHeaders: headers)
            let encoding: ParameterEncoding = method == .post ? JSONEncoding.default : URLEncoding.default
            self.sessionManager.request(url, method: method, parameters: param, encoding:encoding, headers: headers).responseJSON {[weak self] (response) in
#if DEBUG
                print("url ---- \(url)")
                print("headers ---- \(headers)")
                print("requestParams ---- \(param)")
                print("response ---- \(response)")
#endif
                
                if response.result.isSuccess,
                   let json = response.result.value {
                    let (model, error) = SPRequestResultModel.decode(json: json as? NSDictionary)
                    if let model = model {
                        //成功
                        resolver.fulfill(model)
                        
                    } else {
                        self?.dealError(error: error)
                        resolver.reject(error ?? AFError.responseValidationFailed(reason: AFError.ResponseValidationFailureReason.dataFileNil))
                    }
                }else{
                    //失败
                    var customError: Error?
                    if let error = response.result.error{
                        let nserror = error as NSError
                        customError = self?.dealAFCode(error: nserror, statusCode: response.response?.statusCode ?? 0, url: url)
                    }
                    resolver.reject(customError ?? response.result.error ?? AFError.responseValidationFailed(reason: AFError.ResponseValidationFailureReason.dataFileNil))
                }
            }
        }
    }
    
    ///发送普通请求
    public func sendNormalRequestApi(url:String,
                              method: HTTPMethod = .post,
                              parameters:[String:Any] = [:],
                              headers: HTTPHeaders? = nil) -> Promise<SPRequestResultModel?>  {
        return Promise<SPRequestResultModel?> { resolver in
            let encoding: ParameterEncoding = method == .post ? JSONEncoding.default : URLEncoding.default
            sessionManager.request(url, method: method, parameters: parameters, encoding:encoding, headers: headers).responseString { (response) in
                if response.result.isSuccess , response.response?.statusCode == 200 {
                    let model = SPRequestResultModel()
                    model.code = .success
                    model.httpStatusCode = response.response?.statusCode
                    model.httpResponseData = response.data
                    resolver.fulfill(model)
                }else{
                    //失败
                    resolver.reject(response.result.error ?? AFError.responseValidationFailed(reason: AFError.ResponseValidationFailureReason.dataFileNil))
                }
            }
        }
    }
    
    func getUrl(apiMethod:String,
                host: String? = nil) -> String {
        if apiMethod.hasPrefix("http") {
            return apiMethod
        }
        let url: String
        if let host = host {
            url = host + apiMethod
        } else {
            url = baseUrl() + apiMethod
        }
        return url
    }
    /// 接口返回code通用处理，如token失效
    /// - Parameter error: 错误
    func dealError(error: Error?) {
        guard let error = error as? NetworkError else {
            return;
        }
        switch SPRequestResultModel.Code(rawValue: error.code) {
        case .relogin:
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("kEXUserManagerDidTokenInvalidNotification"), object: nil)
            }
        case .userLogoutByDevice:
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("kEXUserManagerDidTokenInvalidNotification"), object: nil)
            }
        default:
            break
        }
    }
    
    func dealAFCode(error: NSError, statusCode: Int, url: String) -> Error {
        var errorUserInfo = error.userInfo
        var errorString = error.localizedDescription
        switch error.code {
        case -1009:
            errorString = "似乎已断开与互联网的连接"
        case -1017:
            errorString = "数据异常，请重试"
        case -1001:
            errorString = "请求超时，请重试"
        case -1020:
            errorString = "网络连接异常，请检查网络后重试"
        default:
            print("")
        }
        switch statusCode{
        case 500:
            errorString  = "服务器请求异常，请稍后重试"
        default:
            print("")
        }
        errorUserInfo[NSLocalizedDescriptionKey] = errorString
        let tempError = NSError(domain: error.domain, code: error.code, userInfo: errorUserInfo)
        return tempError as Error
    }
}

