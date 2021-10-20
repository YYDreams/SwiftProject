//
//  SPHomeViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/20.
//

import UIKit
import XMUtil

// MARK: ------------------------- Const/Enum/Struct

extension SPHomeViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Porpertys {
        var titleArr = [String]()
    }
    
    /// 外部参数
    struct Params {}
    
}


class SPHomeViewController: BaseTableViewController{
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubView()
        
    }
    

    func setupSubView(){
   
        self.propertys.titleArr = ["常用弹窗封装",""]
        
        kStringIsEmpty(string: "fdfffffffffsdfsfds")
        
    }
    
    
//     func numberOfSections(in tableView: UITableView) -> Int {
//
//        return self.propertys.titleArr.count
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertys.titleArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.cell(ofType: UITableViewCell.self)
        cell.textLabel?.text = propertys.titleArr[safe: indexPath.row]
        return cell
    }
    
}
