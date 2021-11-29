//
//  SPDeveloperViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/9.
//

import UIKit
import XMUtil
import SnapKit
// MARK: ------------------------- Const/Enum/Struct
//
enum  DeveloperSectionType:Int {
    case app
    case env
    case info
    
}

class SPDeveloperModel: NSObject {

    var title: String?
    var type: DeveloperSectionType?
    var items = [SPDeveloperItemModel]()
    
    init(type:DeveloperSectionType) {
        self.type = type
        switch type {
        case .app:
            title = "App选项"
            let titleArr = ["商城","音频","有妖气漫画"]
            for i in 0..<titleArr.count{
                let item = SPDeveloperItemModel()
                item.title = titleArr[i]
                items.append(item)
               }
        case .env:
            title = "网络设置"
            
            let titleArr = ["测试环境","正式环境"];
            for i in 0..<titleArr.count{
                let item = SPDeveloperItemModel()
                item.title = titleArr[i]
                items.append(item)
               }
        case .info:
            title = "信息查看"
            let titleArr = ["当前服务器","设备型号","版本号","点击分享日志","泳道名"]
            for i in 0..<titleArr.count{
                let item = SPDeveloperItemModel()
                item.title = titleArr[i]
                items.append(item)
               }
        default:
            break
        }
    }
    
}
class SPDeveloperItemModel: NSObject{
    var title: String?
    var isSeleted: Bool = false
}



extension SPDeveloperViewController {
    

    
    /// 常量
    struct Const {
        static let tableHeaderViewHeight:CGFloat = 40
    }
    
    /// 内部属性
    struct Porpertys {
        var sections = [SPDeveloperModel]()
        
    }
    
    /// 外部参数
    struct Params {}
    
}


class SPDeveloperViewController: BaseTableViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    //
    var confirmBtn: UIButton?
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.setupSubViews()
    }
    func setupSubViews(){
         
    
        self.tableView.registerCell(ofType: SPDeveloperCell.self)
        
        self.tableView.registerCell(ofType: UITableViewCell.self)
        
        self.confirmBtn = {
            let btn = UIButton(frame: .zero)
            self.tableView.tableFooterView?.addSubview(btn)
            btn.addTarget(self, action: #selector(confirmOnClick), for: .touchUpInside)
            btn.setTitle("确定", for: .normal)
            btn.backgroundColor = kThemeColor
            
            return btn
        }()
        
        
        
        self.loadData()
    }
    
    // MARK: ------------------------- Events

    
    // MARK: ------------------------- Methods
    func loadData(){
          
        let dev1 = SPDeveloperModel(type: .app)
        let dev2 = SPDeveloperModel(type: .env)
        let dev3 = SPDeveloperModel(type: .info)
        
        self.propertys.sections.append(dev1)
        self.propertys.sections.append(dev2)
        self.propertys.sections.append(dev3)

    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return self.propertys.sections.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.propertys.sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(ofType: UITableViewCell.self)
        let model =  self.propertys.sections[indexPath.section]
        let title = model.items[indexPath.row].title
        switch model.type {
        case .app, .env:
            let cell = tableView.cell(ofType: SPDeveloperCell.self)
            cell.switchAppBtn.setTitle(title, for: .normal)
            cell.switchAppBtn.isSelected = model.items[indexPath.row].isSeleted
            return cell
       
        default:
            
            break
        }

        cell.textLabel?.text = title
        return cell
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame:  CGRect(x: 0, y: 0, width: kScreenWidth, height: Const.tableHeaderViewHeight))
        let headerTitleLabel = UILabel()
        headerTitleLabel.textAlignment = .left
        headerTitleLabel.textColor = UIColor.black
        headerTitleLabel.text = self.propertys.sections[section].title
        headerView.addSubview(headerTitleLabel)
        headerTitleLabel.frame = CGRect(x: 12, y: 0, width: kScreenWidth, height: Const.tableHeaderViewHeight)
        
        return headerView
        
        
    }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Const.tableHeaderViewHeight
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model =  self.propertys.sections[indexPath.section]

        if model.type == .app || model.type == .env {
            model.items.forEach { itemModel in
                itemModel.isSeleted = false
            }
            let selecteModel = model.items[indexPath.row]
            selecteModel.isSeleted = true
            
            tableView.reloadData()
        }else{
            
            self.navigationController?.pushViewController(SPTestViewController(), animated: true)
        }

    }
    
    @objc func confirmOnClick(){
     
      
        
        
    }
    
}

