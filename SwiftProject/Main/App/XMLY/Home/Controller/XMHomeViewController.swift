//
//  XMHomeViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/3/26.
//

import Foundation
import UIKit
import JXCategoryView
// MARK: ------------------------- Const/Enum/Struct
//discovery-feed/v3/mix/ts-1648308132480 推荐 categoryId = -2
//discovery-category/v5/category/recommend/ts-1648308410246 个人成长 = 13
//discovery-category/v5/category/recommend/ts-1648308498428 人文 = 39
//https://mobile.ximalaya.com/discovery-category/v5/category/recommend/ts-1648308498428?appid=0&categoryId=39&device=iPhone&deviceId=37B45C87-58E6-4F1D-A9BD-C3C7B9FA0F4F&gender=9&idfaLimit=0&inreview=false&isHomepage=true&network=WIFI&operator=3&osUpdateTime=1607275041.713700&scale=3&systemIDFA=61CEAF02-54AA-4995-8C6B-6F0FE3EEC379&uid=136001372&version=9.0.22&xt=1648308498427

enum XMCategoryType: Int{
  case  recommended  = -2 //推荐
    
}

extension XMHomeViewController {
    
    /// 常量
    struct Const {
        static let categoryHeight: CGFloat = 44

    }
    
    /// 内部属性
    struct Propertys {
        var titles:[String] = []
        var imageTypes:[NSNumber] = []
    }
    
    /// 外部参数
    struct Params {}
    
}

class XMHomeViewController: BaseUIViewController {
    
    // MARK: ------------------------- Propertys
    var headerBgView: UIView!
    var coverView: UIView!
    var topView: UIView!
    var categoryView: JXCategoryTitleImageView!
    var lineView: JXCategoryIndicatorLineView!
    var containerView: XMHomeListContainerView!
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        requestData()
    }
    func setupSubViews(){
        self.navigationController?.navigationBar.isHidden = true
        headerBgView = {
          let view = UIView()
            view.backgroundColor = UIColor(hexInt: 0x5C5859)
            return view
        }()
        coverView = {
          let view = UIView()
            view.backgroundColor = UIColor.black
            view.alpha = 0.3
            return view
        }()
        topView = {
          let view = UIView()
            view.backgroundColor = UIColor.clear
            return view
        }()
        lineView = {
            lineView = JXCategoryIndicatorLineView()
            lineView.indicatorWidth     = kRatio * 40.0
            lineView.indicatorHeight    = kRatio * 8.0
            lineView.indicatorColor     = UIColor.white
            lineView.lineStyle          = .lengthen
            return lineView
        }()
        categoryView = {
            let categoryView = JXCategoryTitleImageView()
            categoryView.delegate              = self
            categoryView.backgroundColor       = UIColor.clear
            categoryView.titleFont             = UIFont.systemFont(ofSize: 14)
            categoryView.titleSelectedFont     = UIFont.systemFont(ofSize: 16)
            categoryView.titleColor            = UIColor.white
            categoryView.titleSelectedColor    = UIColor.white
            categoryView.imageSize             = CGSize(width: 46, height: 26)
            categoryView.isImageZoomEnabled      = true  // 图片缩放
            categoryView.imageZoomScale        = 1.3  // 图片缩放程度
            categoryView.isTitleLabelZoomEnabled = true  // 标题缩放
            categoryView.titleLabelZoomScale   = 1.3;  // 标题缩放程度
            categoryView.isContentScrollViewClickTransitionAnimationEnabled = false
            categoryView.titleLabelAnchorPointStyle = .bottom
            categoryView.indicators    = [self.lineView]
            categoryView.listContainer = self.containerView
            return categoryView
        }()
      
        
        containerView = {
            let view = XMHomeListContainerView(type: .collectionView, delegate: self)
//            _containerView.scrollView.backgroundColor = [UIColor clearColor];
//            _containerView.delegate = self;
//            _containerView.listCellBackgroundColor = [UIColor clearColor];
            return view
        }()
        
        self.view.addSubview(headerBgView)
        self.view.addSubview(coverView)
        self.view.addSubview(topView)
        self.topView.addSubview(categoryView)
        self.view.addSubview(self.containerView)
        
        self.headerBgView.snp.makeConstraints{
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(kRatio * 360)
        }
        self.coverView.snp.makeConstraints{
            $0.edges.equalTo(self.headerBgView);
        }
        self.topView.snp.makeConstraints{
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(kNavBarHeight + kStatusBarHeight)
        }
        self.categoryView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.view).offset(kStatusBarHeight)
            $0.height.equalTo(Const.categoryHeight)
        }
        self.containerView.snp.makeConstraints{
            $0.left.bottom.right.equalTo(self.view)
            $0.top.equalTo(self.categoryView.snp.bottom)
            
        }
    }
 
    // MARK: ------------------------- Events
    func requestData(){
        self.propertys.titles = ["直播","推荐","直播1","推荐2","直播3","推荐4"]
                
        self.propertys.titles.flatMap { _ in
                
            self.propertys.imageTypes.append(5)
        }
        categoryView.titles = self.propertys.titles
        categoryView.imageTypes = self.propertys.imageTypes
        self.categoryView.reloadData()
        self.containerView.reloadData()
    }
    
    // MARK: ------------------------- Methods
    
}


extension XMHomeViewController:JXCategoryViewDelegate,JXCategoryListContainerViewDelegate{
    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        self.propertys.titles.count
    }
    
    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        let listVC = XMHomeSubViewController()
        listVC.view.backgroundColor = UIColor.orange
        return listVC
    }
    
}