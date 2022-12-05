//
//  Foundation.swift
//  XMUtil
//
//  Created by flowerflower on 2021/10/20.
//

import Foundation
import UIKit
import UIKit
import Photos
public extension Collection {
    
    subscript(safe index: Index) -> Element? {
        
        return indices.contains(index) ? self[index] : nil
    }
    
}

public extension Array {
    // 数组去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}


extension String{
    
    //计算文本的size
public func caculateTextSize(text:String?,font:UIFont?,maxWidth:CGFloat = CGFloat.greatestFiniteMagnitude,maxHeight:CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize{
    
    guard (text != nil), (text!.count > 0), (font != nil) else {
        return .zero
    }
    
    return (text! as NSString).boundingRect(with: CGSize(width: maxWidth, height: maxHeight),
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font!],
                                            context: nil).size
    }
    
}
// 获取当前时间
/// - Parameter timeFormat: 时间类型，TimeFormat为枚举
public  func getCurrentTime(timeFormat:String = "YYYY-MM-dd HH:mm:ss") -> String{
    
    let formatter = DateFormatter()
    formatter.dateFormat = timeFormat
    let timezone = TimeZone.init(identifier: "Asia/Beijing")
    formatter.timeZone = timezone
    let dateTime = formatter.string(from: Date.init())
    return dateTime
    
}


class SPAlbumManager: NSObject {
    
    /// 检测相册访问权限
    ///
    /// - Parameter authorizedBlock: 权限状态
    static public func checkPhotoAuthState(_ authorizedBlock:((Bool)-> Void)? = nil){
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .restricted, .denied:
            /// 无权限
            HudManager().showHudText("请配置相册访问权限")
            break
        case .notDetermined:
            /// 未授权,需要给开发系统plist提示添加Privacy - Photo Library Usage Description 权限
            let dic = Bundle.main.infoDictionary
            /// 提醒程序员加访问相册plist文件key
            /// 访问相册权限
            guard let dicD = dic, dicD.keys.contains("NSPhotoLibraryUsageDescription") else {
                HudManager().showHudText("请配置相册访问权限")
                return
            }
           
            PHPhotoLibrary.requestAuthorization { (authorizationStatus) in
                DispatchQueue.main.async {
                    if (authorizationStatus == .authorized) {
                        authorizedBlock?(true)
                    } else {
                        authorizedBlock?(false)
                    }
                }
            }
            break
        case .authorized:
            /// 已经授权
            DispatchQueue.main.async {
                authorizedBlock?(true)
            }
            break
        default:
            break
        }
    }
    
    /// 保存图片到相册方法
    ///
    /// - Parameters:
    ///   - image: 图片资源
    ///   - finishBlock: 保存是否成功回调
    static public func saveImageToAlbum(image: UIImage, _ finishBlock:((Bool)-> Void)? = nil) {
        SPAlbumManager.checkPhotoAuthState(){ authorized in
            if authorized {
//              if let _ = try? PHPhotoLibrary.shared().performChangesAndWait({
//                    PHAssetChangeRequest.creationRequestForAsset(from: image)
//              }) {
//
//            }
                
                
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }, completionHandler: { (success, error) in
                    if success {
                        /// 保存成功
                        DispatchQueue.main.async {
                            finishBlock?(true)
                        }
                    } else {
                        /// 保存失败
                        DispatchQueue.main.async {
                            finishBlock?(false)
                        }
                    }
                })
            } else {
                /// 保存失败
                DispatchQueue.main.async {
                    finishBlock?(false)
                }
            }
        }
    }
}



    

    

