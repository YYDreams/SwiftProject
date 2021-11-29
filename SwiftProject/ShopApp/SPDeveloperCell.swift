//
//  SPDeveloperCell.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/21.
//

import UIKit
import XMUtil
import SnapKit
// MARK: ------------------------- Const/Enum/Struct

extension SPDeveloperCell {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Porpertys {}
    
    /// 外部参数
    struct Params {}
    
}

class SPDeveloperCell: UITableViewCell {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    /// 切换App
    lazy var switchAppBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "icon_type_normal"), for: .normal)
        button.setImage(UIImage(named: "icon_type_selected"), for: .selected)
        button.addTarget(self, action: #selector(switchAppOnClick), for: .touchUpInside)
        button.setImagePosition(.left, spacing: 10)
        button.setTitleColor(UIColor.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.isUserInteractionEnabled = false
        return button
    }()
    // MARK: ------------------------- CycLife
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews(){
        contentView.addSubview(switchAppBtn)
        switchAppBtn.snp.makeConstraints{
            $0.edges.equalTo(UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0))
        }
    }


    
    // MARK: ------------------------- Events
    @objc func switchAppOnClick(){
        self.switchAppBtn.isSelected = !self.switchAppBtn.isSelected
        
        
    }
    
    
    // MARK: ------------------------- Methods
    func  updateSwitchApp(){
        
    }
    
}


