//
//  SPTestCell.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/12/5.
//

import UIKit
import SnapKit
// MARK: ------------------------- Const/Enum/Struct

class SPTestCell: UITableViewCell {
    
    // MARK: ------------------------- Propertys
    
    var callBackBlock:((_ shareBtn :UIButton)->Void)?

    ///
   public  var moreBtn: UIButton = {
    let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.red
        btn.setTitle("更多", for: .normal)
//       btn.addTarget(self, action: #selector(moreOnClick), for: .touchUpInside)
        return btn
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
        contentView.addSubview(moreBtn)
        moreBtn.addTarget(self, action: #selector(moreOnClick), for: .touchUpInside)

        contentView.addSubview(subTitleLabel)
        
        moreBtn.snp.makeConstraints{
            $0.left.equalTo(16)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.centerY.equalToSuperview()
            
        }
        subTitleLabel.snp.makeConstraints{
            $0.right.equalTo(-16)
            $0.centerY.equalToSuperview()
            
        }
    }


    
    // MARK: ------------------------- Events
    @objc func moreOnClick(){
     print("=====moreOnClick")
        callBackBlock?(self.moreBtn)
        
    }
    
    
    // MARK: ------------------------- Methods
   
    
}
