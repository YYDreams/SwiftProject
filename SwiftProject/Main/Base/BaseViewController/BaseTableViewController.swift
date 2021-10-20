//
//  BaseTableViewController.swift
//  BaseUI
//
//  Created by flowerflower on 2021/8/15.
//

import Foundation
import XMUtil

open  class BaseTableViewController: BaseUIViewController {
    
    
    // MARK: ------------------------- Propertys
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: kScreenBound, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    
    // MARK: ------------------------- CycLife
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
//
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
    
    
    
    
    // MARK: ------------------------- Events
    
    public func test(){
        
    }
    
    // MARK: ------------------------- Methods
    
}

extension  BaseTableViewController:UITableViewDelegate,UITableViewDataSource{
  open    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    open  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}

