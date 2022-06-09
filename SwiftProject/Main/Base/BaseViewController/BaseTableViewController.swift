//
//  BaseTableViewController.swift
//  BaseUI
//
//  Created by flowerflower on 2021/8/15.
//

import UIKit

class BaseTableViewController: BaseUIViewController {
    
    
    // MARK: ------------------------- Propertys
    public lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    
    // MARK: ------------------------- CycLife
     override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.left.right.equalTo(self.view)
            $0.top.equalTo(kNavBarHeight)
            $0.bottom.equalTo(-kSafeAreaBottom)
        }
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
    public    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    public  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}

