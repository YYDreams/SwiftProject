//
//  NMConst.swift
//  NMBaseUI
//
//  Created by flowerflower on 2021/8/15.
//

import Foundation

import UIKit

/// 屏幕的宽
public let kScreenWidth = UIScreen.main.bounds.size.width

/// 屏幕的高
public let kScreenHeight = UIScreen.main.bounds.size.height

/// 屏幕尺寸
public let kScreenBound = UIScreen.main.bounds

/// 状态栏的高度
public let kStatusBarHeight = UIApplication.shared.statusBarFrame.height



//适配比例
public let kRatio = kScreenWidth / 750




// 用户名字
public var kAppName: String {
    get {
        let name = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        return name ?? ""
    }
}

///导航栏高度
public var kNavBarHeight : CGFloat  {
    get {
        return isIphoneX ? 88 : 64
    }
}

/// tabbar高度
public var kTabBarHeight: CGFloat {
    get {
        return isIphoneX ? 83 : 49
    }
}

/// 是否是iPhone X
public var isIphoneX: Bool {
    get {
        return kScreenHeight >= 812 && kScreenHeight < 1024
    }
}

/// 底部安全区域
public var kSafeAreaBottom: CGFloat {
    if #available(iOS 11.0, *) {
        return (UIDevice.current.systemVersion as NSString).floatValue >= 11.0 ? UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0 : 0
    } else {
        return 0
    }
}

/// 5的手机才做比例
public let XE5WidthScale : CGFloat = kScreenWidth < 375.0 ? (kScreenWidth / 375.0) : 1.0
public let XE5HeightScale : CGFloat = kScreenHeight < 667 ? (kScreenHeight / 667) : 1.0

/// 是否是 iPhone5 及以下的小屏幕
public let XEiSiPhone5 : Bool = (kScreenWidth < 375.0) ? true : false

public func FixH(height:CGFloat) -> CGFloat {
    return height * XE5HeightScale
}

public func FixW(width:CGFloat) -> CGFloat {
    return width * XE5WidthScale
}

/** 判断是不是iPhone X 机型 */
// 或者 UIApplication.shared.statusBarFrame.height 状态栏的高，普通手机 20.0  .iPhoneX > 20 = 44.0
public var isIPhoneX: Bool {
    // iPhone X以上设备iOS版本一定是11.0以上。
    get {
        // 利用safeAreaInsets.bottom > 0.0来判断是否是iPhone X以上设备。
        if #available(iOS 11.0, *) {
           let window = UIApplication.shared.delegate?.window
            if (window?!.safeAreaInsets.bottom ?? CGFloat(0.0) > CGFloat(0.0)){
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}

public var isIphone5: Bool {
    get {
        return kScreenWidth < 375 ? true:false
    }
}

/////颜色的方法
public let kThemeColor = UIColor(hex: "E5542A")
//背景色
public let kBgColor =  UIColor(hex: "F2F2F2")

//文字   浅灰色  如提示、正文
public let k6Color = UIColor(hex: "666666")

public let k9Color = UIColor(hex: "999999")

public let kB2Color = UIColor(hex: "B2B2B2")



///颜色的方法
public func UIColorHexFromRGB(rgbValue: Int) -> (UIColor) {
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0, alpha: 1.0)
}

///带有透明度的颜色
public func UIColorWithAlphaRGB(rgbValue: Int,alpha:CGFloat) -> (UIColor) {
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0, alpha: alpha)
}

public func randomColor() ->(UIColor) {
    let red = CGFloat(arc4random()%256)
    let green = CGFloat(arc4random()%256)
    let blue = CGFloat(arc4random()%256)
    return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
}

// MARK: ------------------------- ScrollView & TableView & CollectionView

/// 适配iOS11的contentInsets
public func kAdjustsScrollViewInsets(_ scrollView: UIScrollView) {
    if #available(iOS 11.0, *) {
        scrollView.contentInsetAdjustmentBehavior = .never
    }
}

/// 适配iOS11的Estimated
public func kAdjustTableViewEstimated(_ tableView: UITableView) {
    if #available(iOS 11.0, *) {
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
    }
}

/**< 适配iOS11的IndicatorInsets */
public func kAdjustsScrollViewIndicatorInsets(_ scrollView: UIScrollView, _ edgeInsets: UIEdgeInsets) {
    if #available(iOS 11.0, *) {
        scrollView.scrollIndicatorInsets = edgeInsets
    }
}

/// 分割线的指定inset位置
public func kTableViewChangeSeparatorPace(_ tableViewCell:UITableViewCell, _ edgeInsets: UIEdgeInsets) {
    if #available(iOS 11.0, *) {
        tableViewCell.separatorInset = edgeInsets
        tableViewCell.layoutMargins = edgeInsets
    }
}
/// 获取打印的文件名、打印函数、打印行数
func printLog(_ msg: Any,file: NSString = #file,line: Int = #line,fn: String = #function) {
    #if DEBUG
    let t = String.formatDate(Date(), "yyyy-MM-dd HH:mm:ss")
    let prefix = "\(t) \(file.lastPathComponent) -> \(fn) [第\(line)行] \(msg)";
    print(prefix)
    #endif
}
extension String {
  static func formatDate(_ date:Date,_ format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
     }
 }


//public extension Collection {
//    
//    subscript(safe index: Index) -> Element? {
//        return indices.contains(index) ? self[index] : nil
//    }
//    
//}

