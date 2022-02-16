//
//  SPHomeBaseViewModel.swift
//  SPHomeUI
//
//  Created by flowerflower on 2021/12/18.
//

import Foundation


class SPHomeBaseViewModel: NSObject {
    
    
    /// 获取该 Item 对应的 Cell Class 类名
    public func cellClass() -> AnyClass {
        return SPHomeModuleBaseCell.self
    }
    
    public  func configData(model: SPPageModuleVOListModel?) {
        
        
    }
    
}
