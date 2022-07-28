//
//  SPShowConfig.swift
//  SwiftProject
//
//  Created by flower on 2022/5/24.
//

import Foundation
import UIKit

public enum PopViewShowType {
    case top   // 未实现（开发中用到的几率几乎为0）
    case left  // 未实现（开发中用到的几率几乎为0）
    case bottom
    case right // 未实现（开发中用到的几率几乎为0）
    case center
}


//弹框样式
public class SPShowConfig{
    
    // --------------------Const--------------------

    // 点击其他地方是否消失 默认true
    public var clickOtherHidden = true
    
    /** 是否是自动触发，默认手动触发 。如果是自动触发需将其设为true 以防止不停的添加在window上
     *   eg:
     *   1、【手动触发】点击按钮触发的
     *   2、【自动触发】定时器触发，通过接口触发
     */
    public var isAutoTrigger = false
    
    // 弹出视图样式位置
    public var showAnimateType : PopViewShowType? = .center
    
    // 背景颜色 默认蒙版
    public var backgroundColor : UIColor = UIColor.black.withAlphaComponent(0.5)
    
    // 执行动画时间
    public var animateDuration = 0.25
    
    // 圆角
    public var cornerRadius:CGFloat = 12.0
    
    // 指定某几个角为圆角
    public var corners:UIRectCorner = []
        
    // 最大宽度
    public var maxWidth : CGFloat = UIScreen.main.bounds.size.width - 88.0
    
    // 最大高度
    public var maxHeight : CGFloat = 500

    
    // --------------------标题--------------------
    
    // 标题字体大小
    public var  titleFont: UIFont = UIFont.boldSystemFont(ofSize: 16)
    
    // 标题字体颜色
    public var titleColor: UIColor = UIColor(hexInt: 0x222427)
    
    // title距离顶部的距离
    public var titleTopSpacing : CGFloat = 26
    
    
    // --------------------副标题--------------------
    
    // 具体内容字体大小
    public var  contentFont: UIFont = UIFont.systemFont(ofSize: 14)
    
    // 具体内容字体颜色
    public var contentColor: UIColor = UIColor(hexInt: 0x4F5356)
    
    // content距离title的距离
    public var contentTopSpacing : CGFloat = 12
    
    // content相对于弹框距离左边的间距
    public var contentLeftSpacing : CGFloat = 16
    

    
    // --------------------底部按钮--------------------

    // 底部按钮的高度
    public var buttonHeight:CGFloat = 44
    
    // 底部按钮的背景颜色
    public var bottomBtnColor : UIColor = UIColor.white
    
    // button距离content之前的间距的距离
    public var buttonTopSpacing : CGFloat = 28
    
    //按钮字体
    public var buttonFont : UIFont = UIFont.systemFont(ofSize: 16)
    
    // 按钮圆角大小
    public var  buttonRadius : CGFloat = 0
    
    // 按钮之间的间距（左边按钮与右边按钮）
    open var buttonSpacing: CGFloat = 0
    
    // 底部按钮距离底部的间距
    public var bottomSpacing : CGFloat = 0
    
    // 左边按钮间距
    public var  leftBtnSpacing : CGFloat = 0
    
    // 左边按钮字体颜色
    public var leftBtnTitleColor : UIColor = UIColor(hexInt: 0x323233)
    
    // 左边按钮边框的宽度
    public var leftBtnBorderWidth : CGFloat = 0
    
    // 左边按钮边框的颜色
    public var leftBtnBorderColor : UIColor = UIColor.white
    
    // 右边按钮间距
    public var  rightBtnSpacing : CGFloat = 0
    
    // 右边按钮字体颜色
    public var rightBtnTitleColor : UIColor = UIColor(hexInt: 0x0165B8)
    
    // 右边按钮边框的宽度
    public var rightBtnBorderWidth : CGFloat = 0
    
    // 右边按钮边框的颜色
    public var rightBtnBorderColor : UIColor = UIColor.white
    
    // 当line颜色高度大于0才会显示
    public var lineHeight: CGFloat = 1
    
    // 按钮上面的线条颜色
    public var lineColor: UIColor = UIColor(hexInt: 0xDCE0E4)
    
}


