//
//  MineViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/9.
//

import Foundation
import XMUtil
class MineViewController:  BaseTableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubView()
    }
    
    func setupSubView()  {
        self.tableView.registerCell(ofType: UITableViewCell.self)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(ofType: UITableViewCell.self)
        cell.textLabel?.text = "我是超级哈哈哈\(indexPath.row)"
        return cell
        
    }
    
    
    
}
