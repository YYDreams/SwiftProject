//
//  XMHomeSubViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/3/26.
//

import Foundation
import UIKit
import JXSegmentedView
import JXCategoryView
// MARK: ------------------------- Const/Enum/Struct




extension XMHomeSubViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Porpertys {}
    
    /// 外部参数
    struct Params {}
    
}

class XMHomeSubViewController: BaseTableViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerCell(ofType: UITableViewCell.self)
        
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
    
}
extension XMHomeSubViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(ofType: UITableViewCell.self)
        cell.textLabel?.text = "我是\(indexPath.row)"
        return cell
    }
}

extension XMHomeSubViewController:JXCategoryListContentViewDelegate{
    func listView() -> UIView! {
        self.view
    }
    
    


}

