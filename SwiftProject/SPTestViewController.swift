//
//  SPTestViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/11/20.
//

import Foundation
import UIKit
import XMUtil
import SPWidget

// MARK: ------------------------- Const/Enum/Struct

extension SPTestViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Porpertys {}
    
    /// 外部参数
    struct Params {}
    
}

class SPTestViewController: BaseTableViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor  = .red
        
        
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
        self.view.addSubview(self.tableView)
        self.tableView.backgroundColor = UIColor.orange
        
        self.tableView.registerCell(ofType: SPTestCell.self)
        self.tableView.rowHeight = 60
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let content = UIButton.init(frame: CGRect.init(x: 300, y: 100, width: kScreenWidth, height: 400))
        content.backgroundColor = UIColor.orange
//        Show.showPopView(contentView: content) { (config) in
//            config.showAnimateType = .bottom
//            config.maskType = .color
//            config.clickOtherHidden = true
//            config.cornerRadius = 12
//            config.corners = [.topLeft, .topRight]
//        }
        
        return
   
    }
    
    // MARK: ------------------------- Events
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(ofType: SPTestCell.self)
        cell.callBackBlock = { btn in
      
        let p = SPMenuView.create(superView: btn, dataArr: ["我","大家了大家","顶顶顶顶"])
            p.callBackBlock = { [weak self] (menu, title,index) in
               
            print("menu,",menu,title,index)
            }
            p.show()
        }
        return cell
    }
    
    
}

