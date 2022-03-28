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
import GKCycleScrollView
import Kingfisher
// MARK: ------------------------- Const/Enum/Struct




extension XMHomeSubViewController {
    
    /// 常量
    struct Const {
       static let bannerWidth:CGFloat = kScreenWidth - kRatio * 60
       static let bannerHeight:CGFloat = kScreenWidth * 335 / 839
    }
    
    /// 内部属性
    struct Propertys {
        var bannerLists:[XMHomeBannerModel] = [XMHomeBannerModel]()
    }
    
    /// 外部参数
    struct Params {}
    
}

class XMHomeSubViewController: BaseTableViewController {
    
    // MARK: ------------------------- Propertys
    var headerView: UIView!
    
    var bannerScrollView: GKCycleScrollView!
    
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadData()
        
        
    }
    func setupSubViews(){
        
        bannerScrollView = GKCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kRatio * 360))
        bannerScrollView.leftRightMargin = kRatio * 60
        bannerScrollView.dataSource = self
        bannerScrollView.delegate = self
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kRatio * 360))
        headerView.backgroundColor = UIColor.clear
        headerView.addSubview(bannerScrollView)
        tableView.backgroundColor = UIColor.clear
        tableView.tableHeaderView = headerView
        tableView.registerCell(ofType: UITableViewCell.self)
        tableView.snp.updateConstraints{
            $0.top.equalTo(self.view)
            $0.bottom.equalTo(-kTabBarHeight)
        }
    }
    
    func loadData(){
        let path = Bundle.main.path(forResource: "XMhome", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
            do {
                      /*
                         * try 和 try! 的区别
                         * try 发生异常会跳到catch代码中
                         * try! 发生异常程序会直接crash
                         */
                    let data = try Data(contentsOf: url)
                    let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                let json = jsonData as! [String: Any]
                
                let model = XMHomeTabModel.deserialize(from: json)
                if let data = model?.focusImages?.data,data.count > 0{
                    self.propertys.bannerLists = data
                }
               
                print("读取本地数据:!",self.propertys.bannerLists)
                self.bannerScrollView.reloadData()

            } catch let error as Error? {
                    print("读取本地数据出现错误!",error)
                }

//        [NSDictionary, readLocalFile(withName: "home")]
        
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


extension XMHomeSubViewController: GKCycleScrollViewDelegate,GKCycleScrollViewDataSource{
    func numberOfCells(in cycleScrollView: GKCycleScrollView!) -> Int {
        return self.propertys.bannerLists.count
    }
    
    func cycleScrollView(_ cycleScrollView: GKCycleScrollView!, cellForViewAt index: Int) -> GKCycleScrollViewCell! {
        var cell = cycleScrollView.dequeueReusableCell()
        cell?.backgroundColor = UIColor.green
        if (cell == nil){
            cell = GKCycleScrollViewCell()
            cell?.tag = index
            cell?.layer.cornerRadius = 4.0
            cell?.layer.masksToBounds = true
        }
        let model = self.propertys.bannerLists[safe:index]
     
        //completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
        cell?.imageView.kf.setImage(with: URL(string: model?.cover ?? ""), completionHandler: {(result) in
        })

    
        return cell
    }
    
    func sizeForCell(in cycleScrollView: GKCycleScrollView!) -> CGSize {
        return CGSize(width: Const.bannerWidth, height: Const.bannerHeight)
    }
    
    
    
}
