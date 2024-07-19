//
//  SPPhotoBrowser.swift
//  SwiftProject
//
//  Created by flower on 2024/5/31.
//

import Foundation
import ZLPhotoBrowser
import Kingfisher
import Photos
import AVFoundation

class ECPhotoBrowser: NSObject {
    
     func getVideoPath(for asset: PHAsset, completion: @escaping (String?) -> Void) {
        // 1. 创建临时的URL用于存储视频
        let outputFileLocation = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(UUID().uuidString).mp4")
     
        // 2. 请求AVAsset
        PHImageManager.default().requestAVAsset(forVideo: asset, options: nil) { (asset, audioMix, info) in
            guard let asset = asset else {
                completion(nil)
                return
            }
            
            // 3. 将视频导出到文件系统
            guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {
                completion(nil)
                return
            }
            
            exportSession.outputURL = outputFileLocation
            exportSession.outputFileType = .mp4
            exportSession.exportAsynchronously {
                switch exportSession.status {
                case .completed:
                    completion(outputFileLocation.path)
                case .failed:
                    completion(nil)
                case .cancelled:
                    completion(nil)
                default:
                    completion(nil)
                }
            }
        }
    }

     
    
    /// 视频选取功能
     func showVideoPicker(container: UIViewController, count: Int, allowPreview:Bool = true, clipRatio: CGFloat = 1.0 , selectionBlock:((Bool, [String])->())? = nil) {
         
          configPhotoThemeColor()
         ZLPhotoConfiguration.default()
            .canSelectAsset { _ in
                true
            }
//            .showClipDirectlyIfOnlyHasClipTool(true)
            .allowEditVideo(false)
//            .showClipDirectlyIfOnlyHasClipTool(true)
//            .showCaptureImageOnTakePhotoBtn(false)
            .allowSelectVideo(true)
            .allowSelectImage(false)
            .maxSelectCount(count)
            .editAfterSelectThumbnailImage(false)
//            .showSelectedPhotoPreview(allowPreview)
            .allowPreviewPhotos(allowPreview)
            .showPreviewButtonInAlbum(allowPreview)
            .noAuthorityCallback { type in
                switch type {
                case .library:
                    debugPrint("No library authority")
                case .camera:
                    debugPrint("No camera authority")
                case .microphone:
                    debugPrint("No microphone authority")
                }
            }

        /// Using this init method, you can continue editing the selected photo
        let ac = ZLPhotoPreviewSheet(results: nil)
        ac.selectImageBlock = { results, isOriginal in
            if results.count > 0 {
                var selectVideoPaths:[String] = []
                var tempSumIndex = 0
                
                for item in results {
                    
                    self.getVideoPath(for: item.asset) { videoPath in
                        if let path = videoPath {
                            selectVideoPaths.append(path)
                        }
                        tempSumIndex = tempSumIndex + 1
                        if tempSumIndex == results.count {
                            selectionBlock?(true, selectVideoPaths)
                        }
                    }
                }
            }else{
                selectionBlock?(false, [])
            }
        }
        ac.cancelBlock = {
            debugPrint("cancel select")
        }
        ac.selectImageRequestErrorBlock = { errorAssets, errorIndexs in
            debugPrint("fetch error assets: \(errorAssets), error indexs: \(errorIndexs)")
        }
        
        DispatchQueue.main.async {
            ac.showPhotoLibrary(sender: container)
        }
    }
    func configPhotoThemeColor(){
        ZLPhotoConfiguration.resetConfiguration()
//        ZLPhotoConfiguration.default().maxSelectVideoDuration = 200 * 60
//        ZLPhotoConfiguration.default().maxSelectVideoTotalSize = 300 //300mb
//        ZLPhotoUIConfiguration.default().bottomToolViewBtnNormalBgColor = UIColor.dominantColor()
//        ZLPhotoUIConfiguration.default().indexLabelBgColor  = UIColor.dominantColor()
//        ZLPhotoUIConfiguration.default().customImageForKey = ["zl_btn_original_selected":UIImage(named: "photo_select")]
//        ZLPhotoUIConfiguration.default().selectedBorderColor = UIColor.dominantColor()
//        ZLPhotoUIConfiguration.default().bottomToolViewBtnNormalBgColorOfPreviewVC = UIColor.dominantColor()
    }

    /// 图片选取功能
    func showImagePicker(container: UIViewController, count: Int, allowEditing: Bool = true, needClip: Bool, allowPreview:Bool = true, clipRatio: CGFloat = 1.0 , selectionBlock:((Bool, [UIImage])->())? = nil, selectionLocalPathBlock:((Bool, [String],[UIImage])->())? = nil) {
                
        configPhotoThemeColor()
        
        if allowEditing {
            if needClip {
                // Custom image editor
                ZLPhotoConfiguration.default()
                    .editImageConfiguration
                    .tools([.clip])
//                    .canRedo(true)
                    .clipRatios([ZLImageClipRatio(title: "封面", whRatio: clipRatio, isCircle: false)])
            }else {
                ZLPhotoConfiguration.default()
                    .editImageConfiguration
//                    .canRedo(false)
            }
        }else {
            ZLPhotoConfiguration.default().allowEditImage(false)
        }
        
        ZLPhotoConfiguration.default()
            // You can first determine whether the asset is allowed to be selected.
            .canSelectAsset { _ in
                true
            }
//            .showClipDirectlyIfOnlyHasClipTool(true)
//            .showCaptureImageOnTakePhotoBtn(false)
            .allowSelectVideo(false)
            .maxSelectCount(count)
            .editAfterSelectThumbnailImage(true)
//            .showSelectedPhotoPreview(allowPreview)
            .allowPreviewPhotos(allowPreview)
            .showPreviewButtonInAlbum(allowPreview)
            .noAuthorityCallback { type in
                switch type {
                case .library:
                    debugPrint("No library authority")
                case .camera:
                    debugPrint("No camera authority")
                case .microphone:
                    debugPrint("No microphone authority")
                }
            }

        /// Using this init method, you can continue editing the selected photo
        let ac = ZLPhotoPreviewSheet(results: nil)
        ac.selectImageBlock = { results, isOriginal in
            if results.count > 0 {
                var selectImgs:[UIImage] = []
                var selectImgPaths:[String] = []
                var tempSumIndex = 0
                
                for item in results {
                    selectImgs.append(item.image)
                    if let _ = selectionLocalPathBlock {
                        item.asset.requestContentEditingInput(with: nil) { contentEditingInput, info in
                            /*
                             两次选了同一张图片 地址不会变换 所以需要改一改
                             file:///var/mobile/Media/DCIM/108APPLE/IMG_8948.PNG
                             file:///var/mobile/Media/DCIM/108APPLE/IMG_8948.PNG
                             */
                            // 替换其一部分，最后再将其与文件路径的其余部分合并
                            if let absoluteString = contentEditingInput?.fullSizeImageURL?.absoluteString,
                               let range = absoluteString.range(of: "IMG_"){
                                // 获取文件名的范围
                                let fileNameRange = range.upperBound..<absoluteString.endIndex
                                // 提取文件名
                                var fileName = absoluteString[fileNameRange]
                                // 替换文件名的部分内容
                                fileName.replaceSubrange(fileName.startIndex..<fileName.index(fileName.startIndex, offsetBy: 4), with: UUID().uuidString)
                                // 将文件名与路径的其余部分合并
                                let orgPath = absoluteString.replacingCharacters(in: fileNameRange, with: fileName)
                                selectImgPaths.append(orgPath)
                                
                            }
                            tempSumIndex = tempSumIndex + 1
                            if tempSumIndex == results.count {
                                selectionLocalPathBlock?(true, selectImgPaths,selectImgs)
                            }
                        }
                    }
                }
                selectionBlock?(true, selectImgs)
            }
        }
        ac.cancelBlock = {
            debugPrint("cancel select")
        }
        ac.selectImageRequestErrorBlock = { errorAssets, errorIndexs in
            debugPrint("fetch error assets: \(errorAssets), error indexs: \(errorIndexs)")
        }
        
        DispatchQueue.main.async {
            ac.showPhotoLibrary(sender: container)
        }
    }
    
    /// 图片预览功能
    func previewImageWith(container: UIViewController, url: [String], index: Int) {
        let vc = ZLImagePreviewController(datas: self.handleImageStringArrToUrlArr(urls: url), index: index, showSelectBtn: false, showBottomView: false) { url -> ZLURLType in
            return .image
        } urlImageLoader: { url, imageView, progress, loadFinish in
            imageView.kf.setImage(with: url) { receivedSize, totalSize in
                let percentage = (CGFloat(receivedSize) / CGFloat(totalSize))
                debugPrint("\(percentage)")
                progress(percentage)
            } completionHandler: { _ in
                loadFinish()
            }
        }
        
        vc.modalPresentationStyle = .fullScreen
        container.view.addSubview(vc.view)
        container.addChild(vc)
//        DispatchQueue.main.async {
//            container.present(vc, animated: true)
//        }
    }
    
//    func takePhoto(container: UIViewController, selectionBlock:((Bool, UIImage?)->())) {
//        let camera = ZLCustomCamera()
//        camera.takeDoneBlock = { image, url in
//            selectionBlock(true, image)
//        }
//        container.showDetailViewController(camera, sender: nil)
//    }
    
    /// 图片预览组件需要传入URL数组，这里做处理
    func handleImageStringArrToUrlArr(urls: [String]) -> [URL] {
        var finalUrls: [URL] = []
        for url in urls {
            if let tempUrl = URL(string: url) {
                finalUrls.append(tempUrl)
            }
        }
        return finalUrls
    }
    
}
