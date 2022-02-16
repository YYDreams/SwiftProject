//
//  SPHomeSliderModuleCell.swift
//  SPHomeUI
//
//  Created by flowerflower on 2021/12/18.
//

import SnapKit
import SDCycleScrollView


class SPHomeSliderModuleCell: SPHomeModuleBaseCell, SDCycleScrollViewDelegate {
    
    // MARK: ------------------------- Propertys

    lazy var cycleScrollView: SDCycleScrollView = {
        let view  = SDCycleScrollView()
        view.delegate = self
        view.backgroundColor = UIColor.clear
        view.currentPageDotColor = kThemeColor
        view.pageDotColor  = UIColor.white
        view.autoScroll = true
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
        contentView.addSubview(cycleScrollView)
        cycleScrollView.snp.makeConstraints{
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
        self.cycleScrollView.imageURLStringsGroup = imageArr
    }

    

    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
}

extension SPHomeSliderModuleViewModel: SDCycleScrollViewDelegate{
    
    
}
