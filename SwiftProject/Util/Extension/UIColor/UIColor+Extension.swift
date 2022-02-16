//
//  ColorExtension.swift
//  XEBaseUI_Example
//
//  Created by page on 2019/5/21.
//  Copyright © 2019 xiaoe. All rights reserved.
//

import Foundation
import UIKit

 extension UIColor {
    
    /// 根据十六进制字符串,返回颜色
    ///
    /// - Parameters:
    ///   - hexString: 十六进制字符串，例：“#FFF000”，“0xFFF000”，“FFF000”，
     convenience init(_ hex: String) {
        self.init(hexString: hex, alpha: 1.0)
    }
    
     convenience init?(hex : String, alpha : CGFloat = 1.0) {
        self.init(hexString: hex, alpha: Float(alpha))
    }
    
    /// 根据十六进制,返回颜色
    ///
    /// - Parameters:
    ///   - hexInt: 十六进制，例：0xFFF000
    ///   - alpha: 透明度，默认 1.0
     convenience init(hexInt: Int, alpha: Float = 1.0) {
        let hexString = String(format: "%06X", hexInt)
        self.init(hexString: hexString, alpha: alpha)
    }
    
    /// 根据十六进制字符串,返回颜色
    ///
    /// - Parameters:
    ///   - hexString: 十六进制字符串，例：“#FFF000”，“0xFFF000”，“FFF000”，
    ///   - alpha: 透明度，默认 1.0
     convenience init(hexString: String, alpha: Float = 1.0) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var mAlpha: CGFloat = CGFloat(alpha)
        var minusLength = 0
        
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
            minusLength = 1
        }
        if hexString.hasPrefix("0x") {
            scanner.scanLocation = 2
            minusLength = 2
        }
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        switch hexString.count - minusLength {
        case 3:
            red = CGFloat((hexValue & 0xF00) >> 8) / 15.0
            green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
            blue = CGFloat(hexValue & 0x00F) / 15.0
        case 4:
            red = CGFloat((hexValue & 0xF000) >> 12) / 15.0
            green = CGFloat((hexValue & 0x0F00) >> 8) / 15.0
            blue = CGFloat((hexValue & 0x00F0) >> 4) / 15.0
            mAlpha = CGFloat(hexValue & 0x000F) / 15.0
        case 6:
            red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(hexValue & 0x0000FF) / 255.0
        case 8:
            red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
            green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
            mAlpha = CGFloat(hexValue & 0x000000FF) / 255.0
        default:
            break
        }
        self.init(red: red, green: green, blue: blue, alpha: mAlpha)
    }
    
    /// 根据RGB返回颜色
    ///
    /// - Parameters:
    ///   - r: red色值
    ///   - g: green色值
    ///   - b: blue色值
    ///   - alpha: 透明度
     convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }

    
    /// 根据RGB返回颜色
    ///
    /// - Parameters:
    ///   - red: red色值
    ///   - green: green色值
    ///   - blue: blue色值
    ///   - alpha: 透明度
     convenience init(byteRed red: Int, green: Int, blue: Int, alpha: Float = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
    
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        return (red * 255, green * 255, blue * 255)
    }
    
    /// 设置颜色透明度
     func alpha(_ value: Float) -> UIColor {
        let (red, green, blue, _) = colorComponents()
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(value))
    }
    
     func red(_ value: Int) -> UIColor {
        let (_, green, blue, alpha) = colorComponents()
        return UIColor(red: CGFloat(value)/255.0, green: green, blue: blue, alpha: alpha)
    }
    
     func green(_ value: Int) -> UIColor {
        let (red, _, blue, alpha) = colorComponents()
        return UIColor(red: red, green: CGFloat(value)/255.0, blue: blue, alpha: alpha)
    }
    
     func blue(_ value: Int) -> UIColor {
        let (red, green, _, alpha) = colorComponents()
        return UIColor(red: red, green: green, blue: CGFloat(value)/255.0, alpha: alpha)
    }
    
     func colorComponents() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
    //返回随机颜色
    //返回随机颜色
     class  var  randomColor:  UIColor  {
         get  {
             let  red =  CGFloat (arc4random()%256)/255.0
             let  green =  CGFloat (arc4random()%256)/255.0
             let  blue =  CGFloat (arc4random()%256)/255.0
             return  UIColor (red: red, green: green, blue: blue, alpha: 1.0)
         }
     }

    /// 解析后台返回组件的颜色
    ///
    /// - Parameter color:
//    @discardableResult
//    static  func parseHexColorString(_ color: String?) -> UIColor {
//        var bgColor = UIColorHexFromRGB(rgbValue: 0xF6F6F7)
//        if let color = color {
//            if color.count == 4 {
//                if color == "#fff" {
//                    bgColor =  UIColorHexFromRGB(rgbValue: 0xF6F6F7)
//                } else {
//                    let a = color.subString(start: 1)
//                    let b = color + a
//                    bgColor = UIColor.init(hex: b) ?? UIColorHexFromRGB(rgbValue: 0xF6F6F7)
//                }
//            } else if color.count == 7 {
//                bgColor = UIColor.init(hex: color) ?? UIColorHexFromRGB(rgbValue: 0xF6F6F7)
//            }
//        }
//        return bgColor
//    }
    
}


extension UIColor {
    
    /// 颜色转图片
    ///
    /// - Parameters:
    ///   - size: 返回的图片大小，默认CGSize(width: 1, height: 1)
    /// - Returns: UIImage?
     func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.setFill()
        UIRectFill(rect)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
}
