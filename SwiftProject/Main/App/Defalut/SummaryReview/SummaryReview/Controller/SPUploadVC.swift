//
//  SPUploadVC.swift
//  SwiftProject
//
//  Created by flower on 2024/5/31.
//

import Foundation
import SnapKit
import AVFoundation
class SPUploadVC: UIViewController{
    
    var uploadImages = [SPUploadModel]()  //全部选中的
    
    lazy var uploadImageBtn: UIButton = {
        let tempBtn = UIButton()
        tempBtn.setTitle("上传图片", for: .normal)
        tempBtn.setTitleColor(kThemeColor, for: .normal)
        tempBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        tempBtn.addTarget(self, action: #selector(uploadImageBtnOnClick), for: .touchUpInside)
        tempBtn.layer.borderWidth = 0.8
        tempBtn.layer.borderColor = kThemeColor?.cgColor
        tempBtn.setCornerRadius(20)
        return tempBtn
    }()
    lazy var uploadVideoBtn: UIButton = {
        let tempBtn = UIButton()
        tempBtn.setTitle("上传视频", for: .normal)
        tempBtn.backgroundColor = kThemeColor
        tempBtn.setTitleColor(UIColor.white, for: .normal)
        tempBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        tempBtn.addTarget(self, action: #selector(uploadVideoBtnOnClick), for: .touchUpInside)
        tempBtn.setCornerRadius(20)
        return tempBtn
    }()
    lazy var uploadImageView: SPUploadView = {
        let tempBtn = SPUploadView()
        tempBtn.backgroundColor = UIColor.randomColor
        return tempBtn
    }()
    lazy var uploadVideoView: SPUploadView = {
        let tempBtn = SPUploadView()
        tempBtn.backgroundColor = UIColor.randomColor
        return tempBtn
    }()
    lazy var stateBtn: UIButton = {
        let button = UIButton.init(frame: CGRect.zero)
        button.backgroundColor = kThemeColor
        button.addTarget(self, action: #selector(stateOnClick), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("单个暂停", for: .normal)
        button.setTitle("单个继续", for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    lazy var allStateBtn: UIButton = {
        let button = UIButton.init(frame: CGRect.zero)
        button.backgroundColor = kThemeColor
        button.addTarget(self, action: #selector(allStateOnClick), for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("全部暂停", for: .normal)
        button.setTitle("全部继续", for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    
    
    func setupSubViews(){
        view.backgroundColor = .white
        view.addSubview(uploadImageBtn)
        view.addSubview(uploadVideoBtn)
        view.addSubview(uploadImageView)
        view.addSubview(uploadVideoView)
        view.addSubview(stateBtn)
        view.addSubview(allStateBtn)
        
        
        uploadImageBtn.snp.makeConstraints{
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(80)
            $0.height.equalTo(40)
        }
        uploadImageView.snp.makeConstraints{
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalTo(uploadImageBtn.snp.bottom).offset(10)
            $0.height.equalTo(230)
        }
        
        uploadVideoBtn.snp.makeConstraints{
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalTo(uploadImageView.snp.bottom).offset(12)
            $0.height.equalTo(40)
        }
        uploadVideoView.snp.makeConstraints{
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalTo(uploadVideoBtn.snp.bottom).offset(10)
            $0.height.equalTo(230)
        }
        stateBtn.snp.makeConstraints{
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(uploadVideoView.snp.bottom).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(60)
        }
        allStateBtn.snp.makeConstraints{
            $0.left.equalTo(stateBtn.snp.right).offset(20)
            $0.top.height.width.equalTo(stateBtn)
        }
        
    }
    @objc func stateOnClick(){
        if kArrayIsEmpty(uploadVideoView.videoDataArr){
            HudManager().showHudText("先上传一个先")
            return
        }
        stateBtn.isSelected = !stateBtn.isSelected
        uploadVideoView.videoDataArr.forEach { item in
            print("--222-1--\(item.progress) \(item.localFileId) ")
        }
        let model =  uploadVideoView.videoDataArr.first(where: {$0.progress < 1})
        let localFileId: String = model?.localFileId ?? ""
        if stateBtn.isSelected{
            SPTXUploadManager.share.cancelPublish(localFileId: localFileId)
        }else{
            SPTXUploadManager.share.resumePublishVideo(localFileId: localFileId)
        }
    }
    @objc func allStateOnClick(){
        if kArrayIsEmpty(uploadVideoView.videoDataArr){
            HudManager().showHudText("先上传一个先")
            return
        }
        uploadVideoView.videoDataArr.forEach { item in
            print("--22-2--\(item.progress) \(item.localFileId) ")
        }
        allStateBtn.isSelected = !allStateBtn.isSelected

        if allStateBtn.isSelected{
            SPTXUploadManager.share.cancelAllPublish()
        }else{
            SPTXUploadManager.share.resumeAllPublishVideo()
        }
    }
    
    
    
    @objc func uploadImageBtnOnClick(){
        ECPhotoBrowser().showImagePicker(container: self, count: 6, allowEditing: false, needClip: false, allowPreview:true,selectionBlock: { _, _ in
        },selectionLocalPathBlock: {[weak self] success, paths, images in
            if success , images.count > 0 {
                guard let self = self else { return  }
                self.uploadAllImageToserver(images: images,imagePaths: paths)
            }
        })
    }
    @objc func uploadVideoBtnOnClick(){
        ECPhotoBrowser().showVideoPicker(container: self, count: 6, allowPreview:true)  {[weak self] success, videos in
            if success , videos.count > 0 {
                guard let self = self else { return  }
                self.uploadAllVideoToserver(videos: videos)
            }
        }
    }
    /// 上传全部图片
    /// - Parameters:
    ///   - videos: 图片数组
    func uploadAllImageToserver(images:[UIImage], imagePaths:[String]){
        var currentUploadModes = [SPUploadModel]()  //每次切到图库选中的数组
        for (index,localPath) in imagePaths.enumerated(){
            let model = SPUploadModel()
            model.localFileId = localPath.lastPathComponent
            let i = images[index]
            model.image = i
            if  let data = i.jpegData(compressionQuality: 1){
                model.imgData = data
            }
            currentUploadModes.append(model)
            uploadImages.append(model)
            startUpload(type: .image, model: model)
        }
        self.uploadImageWithModels(models: currentUploadModes)
    }
  
    /// 上传全部视频
    /// - Parameters:
    ///   - videos: 图片数组
    func uploadAllVideoToserver(videos:[String]){
        var currentUploadModes = [SPUploadModel]()  //每次切到图库选中的数组
        for (index,localPath) in videos.enumerated(){
            guard let pathUrl = kIsSimulator() ? URL(string: localPath) : URL(string:"file://" +  localPath) else {return}
            
            let model = SPUploadModel()
            model.localFileId = localPath.lastPathComponent
            model.filePath = localPath
            model.totalSize = Int(getFileSize(pathUrl))
            model.uploadType = .video
            currentUploadModes.append(model)
//            self.uploadImages.append(model)
            getVideoImage(url: pathUrl.absoluteString) { [weak self] image in
                guard let self = self else { return  }
                model.image = image
                self.startUpload(type: .video, model: model)
            }
        }
       
        self.uploadVideoWithModels(models: currentUploadModes)
    }
    /// 批量上传图片
    /// - Parameters:
    ///   - models: 需要上传的数组模型
    ///   - callback: 当前模型
    private func uploadImageWithModels(models:[SPUploadModel]) {
        SPTXUploadManager.share.transferBatchUploadObjects(models: models) { uploadModel in
            DispatchQueue.main.async {
                if let localFileId = uploadModel?.localFileId{
                    self.syncUploadProgess(type: .image, localFileId: localFileId, progress: uploadModel?.progress ?? 0)
                }
            }
        } finishBlock: { [weak self] uploadModel in
            guard let self = self else { return  }
          
            DispatchQueue.main.async {
                if let _ = uploadModel?.url, let localFileId = uploadModel?.localFileId {
                    
                    self.uploadSuccess(type: .image, localFileId: localFileId,progress:1)
                }else{
                    self.uploadFail(code: 1, type: .image, msg: "上传失败", localFileId: uploadModel?.localFileId ?? "", source: "腾讯云")
                }
            }
        } failBlock: { uploadModel, error in
            if let err = (error as? NSError) {
                self.uploadFail(code: err.code, type: .image, msg: err.localizedDescription, localFileId: uploadModel?.localFileId ?? "", source: "腾讯云")
            }else if let error  = (error as? NetworkError){
                self.uploadFail(code: error.code, type: .image, msg: error.localizedDescription, localFileId: uploadModel?.localFileId ?? "", source: "获取签名")
            }
        }
    }

    /// 批量上传视频
    /// - Parameters:
    ///   - models: 需要上传的数组模型
    ///   - callback: 当前模型
    private func uploadVideoWithModels(models:[SPUploadModel]) {
        SPTXUploadManager.share.transferBatchUploadVideos(userId: "u_66306aff8a95b_WPqQ7Wuutt",models: models) { uploadModel in
            DispatchQueue.main.async {
                if let localFileId = uploadModel?.localFileId{
                    self.syncUploadProgess(type:.video,localFileId: localFileId, progress: uploadModel?.progress ?? 0)
                }
            }
        } finishBlock: { [weak self] uploadModel in
            guard let self = self,
                  let code = uploadModel?.retCode else { return  }
            print("uploadModel-----\(uploadModel?.progress) \(uploadModel?.retCode)")
            DispatchQueue.main.async {
                if code == 0  || code == 1017{
                    self.uploadSuccess(type: .video, localFileId: uploadModel?.localFileId ?? "",progress:uploadModel?.progress ?? 0)
                }else{
                    self.uploadFail(code: 1, type: .video, msg: "上传失败", localFileId: uploadModel?.localFileId ?? "", source: "腾讯云")
                }
            }
        } failBlock: { uploadModel, error in
            if let err = (error as? NSError) {
                self.uploadFail(code: err.code, type: .video, msg: err.localizedDescription, localFileId: uploadModel?.localFileId ?? "", source: "腾讯云")
            }else if let error  = (error as? NetworkError){
                self.uploadFail(code: error.code, type: .video, msg: error.localizedDescription, localFileId: uploadModel?.localFileId ?? "", source: "获取签名")
            }
        }
    }
    
    /// 准备开始上传(用于渲染UI)
    /// - Parameters:
    ///   - type: 上传的类型
    ///   - model: 当前模型
    private func startUpload(type: SPUploadType, model:SPUploadModel) {
        
        if type == .image{
            uploadImageView.imageDataArr.append(model)
        }else{
            uploadVideoView.videoDataArr.append(model)
        }
    }
    
    /// 同步进度(id + progess)
    private func syncUploadProgess(type: SPUploadType, localFileId: String,progress:Double) {
        if type == .image{
            uploadImageView.reloadItem(type: type, localFileId: localFileId, progress: progress)
        }else{
            uploadVideoView.reloadItem(type: type, localFileId: localFileId, progress: progress)
        }
    }
    
    /// 上传成功
    private func uploadSuccess(type: SPUploadType, localFileId: String, progress:Double){
        if type == .image{
            uploadImageView.reloadItem(type: type, localFileId: localFileId, progress: progress)
        }else{
            uploadVideoView.reloadItem(type: type, localFileId: localFileId, progress: progress)
        }
    }
    
    /// 上传失败
    /// - Parameters:
    ///   - type: 上传的类型
    ///   - code: 腾讯云返回的code码或者同步素材后台给的code码
    ///   - msg: 腾讯云返回的错误信息或者同步素材后台给的错误信息
    ///   - localFileId: 表示是哪个视频上传过程中出现异常
    ///   - source: 来源(获取签名or腾讯云or同步素材)
    private func uploadFail(code:Int,type: SPUploadType, msg: String? ,localFileId:String?, source:String?) {
        print("code:\(code)type:\(type) msg:\(msg) localFileId:\(localFileId) source:\(source)")
    }
    
    /// 获取视频第一帧
    func getVideoImage(url: String , result block: @escaping (UIImage?) -> Void) {
        var videoURL = URL(fileURLWithPath: url.removingPercentEncoding ?? "")
        let asset = AVURLAsset(url: videoURL)
        let assetGen = AVAssetImageGenerator(asset: asset)
        let time = CMTime(seconds: 0,preferredTimescale: 30)
        assetGen.generateCGImagesAsynchronously(forTimes: [NSValue(time: time)]) { requestedTime, image, actualTime, result, error in
            if let cgImage = image,result == .succeeded{
                let thumbnailImage = UIImage(cgImage: cgImage)
                let newImage = thumbnailImage.xet_resizeImage(image: thumbnailImage, to: CGSize(width: 50, height: 50),quality: .low)
                DispatchQueue.main.async {
                    block(newImage)
                }
            }else{
                print("Failed to generate thumbnail image: \(error?.localizedDescription ?? "Unknown error")")
                block(nil)
            }
        }
    }
    /// MARK:  获取本地文件大小
    func getFileSize(_ filepath: URL) -> NSNumber {
        var fileAttributes: [FileAttributeKey : Any]
        do {
            try fileAttributes = FileManager.default.attributesOfItem(atPath: filepath.path)
            let fileSize = fileAttributes[FileAttributeKey.init(rawValue: "NSFileSize")] as! Int64
            print("File Size", fileSize)
            print("File Path", filepath)
            return NSNumber(value: fileSize)
        } catch {
            print("File Size Error \(error)")
            return NSNumber.init(value: INT64_MAX)
        }
    }
}

