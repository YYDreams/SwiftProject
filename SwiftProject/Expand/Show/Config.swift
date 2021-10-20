//
//  Config.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/17.
//

import UIKit

// MARK: ------------------------- Const/Enum/Struct
public enum MaskType {
    case color
    case effect
}


public enum PopViewShowType {
    case top
    case left
    case bottom
    case right
    case center
}

// MARK: ------------------------- ShowPopViewConfig
open class  ShowPopViewConfig {
    
    /// 背景蒙版 毛玻璃
    public var effectStyle = UIBlurEffect.Style.light
    
    /// 点击其他地方是否消失 默认true
    public var clickOtherHidden = true
    
    /// 默认蒙版类型
    public var maskType: MaskType = .color
    
    /// 背景颜色 默认蒙版
    public var backgroundColor = UIColor.black.withAlphaComponent(0.3)
    
    /// 执行动画时间
    public var animateDuration = 0.25
    
    ///动画是否弹性
    public var animateDamping = true
  
    /// 圆角
    public var cornerRadius:CGFloat = 0.0

    /// 指定某几个角为圆角  默认左上 右上
    public var corners:UIRectCorner = [.topLeft, .topRight]
    
    
    /// 弹出视图样式位置
    public var showAnimateType : PopViewShowType? = .center
    
}
