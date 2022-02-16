//
//  SPHomeRecommendGoodsCell.swift
//  SPHomeUI
//
//  Created by flowerflower on 2021/12/19.
//

import UIKit
// MARK: ------------------------- Const/Enum/Struct

extension SPHomeRecommendGoodsCell {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Porpertys {}
    
    /// 外部参数
    struct Params {}
    
}

class SPHomeRecommendGoodsCell: UICollectionViewCell {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    

    
   public lazy var titleLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    // MARK: ------------------------- CycLife
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews(){
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview()
        }
        
        
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
}
