//
//  SPCourseListViewControer.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/12/16.
//

import UIKit
import SPBaseUI
// MARK: ------------------------- Const/Enum/Struct

extension SPCourseListViewControer {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Porpertys {}
    
    /// 外部参数
    struct Params {}
    
}

class SPCourseListViewControer: BaseTableViewController {
    
    // MARK: ------------------------- Propertys
    var listViewDidScrollCallback: ((UIScrollView) -> ())?
    private var isHeaderRefreshed: Bool = false
    deinit {
        listViewDidScrollCallback = nil
    }

    
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        
        
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 20
    }

    public  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = "index ==="
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
extension SPCourseListViewControer: JXPagingViewListViewDelegate {
    public func listView() -> UIView {
        return self.view
    }
    
    public func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> ()) {
        self.listViewDidScrollCallback = callback
    }

    public func listScrollView() -> UIScrollView {
        return self.tableView
    }
}
