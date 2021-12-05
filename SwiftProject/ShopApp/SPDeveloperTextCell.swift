//
//  SPDeveloperTextCell.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/12/4.
//

import Foundation
import XMUtil
import SnapKit
// MARK: ------------------------- Const/Enum/Struct

extension SPDeveloperTextCell {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Porpertys {}
    
    /// 外部参数
    struct Params {}
    
}

class SPDeveloperTextCell: UITableViewCell {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    ///
   public  var titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 15)
        return title
    }()
    public   var subTitleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 15)
        return title
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        titleLabel.snp.makeConstraints{
            $0.left.equalTo(16)
            $0.centerY.equalToSuperview()
            
        }
        subTitleLabel.snp.makeConstraints{
            $0.right.equalTo(-16)
            $0.centerY.equalToSuperview()
            
        }
    }


    
    // MARK: ------------------------- Events
  
    
    
    // MARK: ------------------------- Methods
    func  updateSwitchApp(){
        
    }
    
}
