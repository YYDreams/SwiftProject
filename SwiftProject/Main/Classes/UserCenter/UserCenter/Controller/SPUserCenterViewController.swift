//
//  SPUserCenterViewController.swift
//  SPUserCenterUI
//
//  Created by flowerflower on 2021/12/17.
//

import UIKit

// MARK: ------------------------- Const/Enum/Struct

extension SPUserCenterViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Propertys {
        let dataArr = ["开发者模式"]
    }
    
    /// 外部参数
    struct Params {}
    
}

class SPUserCenterViewController: BaseTableViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        
        setupSubViews()
        
        var array = [10, 20, 45, 30, 4]
        print(array)
        array.swapAt(array.startIndex, array.endIndex - 1)
        print(array)
        
        
    }
    func setupSubViews(){
        tableView.registerCell(ofType: UITableViewCell.self)
        
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         self.propertys.dataArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(ofType: UITableViewCell.self)
        cell.textLabel?.text = self.propertys.dataArr[safe:indexPath.row]
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        self.navigationController?.pushViewController(SPDeveloperViewController(), animated: true)
        
        
    }
    
}
