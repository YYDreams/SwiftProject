//
//  UILabel+Extension.swift
//  WuXiaoBo
//
//  Created by CarlXu on 2018/9/27.
//  Copyright © 2018 XiaoE. All rights reserved.
//

import UIKit


public extension UILabel {
    
    /// 自定义初始化方法
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - textColor: 标题颜色, 默认黑色
    ///   - fontSize: 标题字体大小, 默认17
    ///   - aligment: 对齐方式, 默认左对齐
    /// - Returns: label对象
    class func labelWithTitle(_ title: String?,
                                     textColor:UIColor? = UIColor.black,
                                     fontSize: CGFloat = 17,
                                     aligment: NSTextAlignment = NSTextAlignment.left) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = aligment
        return label
    }
    
    /// 设置 Label 某个字符颜色
    ///
    /// - Parameters:
    ///   - text: 字符
    ///   - diffColorStr: 需要改变颜色的字符
    ///   - diffColor: 需要改变颜色的字符颜色
    func setAttrStr(_ diffColorStr: String, diffColor: UIColor) {
        
        guard let text = self.text, text.count > 0 else {
            return
        }
        
        let attrStr = NSMutableAttributedString(string: text)
        if diffColorStr.count > 0  {
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: diffColor, range: (attrStr.string as NSString).range(of: diffColorStr))
        }
        attributedText = attrStr;
    }
    
    /// 设置 Label 多个字符颜色
    ///
    /// - Parameters:
    ///   - text: 字符
    ///   - diffStrColorDict: 需要改变颜色的字符
    func addAttributeManyStr(_ diffStrColorDict: [String: UIColor]) {
        
        guard let text = self.text, text.count > 0 else {
            return
        }
        
        let attrStr = NSMutableAttributedString(string: text)
        
        for (key, value)in diffStrColorDict {
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: value, range: (attrStr.string as NSString).range(of: key))
        }
        
        attributedText = attrStr;
    }
    
    /// 设置 Label 某个字符颜色
    ///
    /// - Parameters:
    ///   - attrDict: 字典
    ///   - str: 需要改变颜色的字符
    func addAttrDict(_ changeStr: String?, attrDict: Dictionary<NSAttributedString.Key, Any>) {
        
        guard let str = changeStr, let text = self.text else {
            return
        }
        
        let attrStr = NSMutableAttributedString(string: text)
        attrStr.addAttributes(attrDict, range: (text as NSString).range(of: str))
        attributedText = attrStr
    }
    
    
    /// 设置行间距
    ///
    /// - Parameters:
    ///   - lineSpacing: 字体行间距，默认行与行之间为default个点的间距，如果小于0则无效
    func setLineSpacing(_ lineSpacing: CGFloat, _ lineBreakMode: NSLineBreakMode = .byTruncatingTail) {
        
        guard let text = self.text, lineSpacing > 0.01 else {
            return
        }
        
        let attrStr = NSMutableAttributedString(string: text)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineBreakMode = lineBreakMode
        
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrStr.length))
        
        attributedText = attrStr
    }
    
    /// 设置 Label keyword 字符颜色
    ///
    /// - Parameters:
    ///   - text: 字符
    ///   - keyword: 需要改变颜色的字符
    ///   - diffColor: 需要改变颜色的字符颜色
    func setAttrKeywordStr(_ keyword: String?, color: UIColor?) {
        
        guard let text = self.text, text.count > 0, let keyword = keyword, let color = color  else {
            return
        }
        
        let attrStr = NSMutableAttributedString(string: text)
        if keyword.count > 0  {
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: (attrStr.string as NSString).range(of: keyword))
        }
        attributedText = attrStr;
    }
    
    // MARK:15、获取文本高度
    /// 使用Label获取文本的高度
    ///
    /// - Parameters:
    ///   - text: 输入的文本
    ///   - font: 文本的字号
    ///   - Labelwidth: 标签的最大宽度
    ///   - lineSpace: 行间距 如果传了行间距那么计算的时候需要使用富文本计算默认0 不传
    /// - Returns: 返回高度
    class public func LabelreHeightWithFont(text:String,
                                     font:UIFont,
                                     Labelwidth:CGFloat,
                                     lineSpace:CGFloat = 0) -> CGFloat {
        let sizelabel = UILabel.labelWithTitle(text, textColor: .clear, fontSize: 15, aligment: .left)
        sizelabel.numberOfLines = 0
        sizelabel.font = font
        sizelabel.width = Labelwidth
        sizelabel.sizeToFit()
        
        return sizelabel.height
    }
}
