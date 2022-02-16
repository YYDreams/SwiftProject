//
//  BaseTableView.swift
//  SPBaseUI
//
//  Created by flowerflower on 2021/12/21.
//

import UIKit

public class BaseTableView: UITableView {
    public  override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupCommmonInit()
    }

    func setupCommmonInit(){
        estimatedRowHeight = 0
        estimatedSectionHeaderHeight = 0
        estimatedSectionFooterHeight = 0
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

