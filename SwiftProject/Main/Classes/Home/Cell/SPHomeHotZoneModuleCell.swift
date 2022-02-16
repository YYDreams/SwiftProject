//
//  SPHomeHotZoneModuleCell.swift
//  SPHomeUI
//
//  Created by flowerflower on 2021/12/21.
//

import UIKit


class SPHomeHotZoneModuleCell: SPHomeModuleBaseCell {
    
    // MARK: ------------------------- Propertys

    lazy var bgImgView: UIImageView = {
        let view  = UIImageView()

        return view
    }()
    
    
    // MARK: ------------------------- CycLife
    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupSubView(){
        contentView.addSubview(bgImgView)
        bgImgView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(200)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func refreshUI(_ viewModel: Any?) {
        super.refreshUI(viewModel)
        var imageArr = [String]()
        guard let viewModel = viewModel as? SPHomeSliderModuleViewModel else { return }
        viewModel.sliderListArr?.forEach({ dic in
            if let obj = dic  as? [String: Any] , let imgUrl = obj["src"] as? String{
                imageArr.append(imgUrl)
            }
        })
        self.bgImgView.backgroundColor = UIColor.red
    }

    

    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
}
