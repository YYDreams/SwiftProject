//
//  SPBaseCourseDetailVC.swift
//  SwiftProject
//
//  Created by flower on 2024/7/8.
//

import Foundation
import JXSegmentedView

/// 外部参数
struct Params {
    var userId:String = "" //required
    var appId:String = "" //required
    var contentAppid:String = "" //有则转 没有就空
    var rootId:String?
    var rootType:ResourceType?
    var productId:String?
    var productType:ResourceType?
    var resourceId:String = "" //required
    var resourceType:ResourceType = .none //required
}

class SPBaseCourseDetailVC:UIViewController{
    
    var params: Params = Params()
    var viewModel =  SPCourseViewModel()
    var kBaseSegmentHeight:CGFloat = 40.0
      var kBaseHeaderHeight:CGFloat = 200.0
      lazy var headerView: UIImageView = {
          let headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kBaseHeaderHeight))
          headerView.contentMode = .scaleAspectFill
          headerView.clipsToBounds = true
          headerView.backgroundColor = .blue
          return headerView
      }()
      lazy var smoothView: SPPageSmoothView = {
          let smoothView = SPPageSmoothView(dataSource: self)
          smoothView.delegate = self
          return smoothView
      }()
    lazy var segmentedDataSource: JXSegmentedTitleDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.titles = ["1我的课程","2推荐课程","3课程","4京津冀"]
        dataSource.titleSelectedFont = .systemFont(ofSize: 16, weight: .bold)
        dataSource.titleSelectedColor = UIColor("#333333")
        dataSource.titleNormalFont = .systemFont(ofSize: 14, weight: .regular)
        dataSource.titleNormalColor = UIColor("#999999")
        dataSource.isItemSpacingAverageEnabled = false
        dataSource.itemSpacing = 24
        return dataSource
    }()
    lazy var segmentedView: JXSegmentedView = {
        let titleView = JXSegmentedView()
        titleView.backgroundColor = UIColor.white
        titleView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kBaseSegmentHeight)
        titleView.delegate = self
        titleView.dataSource = segmentedDataSource
        return titleView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(smoothView)
        smoothView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(kNavBarHeight)
        }
        smoothView.reloadData()
    }
    public convenience init(params:Params) {
        self.init()
        self.params = params
        self.viewModel = SPCourseViewModel(params: params,delegate: self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if headerView.bounds.size.width != view.bounds.width {
            headerView.frame.size.width = view.bounds.width
        }
        
        if segmentedView.bounds.size.width != view.bounds.width {
            segmentedView.frame.size.width = view.bounds.width
            segmentedView.reloadData()
        }
    }
}
