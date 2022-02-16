//
//  SPDeveloperViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/9.
//

import UIKit

import SnapKit




//import QMUIKit
// MARK: ------------------------- Const/Enum/Struct
//
enum  DeveloperSectionType:Int {
    case app
    case env
    case info
    
}
enum  DeveloperInfoType:Int {
    case currentServer
    case deviceInfo
    case version
    case shareLog
    case swimLane
    case console
    
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
            let titleArr = ["商城","音视频","有妖气漫画"]
            for i in 0..<titleArr.count{
                let item = SPDeveloperItemModel()
                item.title = titleArr[i]
                item.appType = SPAppCore.shared.appType
                item.isSeleted = (i == SPAppCore.shared.appType?.rawValue)
                items.append(item)
               }
        case .env:
            title = "网络设置"
            let titleArr = ["开发环境","测试环境","正式环境"];
            for i in 0..<titleArr.count{
                let item = SPDeveloperItemModel()
                item.title = titleArr[i]
                item.isSeleted = (i == SPAppCore.shared.environmentType?.rawValue)
                items.append(item)
               }
        case .info:
            title = "信息查看"
            let titleArr = ["当前服务器","设备型号","版本号","点击分享日志","泳道名","打开控制台"]
            for i in 0..<titleArr.count{
                let item = SPDeveloperItemModel()
                item.title = titleArr[i]
                item.infoType = DeveloperInfoType(rawValue: i)
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
    var appType: SPAppType? = .shop
    var infoType:DeveloperInfoType? = .currentServer
}




extension SPDeveloperViewController {
    

    
    /// 常量
    struct Const {
        static let tableHeaderViewHeight:CGFloat = 40
    }
    
    /// 内部属性
    struct Propertys {
        var sections = [SPDeveloperModel]()
        
    }
    
    /// 外部参数
    struct Params {}
    
}


class SPDeveloperViewController: BaseTableViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    //
    var confirmBtn: UIButton?
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.setupSubViews()
    }
    func setupSubViews(){
                 
        self.tableView.registerCell(ofType: SPDeveloperCell.self)
        
        self.tableView.registerCell(ofType: SPDeveloperTextCell.self)
        
        let footerView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
        
        self.tableView.tableFooterView = footerView
        
        self.confirmBtn = {
            let btn = UIButton(frame: .zero)
            self.tableView.tableFooterView?.addSubview(btn)
            btn.addTarget(self, action: #selector(confirmOnClick), for: .touchUpInside)
            btn.setTitle("确定", for: .normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.backgroundColor = kThemeColor
            footerView.addSubview(btn)
            btn.snp.makeConstraints{
                $0.edges.equalTo(UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16))
            }
            
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
        let model =  self.propertys.sections[indexPath.section]
        let itemModel = model.items[indexPath.row]
        switch model.type {
        case .app, .env:
            let cell = tableView.cell(ofType: SPDeveloperCell.self)
            cell.switchAppBtn.setTitle(itemModel.title, for: .normal)
            cell.switchAppBtn.isSelected = model.items[indexPath.row].isSeleted
            return cell
        default:
            let cell = tableView.cell(ofType: SPDeveloperTextCell.self)
            cell.titleLabel.text = itemModel.title
            switch itemModel.infoType {
            case .currentServer:
                cell.subTitleLabel.text  = SPAppCore.shared.baseUrl
            case .deviceInfo:
                cell.subTitleLabel.text =  UIDevice.current.model + UIDevice.current.systemVersion
            case .version:
                if let info = Bundle.main.infoDictionary {
                    let appVersion = info["CFBundleShortVersionString"] as? String ?? "Unknown"
                    let build = info["CFBundleVersion" as String] as? String ?? "Unknown"
                    cell.subTitleLabel.text = "version:" + appVersion + " build:" + build
                }
            case .swimLane:
                let tversion = UserDefaults.standard.object(forKey: "kTversion") as? String
                cell.subTitleLabel.text = tversion
            default:
                break
            }
            return cell
        }
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
        let itemModel  = model.items[safe: indexPath.row]
        if model.type == .app || model.type == .env  {
            self.handerDidSelectRow(indexPath: indexPath)
        }else{
            if itemModel?.infoType == .swimLane{
                
                writeTversion()
                
            }else if itemModel?.infoType == .shareLog{
                
                
            }else if itemModel?.infoType == .console{
//                QMUIConsole.sharedInstance().canShow = true
//                QMUIConsole.show()

                
            }else{
//                self.navigationController?.pushViewController(SPTestViewController(), animated: true)
            }
        }
        
    }
    func handerDidSelectRow(indexPath: IndexPath){
        
        let model =  self.propertys.sections[indexPath.section]
        model.items.forEach { itemModel in
            itemModel.isSeleted = false
        }
        let selecteModel = model.items[indexPath.row]
        selecteModel.isSeleted = true
        if model.type == .app {
            SPAppCore.shared.appType = SPAppType(rawValue: indexPath.row)
        }else if model.type == .env{
            SPAppCore.shared.environmentType  = SPEnvironmentType(rawValue: indexPath.row)
        }
        tableView.reloadData()
        SPAppCore.shared.baseUrl  =  NetworkHelp.shared.baseUrl()
        print("xxxx----",SPAppCore.shared.environmentType,SPAppCore.shared.appType,SPAppCore.shared.baseUrl)
    }
    
      func writeTversion() {
        let controller = UIAlertController(title: "设置泳道", message: nil, preferredStyle: .alert)
        controller.addTextField { textField in
                        
            let tversion = UserDefaults.standard.object(forKey: "kTversion") as? String
            textField.placeholder = "泳道名";
            
            textField.clearButtonMode = .whileEditing
            if !kStringIsEmpty(string: tversion ?? ""){
                textField.text = tversion
            }
        }
        let actionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let actionConfirm = UIAlertAction(title: "确定", style: .default) { [weak self] action in
            let textField = controller.textFields?.first
            let textFieldText = textField?.text ?? ""
            UserDefaults.standard.setValue(textFieldText, forKeyPath: "kTversion")
            UserDefaults.standard.synchronize()
            self?.tableView.reloadData()
        }
        controller.addAction(actionCancel)
        controller.addAction(actionConfirm)
        self.present(controller, animated: true, completion: nil)
    }
    
    
    @objc func confirmOnClick(){
     
//        self.navigationController?.pushViewController(SPColumnDetailViewController(), animated: true)
        
        
        return
        SPAppCore.shared.logout()
        
//        let p = SPMenuView.create(superView: self.confirmBtn, dataArr: ["我","大家了大家","顶顶顶顶"])
//
//        p.show()
//        exit(0)

    }
    
    
}

