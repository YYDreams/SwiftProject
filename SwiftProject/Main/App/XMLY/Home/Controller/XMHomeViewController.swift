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
    
    var accountManager:XMAccountManager!
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()

//        let greenView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
//        greenView.backgroundColor = UIColor.green
//        SPShowView.showCustomView(contentView: greenView)
//        SPShowView.show(title: "我的", buttonTitles: ["取消","确定"]) { index in
//            print("======index",index)
//        }
        
        self.navigationController?.pushViewController(SPTestViewController(), animated: true)
//        self.navigationController?.pushViewController(SPUserDetailViewController(), animated: true)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "clear", style: .plain, target: self, action: #selector(clear))
        
//        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(clear), userInfo: nil, repeats: true)
//        Timer.scheduledTimer(timeInterval: 0.1,
//                    target:self,selector:Selector("testListener"),
//                    userInfo:nil,repeats:true)
        setupSubViews()
        
//        accountManager  = XMAccountManager.shareInstance()
        print("----11---%p",accountManager)
        requestData()
    }
    @objc func clear(){
//        let greenView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
//        greenView.backgroundColor = UIColor.green
//        SPShowView.showCustomView(contentView: greenView)
        
        SPShowView.show(title: "我的",content: "怎么啦三生ddsd打赏都是多多所多所多所多所多所多所多所多所付付打赏都是大所大所", buttonTitles: ["取消","确定"]) { index in
            print("======index",index)
        }

//        accountManager.clear()
        print("----33---%p",accountManager)
    }
    
    func setupSubViews(){
//        self.navigationController?.navigationBar.isHidden = true
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
            let lineView = JXCategoryIndicatorLineView()
            lineView.indicatorWidth     = kRatio * 40.0
            lineView.indicatorHeight    = kRatio * 8.0
            lineView.indicatorColor     = UIColor.white
            lineView.lineStyle          = .lengthen
            return lineView
        }()
        containerView = {
            let view = XMHomeListContainerView(type: .collectionView, delegate: self)
            view?.scrollView.backgroundColor = UIColor.clear
            view?.listCellBackgroundColor = UIColor.clear
            return view
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
            categoryView.indicators    = [lineView]
            categoryView.listContainer = self.containerView
            return categoryView
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
        changeToWhiteStateAndVC(vc: nil)
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
        categoryView(categoryView, didSelectedItemAt: 0)

    }
    
    // MARK: ------------------------- Methods
    func changeToWhiteStateAndVC(vc: XMHomeSubViewController?){
        self.categoryView.titleColor = UIColor.white
        self.categoryView.titleSelectedColor = UIColor.white
        self.lineView.indicatorColor = UIColor.white
        self.categoryView.refreshCellState()
        if let homeSubVc = vc {
            homeSubVc.isCriticalPoint = false
            UIView.animate(withDuration: 0.3) {
                self.coverView.isHidden = false
                self.headerBgView.backgroundColor = homeSubVc.bgColor
            }
        }

    }
    
    
    func changeToBlackStateAndVC(vc: XMHomeSubViewController?){
        
        // 标签栏改变
        
        self.categoryView.titleColor = UIColor.black
        self.categoryView.titleSelectedColor = UIColor.black
        self.lineView.indicatorColor = UIColor.red
        self.categoryView.refreshCellState()
        
        if let homeSubVc = vc {
            homeSubVc.isCriticalPoint = true
            UIView.animate(withDuration: 0.3) {
                self.coverView.isHidden = true
                self.headerBgView.backgroundColor = UIColor.white
            }
        }
    }
    
}


 //MARK: ------------------------- JXCategoryViewDelegate,JXCategoryListContainerViewDelegate
extension XMHomeViewController:JXCategoryViewDelegate,JXCategoryListContainerViewDelegate{
    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        self.propertys.titles.count
    }
    
    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        let listVC = XMHomeSubViewController()
        listVC.delegate = self
        listVC.bgColor = XMHomeSubViewController.Const.defalutColor
        return listVC
    }
    
    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {

        print("didSelectedItemAt",index)
                
        let listVC = self.containerView.validListDict[NSNumber(value: index)] as? XMHomeSubViewController
        listVC?.isSelected = true
        listVC?.loadData()
        
        if  listVC?.isCriticalPoint ?? false {
            changeToBlackStateAndVC(vc: listVC)
        }else{
            changeToWhiteStateAndVC(vc: listVC)
        }
    }
    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
     
        guard let leftVc = self.containerView.validListDict[NSNumber(value: leftIndex)] as? XMHomeSubViewController,
         let rightVc = self.containerView.validListDict[NSNumber(value: rightIndex)] as? XMHomeSubViewController else{
            
            return
        }
   
        
        let leftColor = leftVc.isCriticalPoint ? UIColor.white : leftVc.bgColor
        let rightColor = rightVc.isCriticalPoint ? UIColor.white : rightVc.bgColor
        
        let color = JXCategoryFactory.interpolationColor(from: leftColor, to: rightColor, percent: ratio)
        self.headerBgView.backgroundColor = color
        if leftVc.isCriticalPoint == rightVc.isCriticalPoint {return}
        if leftVc.isCriticalPoint {
            if ratio > 0.5 {
                changeToWhiteStateAndVC(vc: nil)
            }else{
                changeToBlackStateAndVC(vc: nil)
            }
        }else if rightVc.isCriticalPoint{
            if ratio > 0.5 {
                changeToBlackStateAndVC(vc: nil)
            }else{
                changeToWhiteStateAndVC(vc: nil)
            }
        }
        
        
        
    }
    
}
//MARK: ------------------------- XMHomeListContainerViewDelegate
extension XMHomeViewController: XMHomeListContainerViewDelegate{
    
    func scrollWillBegin(){
        self.containerView.validListDict.compactMap { (key, obj) in
            let listVC = obj as? XMHomeSubViewController
            listVC?.stopScroll()
            
        }
    }
    func scrollDidEnded(){
        let listVC = self.containerView.validListDict[NSNumber(value: self.categoryView.selectedIndex)] as? XMHomeSubViewController
        listVC?.staartScroll()
    }
}

//MARK: ------------------------- XMHomeSubViewControllerDelegate
extension XMHomeViewController:XMHomeSubViewControllerDelegate{
    func  didScroll(_ controller: XMHomeSubViewController,scrollView: UIScrollView){
        let offsetY = scrollView.contentOffset.y
        if offsetY <= 0 {return}
        if offsetY > kRatio * 300 {
            changeToBlackStateAndVC(vc: controller)
        }else{
            changeToWhiteStateAndVC(vc: controller)
        }

        
    }
    
    func  didChangeColor(_ controller: XMHomeSubViewController,color: UIColor){
        print("didChangeColor===",color);
        self.headerBgView.backgroundColor = color
    }
    
    
}
