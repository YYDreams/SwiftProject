////
////  XMLiveManageTheme.swift
////  XMLiveManageUI
////
////  Created by flowerflower on 2021/11/4.
////
//
//import Foundation
//import XETheme
//
//let themeModuleName = "SPSummaryReviewUI"
//let themeBundlePath = Bundle.main.path(forResource: "Frameworks/\(themeModuleName).framework/\(themeModuleName)Resource", ofType: "bundle")
//
//
///// 微页面主题资源
//class XMLiveManageTheme: NSObject {
//    
//    
//    /// 获取图片
//    ///
//    /// - Parameters:
//    ///   - name: 图片名
//    ///   - cache: 是否缓存
//    /// - Returns: 图片
//    static func image(_ name: String,
//                      cache:Bool = false) -> UIImage? {
//        let image = XEThemeReader.themeImage(name: name,
//                                             module: themeModuleName,
//                                             resourceBundlePath: themeBundlePath,
//                                             cache: cache)
//        return image
//    }
//    
//    /// 获取颜色
//    ///
//    /// - Parameters:
//    ///   - key: 颜色值
//    ///   - cache: 是否缓存
//    /// - Returns: 颜色
//    static func color(_ key: XMColorKey,
//                      cache:Bool = false) -> UIColor? {
//        let color = XEThemeReader.themeColor(key: key.rawValue,
//                                             module: themeModuleName,
//                                             resourceBundlePath: themeBundlePath,
//                                             cache: cache)
//        return color
//    }
//    
//    /// 获取私有配置
//    ///
//    /// - Parameters:
//    ///   - key: 键
//    ///   - needdecrypt: 是否加密
//    ///   - cache: 是否缓存
//    /// - Returns: 配置
//    static func privateInfo(_ key: String,
//                            needdecrypt: Bool = false,
//                            cache: Bool = false) -> Any? {
//        let privateInfo = XEThemeReader.themePrivateInfo(key: key,
//                                                         module: themeModuleName,
//                                                         resourceBundlePath: themeBundlePath,
//                                                         needdecrypt: needdecrypt,
//                                                         cache: cache)
//        return privateInfo
//    }
//    
//    /// 获取字体
//    ///
//    /// - Parameters:
//    ///   - fontsize: 字号
//    ///   - weight: 权重
//    ///   - customFontName: 自定义字体名称
//    ///   - cache: 是否缓存
//    /// - Returns: 字体
//    static func font(_ fontsize: CGFloat,
//                     weight: UIFont.Weight = UIFont.Weight.regular,
//                     customFontName: String? = nil,
//                     cache:Bool = false) -> UIFont? {
//        let font = XEThemeReader.themeFont(fontsize: fontsize,
//                                           weight: weight,
//                                           customFontName: customFontName,
//                                           module: themeModuleName,
//                                           resourceBundlePath: themeBundlePath)
//        return font
//    }
//    
//}
