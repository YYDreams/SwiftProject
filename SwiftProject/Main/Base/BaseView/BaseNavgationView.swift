//
//  BaseNavgationView.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/11/26.
//

import UIKit
import XMUtil
public protocol XEBaseNavDelegate :NSObjectProtocol {
    func leftBtnClick (leftBtn :UIButton)
    func rightBtnClick (rightBtn :UIButton)
}


public class XEBaseNavgationView: UIView {
    
    weak  public var delegate :XEBaseNavDelegate?
    // view 点击回调
    public var leftClickBlock: (()->Void)?
    // view 点击回调
    public var rightClickBlock: (()->Void)?


    /// 左侧图片对象
    open var leftBtnImg: UIImage?{
        didSet{
            leftBtn.setImage(leftBtnImg, for: UIControl.State.normal)
        }
    }
    
    
    /// 左侧图片名
    open var leftImgName: String?{
        didSet{
            leftBtn.setImage(UIImage(named: leftImgName ?? ""), for: UIControl.State.normal)
        }
    }
    
    /// 左侧标题
    open var leftBtnTitle: String?{
        didSet{
            leftBtn.setTitle(leftBtnTitle, for: UIControl.State.normal)
        }
    }
    
    /// 右侧图片对象
    open var rightBtnImg: UIImage?{
        didSet{
            rightBtn.setImage(rightBtnImg, for: UIControl.State.normal)
        }
    }
    
    /// 右侧图片名
    open var rightImgName: String?{
        didSet{
            rightBtn.setImage(UIImage(named: rightImgName ?? ""), for: UIControl.State.normal)
        }
    }
    
    /// 右侧文字
    open var rightBtnTitle: String?{
        didSet{
          rightBtn.setTitle(rightBtnTitle, for: UIControl.State.normal)
          let rightwidth = 44
//            ToolObject.StringreSizeWithFont(text: rightBtnTitle ?? "",
//                                                           font:UIFont.systemFont(ofSize: 14), Labelwidth: 100).width
          if (rightwidth <= 44) {return;}
          rightBtn.sizeToFit()
          rightBtn.snp.updateConstraints { (make) in
              make.width.equalTo(ceilf(Float(rightwidth)));
              make.height.equalTo(44)
          }
        }
    }

    /// 标题
    public var titleName:String?{
        didSet{
            titleLabel.text = titleName
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    public func setupUI() {
        addSubview(leftBtn)
        addSubview(titleLabel)
        addSubview(rightBtn)
        addSubview(lineLabel)
        
        leftBtn.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(self).offset(kStatusBarHeight)
            make.height.width.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.center.x)
            make.width.equalTo(kScreenWidth - 2*80)
            make.centerY.equalTo(kStatusBarHeight + 22)
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.width.height.equalTo(44)
            make.top.equalTo(kStatusBarHeight)
        }
        
        lineLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
    }
    
    @objc func navleftBtnClick(leftBtn :UIButton) {
        delegate?.leftBtnClick(leftBtn: leftBtn)
    }
    
    @objc func navrightBtnClick(rightBtn :UIButton) {
        delegate?.rightBtnClick(rightBtn: rightBtn)
        rightClickBlock?()
    }
    
/*  懒加载  */
    lazy open var leftBtn: UIButton = {
        let leftBtn = UIButton()
        leftBtn .addTarget(self, action: #selector(navleftBtnClick), for: .touchUpInside)
        leftBtn.contentHorizontalAlignment = .left
        return leftBtn
    }()
    
    lazy open var rightBtn: UIButton = {
        let rightBtn = UIButton()
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightBtn.setTitleColor(UIColor(hex: "#999999"), for: UIControl.State.normal)
        rightBtn.contentHorizontalAlignment = .right
        rightBtn .addTarget(self, action: #selector(navrightBtnClick), for: .touchUpInside)
        return rightBtn
    }()
    
    lazy open var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.init(name: "PingFangSC-Medium", size: 18)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.lineBreakMode = NSLineBreakMode.byTruncatingMiddle
        return titleLabel
    }()
    
    lazy open var lineLabel: UILabel = {
        let label = UILabel.init()
        label.backgroundColor = UIColor.init("#EEEEEE")
        return label
    } ()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
