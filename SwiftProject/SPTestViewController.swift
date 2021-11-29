//
//  SPTestViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/11/20.
//

import Foundation
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

class SPTestViewController: BaseUIViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor  = .red
        
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
       let nav =  self.navigationController as? BaseNavViewController
        
        nav?.navigationGestBlock = {
            let alertController = UIAlertController(title: "系统提示",
                              message: "您确定要离开hangge.com吗？", preferredStyle: .alert)
              let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
              let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                  action in
                self.navigationController?.popViewController(animated: true)
                  print("点击了确定")
              })
              alertController.addAction(cancelAction)
              alertController.addAction(okAction)
              self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
}

