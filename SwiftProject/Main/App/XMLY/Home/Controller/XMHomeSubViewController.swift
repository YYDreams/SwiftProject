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

protocol XMHomeSubViewControllerDelegate: NSObjectProtocol{
    
    func  didScroll(_ controller: XMHomeSubViewController,scrollView: UIScrollView)
    
    func  didChangeColor(_ controller: XMHomeSubViewController,color: UIColor)
    
}


// MARK: ------------------------- Const/Enum/Struct




extension XMHomeSubViewController {
    
    /// 常量
    struct Const {
       static let bannerWidth:CGFloat = kScreenWidth - kRatio * 60
       static let bannerHeight:CGFloat = kScreenWidth * 335 / 839
       static let defalutColor: UIColor = UIColor(hexInt: 0x5C5859)
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
    
    var pageControl: UIPageControl!
    
    var bgColor: UIColor = UIColor(hexInt: 0x5C5859)
    
    //是否到达临界点
    var isCriticalPoint: Bool = false
    
    var isSelected: Bool = false
    
    var isLoaded: Bool = false

    var titleColor: UIColor = UIColor.white
    
    
    weak var delegate: XMHomeSubViewControllerDelegate?

    
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
        pageControl = UIPageControl()
        pageControl.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 8)
        bannerScrollView = GKCycleScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kRatio * 360))
        bannerScrollView.leftRightMargin = kRatio * 60
        bannerScrollView.dataSource = self
        bannerScrollView.delegate = self
        bannerScrollView.addSubview(pageControl)
        bannerScrollView.pageControl = pageControl
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kRatio * 360))
        let  point = CGPoint(x: kScreenWidth * 0.5, y: kRatio * 300)
        pageControl.center = point
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
            self.pageControl.numberOfPages = self.propertys.bannerLists.count
            self.bannerScrollView.reloadData()
            self.bgColor = self.propertys.bannerLists.first?.headerBgColor ?? UIColor(hexInt: 0x5C5859)
            
        } catch let error as Error? {
            print("读取本地数据出现错误!",error)
        }
        
        
    }
    // MARK: ------------------------- Events
    func staartScroll(){
        
        self.bannerScrollView.startTimer()
    }
    func stopScroll(){
        self.bannerScrollView.stopTimer()
    }
    
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
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         self.delegate?.didScroll(self, scrollView: scrollView)
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
        if (cell == nil){
            cell = GKCycleScrollViewCell()
            cell?.tag = index
            cell?.layer.cornerRadius = 4.0
            cell?.layer.masksToBounds = true
        }
        let model = self.propertys.bannerLists[safe:index]
        //completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
        cell?.imageView.kf.setImage(with: URL(string: model?.cover ?? ""), completionHandler: {(result) in
            
            switch result {
            case .success(let value):
                if model?.headerBgColor != nil{
                    model?.headerBgColor = UIColor(mostImage: value.image, scale: 0.01)
                }
                if index == self.bannerScrollView.currentSelectIndex{
                    self.bgColor = model?.headerBgColor ?? UIColor(hexInt: 0x5C5859)
                    self.delegate?.didChangeColor(self, color: self.bgColor)
                }
            default:
                break
            }

        })

    
        return cell
    }
    /// scrollView滚动中的回调
    /// @param cycleScrollView cycleScrollView对象
    /// @param fromIndex 正在滚动中，相对位置处于左边或上边的index，根据direction区分
    /// @param toIndex 正在滚动中，相对位置处于右边或下边的index，根据direction区分
    /// @param ratio 从左到右或从上到下计算的百分比，根据direction区分
    func cycleScrollView(_ cycleScrollView: GKCycleScrollView!, scrollingFrom fromIndex: Int, to toIndex: Int, ratio: CGFloat) {
        
        if (self.isCriticalPoint) {return}
        if let leftModel = self.propertys.bannerLists[safe: fromIndex],
           let rightModel = self.propertys.bannerLists[safe:toIndex]{
            let leftColor = (leftModel.headerBgColor != nil) ? leftModel.headerBgColor: Const.defalutColor
            let rightColor = (rightModel.headerBgColor != nil) ? rightModel.headerBgColor: Const.defalutColor
            let color  = JXCategoryFactory.interpolationColor(from: leftColor, to: rightColor, percent: ratio) ?? Const.defalutColor
            self.bgColor = color
            if self.isSelected {
                self.delegate?.didChangeColor(self, color: color)
            }
        }
        
    }
    
    
    func sizeForCell(in cycleScrollView: GKCycleScrollView!) -> CGSize {
        return CGSize(width: Const.bannerWidth, height: Const.bannerHeight)
    }
     
    
    
    
}
