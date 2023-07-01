//
//  BaseEmptyDataView.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/3/25.
//

import Foundation
import UIKit
import SnapKit

enum NetworkStatus{
   case success //网络请求成功
   case failed //网络请求
   case error // 服务器异常
   case nonet // 无网络
}

class BaseEmptyDataView: UIView{
    
//    
//    var pageStatus: NetworkStatus{
//        didSet{
//         
//          
//            
//        }
//    }
    // 点击刷新数据
    var refrashDataBlock: (()->Void)?
    
    /// 内容标题top约束
    var titleLabelTopConstraint: Constraint?
    

    /** 缺省图 */
    public  lazy var imgView : UIImageView = {
        let imgView = UIImageView.init(image: UIImage.init(named: "search_none"))
        imgView.contentMode = .center
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    /** 内容标题 */
   public lazy var titleLabel : UILabel = {
        let lb = UILabel.labelWithTitle("", textColor:UIColor(hexInt: 0x999999), fontSize: 14, aligment: NSTextAlignment.center)
        return lb
    }()
    /** 刷新按钮*/
    public lazy var refrashButton : UIButton = {
        let button = UIButton.init(frame: CGRect.zero)
        button.backgroundColor = UIColor.init(hex: "#B4B4C7")
        button.addTarget(self, action: #selector(refrashButtonOnClick), for: .touchUpInside)
        button.isHidden = true
        button.layer.cornerRadius = 14
        button.setTitle("刷新", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func configData(_ title: String, imageUrl: String) {
        titleLabel.text = title
        imgView.image = UIImage.init(named: imageUrl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   public func updateImageTopMargin(_ topMargin: CGFloat, textTopMargin: CGFloat?)  {
        imgView.snp.remakeConstraints { (make) in
            make.top.equalTo(topMargin)
            make.centerX.equalToSuperview()
        }
        if let textTopMargin = textTopMargin {
            self.titleLabelTopConstraint?.update(offset: textTopMargin)
        }
    }
    public func updateRefrashButtonWidth(width: CGFloat,height:CGFloat)  {
        refrashButton.snp.updateConstraints { (maker) in
            maker.width.equalTo(width)
            maker.height.equalTo(height)
        }
     }
    private func setupUI() {
        self.backgroundColor = UIColor.white
        self.addSubview(imgView)
        self.addSubview(titleLabel)
        self.addSubview(refrashButton)

        imgView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview().offset(-30)
            maker.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            self.titleLabelTopConstraint = maker.top.equalTo(imgView.snp.bottom).offset(24).constraint
            maker.centerX.equalToSuperview()
            maker.height.equalTo(16)
        }
        
        refrashButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(32)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(28)
            maker.width.equalTo(88)
        }
    }
    
    // MARK: 点击刷新数据
    @objc func refrashButtonOnClick() {
        refrashDataBlock?()
    }
}

