//
//  SPHomeModuleBaseCell.swift
//  SPHomeUI
//
//  Created by flowerflower on 2021/12/18.
//

import UIKit
// MARK: ------------------------- Const/Enum/Struct

extension SPHomeModuleBaseCell {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Propertys {}
    
    /// 外部参数
    struct Params {}
    
}

class SPHomeModuleBaseCell: UITableViewCell {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    required override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCommonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCommonInit(){
        selectionStyle = .none
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
    }
    
    // MARK: ------------------------- Events
    

    
    // MARK: ------------------------- Methods
    
    // 子类去实现
     public func refreshUI(_ viewModel: Any?){
        
     }
    
    
}
