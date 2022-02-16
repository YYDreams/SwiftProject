//
//  UIViewExtensions.swift
//  XEBaseUI_Example
//
//  Created by page on 2019/5/17.
//  Copyright © 2019 xiaoe. All rights reserved.
//

import Foundation
import UIKit


extension UIView {

    
    // MARK :设置视图圆角
    public func setCornerRadius(_ radius:CGFloat) -> Void {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    /// 自定义切圆角
    ///
    /// - Parameter:
    ///   - coroners: 数组， 例：[.topLeft, .bottomLeft]
    ///   - cornerRadii: 圆角半径
    public func addCorner(_ coroners: UIRectCorner = UIRectCorner.allCorners, cornerRadii: CGFloat)  {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: coroners, cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        cornerLayer.path = path.cgPath
        layer.mask = cornerLayer
    }
    
    public func addCorner(_ coroners: UIRectCorner = UIRectCorner.allCorners, cornerRadii: CGFloat, roundedRect: CGRect)  {
        let path = UIBezierPath(roundedRect: roundedRect, byRoundingCorners: coroners, cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        cornerLayer.path = path.cgPath
        layer.mask = cornerLayer
    }
    
    /// 画底部虚线
    ///
    /// - Parameter:
    ///   - lineLength: 每一小块虚线的长度
    ///   - lineSpacing: 虚线间隔
    ///   - lineColor: 虚线颜色
    public func drawDashedLine(_ lineLength : Int, lineSpacing : Int, lineColor: UIColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = bounds
        /// 只要是CALayer这种类型,他的anchorPoint默认都是(0.5,0.5)
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength),NSNumber(value: lineSpacing)]
        let path = CGMutablePath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    /// 画顶部实线
    ///
    /// - Parameter:
    ///   - lineColor: 线颜色，默认lightGray
    public func addLineUp(_ lineColor: UIColor = UIColor.lightGray) {
        let line = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 0.5))
        line.backgroundColor = lineColor
        addSubview(line)
    }
    
    /// 画底部实线
    ///
    /// - Parameter:
    ///   - lineColor: 线颜色，默认lightGray
    public func addLineBottom(_ lineColor: UIColor = UIColor.lightGray) {
        let line = UIView(frame: CGRect(x: 0, y:frame.size.height, width: frame.size.width, height: 0.5))
        line.backgroundColor = lineColor
        addSubview(line)
    }
    
    public func drawDefaultDotLineInView(_ lineView: UIView)  {
        if let color = UIColor(hex: "#818181"){
            drawDashLineInView(lineView, lineLength: 0.5, lineSpacing: 3, lineColor: color)
        }
    }
    
    func drawDashLineInView(_ lineView : UIView, lineLength : Float, lineSpacing : Int, lineColor: UIColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = lineView.bounds
        // 只要是CALayer这种类型,他的anchorPoint默认都是(0.5,0.5)
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineView.frame.size.height
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength),NSNumber(value: lineSpacing)]
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        let endPointX = lineView.frame.size.width == 0 ? kScreenWidth-32 : lineView.frame.size.width
        path.addLine(to: CGPoint(x: endPointX, y: 0))
        shapeLayer.path = path
        lineView.layer.sublayers?.removeAll()
        lineView.layer.addSublayer(shapeLayer)
    }
    
    
    /// 对view进行截图
    ///
    /// - Parameter size: 画板大小
    /// - Returns: 返回图片对象
    public func screenShot(size: CGSize) -> UIImage? {
        guard size.height > 0 && size.width > 0 else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    /// 显示阴影
    public func needshadow (Opacity: Float,
                            color:UIColor,
                            size:CGSize,
                            Radius:CGFloat) {
        self.layer.shadowOpacity = Opacity
        self.layer.shadowColor = color.withAlphaComponent(0.05).cgColor
        self.layer.shadowOffset = size
        self.layer.shadowRadius = Radius
    }
    
    
}


extension UIView {
    
    /// y
    public var x : CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var f = self.frame
            f.origin.x = newValue
            self.frame = f
        }
    }
    
    /// y
    public var y : CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var f = self.frame
            f.origin.y = newValue
            self.frame = f
        }
    }
    
    public var top:CGFloat{
        get {
            return self.frame.origin.y
        }
        set(newtop) {
            var frame = self.frame
            frame.origin.y = newtop
            self.frame = frame
        }
    }
    
    public var left:CGFloat{
        get {
            return self.frame.origin.x
        }
        set(newleft) {
            var frame = self.frame
            frame.origin.x = newleft
            self.frame = frame
        }
    }
    
    public var right:CGFloat{
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set(newright) {
            var frame = self.frame
            frame.origin.x = newright - frame.size.width
            self.frame = frame
        }
    }
    
    public var bottom:CGFloat{
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set(newbottom) {
            var frame = self.frame
            frame.origin.y = newbottom - frame.size.height
            self.frame = frame
        }
    }
    
    public var width:CGFloat{
        get {
            return self.frame.size.width
        }
        set(newwidth) {
            var frame = self.frame
            frame.size.width = newwidth
            self.frame = frame
        }
    }
    
    
    public var height:CGFloat{
        get {
            return self.frame.size.height
        }
        set(newheight) {
            var frame = self.frame
            frame.size.height = newheight
            self.frame = frame
        }
    }
    
    
    public var centerX:CGFloat{
        get {
            return self.center.x
        }
        set(newcenterX) {
            var center = self.center
            center.x = newcenterX
            self.center = center
        }
    }
    
    public var centerY:CGFloat{
        get {
            return self.center.y
        }
        set(newcenterY) {
            var center = self.center
            center.y = newcenterY
            self.center = center
        }
    }
    
    public var origin:CGPoint{
        get {
            return self.frame.origin
        }
        set(neworigin) {
            var frame = self.frame;
            frame.origin = neworigin;
            self.frame = frame;
        }
    }
    
    public var size:CGSize{
        get {
            return self.frame.size
        }
        set(newsize) {
            var frame = self.frame
            frame.size = newsize;
            self.frame = frame;
        }
    }
}



public enum ShakeDirection: Int {
    case horizontal
    case vertical
}

extension UIView {
    
    ///  扩展UIView增加抖动方法
    ///
    /// - Parameters:
    ///   - direction:  抖动方向    默认水平方向
    ///   - times:      抖动次数    默认5次
    ///   - interval:   每次抖动时间 默认0.1秒
    ///   - offset:     抖动的偏移量 默认2个点
    ///   - completion: 抖动结束回调
    public func shake(direction: ShakeDirection = .horizontal,
                      times: Int = 5,
                      interval: TimeInterval = 0.1,
                      offset: CGFloat = 3,
                      completion: (() -> Void)? = nil) {
        
        //移动视图动画（一次）
        UIView.animate(withDuration: interval, animations: {
            switch direction {
                case .horizontal:
                    self.layer.setAffineTransform(CGAffineTransform(translationX: offset, y: 0))
                case .vertical:
                    self.layer.setAffineTransform(CGAffineTransform(translationX: 0, y: offset))
            }
            
        }) { (complete) in
            //如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: {
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) in
                    completion?()
                })
            }
            
            //如果当前不是最后一次，则继续动画，偏移位置相反
            else {
                self.shake(direction: direction, times: times - 1, interval: interval, offset: -offset, completion: completion)
            }
        }
    }
}
