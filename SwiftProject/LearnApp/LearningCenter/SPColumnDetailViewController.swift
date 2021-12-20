//
//  SPColumnDetailViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/12/16.
//

import Foundation

import JXSegmentedView


extension JXPagingListContainerView: JXSegmentedViewListContainer {}

// MARK: ------------------------- Const/Enum/Struct

extension SPColumnDetailViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Propertys {}
    
    /// 外部参数
    struct Params {}
    
}

class SPColumnDetailViewController: UIViewController {
    var pagingView: JXPagingView!
    var userHeaderView: PagingViewTableHeaderView!
    var segmentedViewDataSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView!
    let titles = ["能力", "爱好", "队友"]
    var JXTableHeaderViewHeight: Int = 200
    var JXheightForHeaderInSection: Int = 50

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人中心"
        self.navigationController?.navigationBar.isTranslucent = false

        userHeaderView = PagingViewTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(JXTableHeaderViewHeight)))

        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedViewDataSource = JXSegmentedTitleDataSource()
        segmentedViewDataSource.titles = titles
        segmentedViewDataSource.titleSelectedColor = UIColor(red: 105/255, green: 144/255, blue: 239/255, alpha: 1)
        segmentedViewDataSource.titleNormalColor = UIColor.black
        segmentedViewDataSource.isTitleColorGradientEnabled = true
        segmentedViewDataSource.isTitleZoomEnabled = true

        segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: CGFloat(JXheightForHeaderInSection)))
        segmentedView.backgroundColor = UIColor.white
        segmentedView.dataSource = segmentedViewDataSource
        segmentedView.isContentScrollViewClickTransitionAnimationEnabled = false

        let lineView = JXSegmentedIndicatorLineView()
        lineView.indicatorColor = UIColor(red: 105/255, green: 144/255, blue: 239/255, alpha: 1)
        lineView.indicatorWidth = 30
        segmentedView.indicators = [lineView]

        pagingView = JXPagingView(delegate: self)

        self.view.addSubview(pagingView)
        
        segmentedView.listContainer = pagingView.listContainerView
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("isEnabled ====",self.navigationController?.interactivePopGestureRecognizer?.isEnabled)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        pagingView.frame = self.view.bounds
    }
}

extension SPColumnDetailViewController: JXPagingViewDelegate {

    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return JXTableHeaderViewHeight
    }

    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return userHeaderView
    }

    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return JXheightForHeaderInSection
    }

    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }

    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return titles.count
    }

    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        let list = PagingListBaseView()
        if index == 0 {
            let vc = SPCourseListViewControer()
            vc.listViewDidScrollCallback { scrollView in
                print("===scrollViewscrollView===",scrollView)
                
            }
            return vc
            list.dataSource = ["橡胶火箭", "橡胶火箭炮", "橡胶机关枪", "橡胶子弹", "橡胶攻城炮", "橡胶象枪", "橡胶象枪乱打", "橡胶灰熊铳", "橡胶雷神象枪", "橡胶猿王枪", "橡胶犀·榴弹炮", "橡胶大蛇炮", "橡胶火箭", "橡胶火箭炮", "橡胶机关枪", "橡胶子弹", "橡胶攻城炮", "橡胶象枪", "橡胶象枪乱打", "橡胶灰熊铳", "橡胶雷神象枪", "橡胶猿王枪", "橡胶犀·榴弹炮", "橡胶大蛇炮"]
        }else if index == 1 {
            let vc = SPCourseListViewControer()
            return vc
//            list.dataSource = ["吃烤肉", "吃鸡腿肉", "吃牛肉", "各种肉"]
        }else {
            list.dataSource = ["【剑士】罗罗诺亚·索隆", "【航海士】娜美", "【狙击手】乌索普", "【厨师】香吉士", "【船医】托尼托尼·乔巴", "【船匠】 弗兰奇", "【音乐家】布鲁克", "【考古学家】妮可·罗宾"]
        }
        list.beginFirstRefresh()
        return list
    }

    func mainTableViewDidScroll(_ scrollView: UIScrollView) {
        userHeaderView?.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
    }
    
}


