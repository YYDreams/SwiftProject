//
//  SPTestViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/12/17.
//

import UIKit

// MARK: ------------------------- Const/Enum/Struct

extension SPTestViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Porpertys {}
    
    /// 外部参数
    struct Params {}
    
}

class SPTestViewController: UIViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
}
