//
//  SPHomeHotZoneModuleViewModel.swift
//  SPHomeUI
//
//  Created by flowerflower on 2021/12/18.
//

import Foundation

class SPHomeHotZoneModuleViewModel: SPHomeBaseViewModel {
    
    var sliderListArr: [Any]?
    /// 获取该 Item 对应的 Cell Class 类名
    override func cellClass() -> AnyClass {
        return SPHomeHotZoneModuleCell.self
    }
    
    override func configData(model: SPPageModuleVOListModel?) {
        super.configData(model: model)
        guard let  content:[String: Any] =  model?.renderContent else {
            return
        }
        

    }
    
}
