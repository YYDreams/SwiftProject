//
//  File.swift
//  Alamofire
//
//  Created by flowerflower on 2021/10/9.
//

import Foundation
import UIKit
//import SDWebImage


public extension UIImage {
    enum XEGraadientDirection {
        case topToBottom
        case bottomToTop
        case leftToRight
        case rightToLeft
        case custom
    }

//    public class func getGIFImageWithGifName(_ name: String) -> UIImage? {
//        //读取本地的文件
//        let path = Bundle.main.path(forResource: name, ofType: "gif");
//        if let gifPath = path {
//            let url = URL(fileURLWithPath: gifPath)
//            do {
//                let data = try Data(contentsOf: url)
//                return UIImage.sd_image(withGIFData: data)
//            } catch {
//                return nil
//            }
//        }
//        return nil
//    }
    
    /// 创建渐变图片
    /// - Parameters:
    ///   - startColor: 开始颜色
    ///   - endColor: 结束颜色
    ///   - width: 图片宽
    ///   - height: 图片高
    ///   - direction: 渐变方向
    ///   - customStartPoint: 渐变开始点（direction = .custom时生效）
    ///   - customEndPoint: 渐变结束点（direction = .custom时生效）
    /// - Returns: 返回图片
    class func getGradientImage(startColor:UIColor,
                             endColor:UIColor,
                             width: CGFloat,
                             height: CGFloat,
                             direction: XEGraadientDirection = .topToBottom,
                             customStartPoint: CGPoint = .zero,
                             customEndPoint: CGPoint = .zero) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let colors: [CGColor] = [startColor.cgColor,
                                 endColor.cgColor]
        let locations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
        var startPoint: CGPoint = .zero
        var endPoint: CGPoint = .zero
        switch direction {
        case .topToBottom:
            startPoint = CGPoint(x: width / 2, y: 0)
            endPoint = CGPoint(x: width / 2, y: height)
        case .bottomToTop:
            startPoint = CGPoint(x: width / 2, y: height)
            endPoint = CGPoint(x: width / 2, y: 0)
        case .leftToRight:
            startPoint = CGPoint(x: 0, y: height / 2.0)
            endPoint = CGPoint(x: width, y: height / 2.0)
        case .rightToLeft:
            startPoint = CGPoint(x: width, y: height / 2.0)
            endPoint = CGPoint(x: 0, y: height / 2.0)
        case .custom:
            startPoint = customStartPoint
            endPoint = customEndPoint
        }
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: [])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

    
}


// MARK:获取点9图拉伸
public extension UIImage {
    
    public class func getImageWithImageName(imageName: String) -> UIImage {
        
        var image = UIImage(named: imageName)
        
        //图片的中心点
        let width = (image?.size.width ?? 0)/2.0
        let height = (image?.size.height ?? 0)/2.0
        
        let edge = UIEdgeInsets(top: height - 1.0, left: width - 1.0, bottom: height - 1.0, right: width - 1.0)
        
        /**
         方法一. 不包含填充的两种方式
         方法二  同方法一是一样的
         方法三里面的传值是方法一的UIEdgeInsets中的变形
         */
//        image = image?.resizableImage(withCapInsets: edge)
        
        image = image?.resizableImage(withCapInsets: edge, resizingMode: UIImage.ResizingMode.stretch)
        
//        image = image?.stretchableImage(withLeftCapWidth: Int(width), topCapHeight: Int(height))
        
        return image!
    }
    
    public class func getPointNineStretchSImage1(intputimage:UIImage) -> UIImage {
        
        var image = intputimage
        
        //图片的中心点
        let width = (image.size.width )/2.0
        let height = (image.size.height )/2.0
        
        let edge = UIEdgeInsets(top: height - 1.0, left: width + 10.0, bottom: height - 1.0, right: width - 1.0)
        
        /**
         方法一. 不包含填充的两种方式
         方法二  同方法一是一样的
         方法三里面的传值是方法一的UIEdgeInsets中的变形
         */
        //        image = image?.resizableImage(withCapInsets: edge)
        
        image = image.resizableImage(withCapInsets: edge, resizingMode: UIImage.ResizingMode.stretch)
        
        // image = image?.stretchableImage(withLeftCapWidth: Int(width), topCapHeight: Int(height))
        
        return image
    }
}
