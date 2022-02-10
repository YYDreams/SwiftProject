//
//  XMOrderDetailBindWechatView.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/12/30.
//

import UIKit

class XMOrderDetailBindWechatView: UIView {
    
    var closeBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()
    

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    var bindBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("去绑定", for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubViews(){
        
        addSubview(closeBtn)
        addSubview(titleLabel)
        addSubview(bindBtn)
        
      
        
        
    }
    
}
