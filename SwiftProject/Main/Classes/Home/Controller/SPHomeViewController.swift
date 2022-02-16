//
//  SPHomeViewController.swift
//  SPHomeUI
//
//  Created by flowerflower on 2021/12/17.
//

import Foundation

import JXCategoryView

import RxSwift
import RxCocoa
extension SPHomeViewController {
    /// 常量
    struct Const {
       static let  JXheightForHeaderInSection:CGFloat = 46
    }
    /// 内部属性
    struct Porpertys {
        var viewModel = SPHomeBaseViewModel()
        var dataArr = [SPHomeBaseViewModel]()
        var moduleSignType: SPModuleSignType = .none
    }
    
    /// 外部参数
    struct Params {
        var  pageContentId: String = ""
    }
}

class SPHomeViewController:  BaseUIViewController{
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    var mainScrollView: UIScrollView!
    
    var pagerHeader: UITableView!
    
    var categoryView: JXCategoryTitleView!

    var listContainerView: JXCategoryListContainerView!
    
    var pagerContainer: UIView!
    
    var topView: SPHomeTopView!
    
    var currentSubScroll: UIScrollView?
    
    
    /// 垃圾收集器
    let disposeBag = DisposeBag()
    
    
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightOnClick))
        setupSubViews()
        setupRefresh()
        
    
     
        
        
    }
    @objc func injected() {
        #if DEBUG
          print("I've been injected: \(self)")
        
          #endif
    }


    func setupRefresh() {
        
        requestData()
    }
    
  @objc   func rightOnClick(){
        
    self.requestData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    func setupSubViews(){
        
        self.mainScrollView = {
           let mainScrollView = UIScrollView()
            mainScrollView.delegate = self
            mainScrollView.showsVerticalScrollIndicator = true
            return mainScrollView
        }()
        
        let stackView:UIStackView = {
            let stackView = UIStackView()
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.axis = .vertical
            stackView.backgroundColor = UIColor.clear
            return stackView
        }()
        self.pagerHeader = {
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.bounces = false
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorStyle = .none
            tableView.backgroundColor = UIColor.clear
            tableView.estimatedRowHeight = 100
            return tableView
        }()
        self.pagerContainer = {
           let view = UIView()
            return view
        }()
        self.categoryView = {
//            let  categoryView = SPHomeCategoryHeaderView()
            let  categoryView = JXCategoryTitleView()
            categoryView.defaultSelectedIndex = 0;
            categoryView.titleSelectedColor = UIColor(hexInt: 0x0165B8)
//                [UIColor colorWithHex:0x0165B8];
            categoryView.titleColor = UIColor(hexInt: 0x222427)
//                [UIColor colorWithHex:0x222427];
            categoryView.titleSelectedFont = UIFont.systemFont(ofSize: 14)
//                [UIFont systemFontOfSize:14.f weight:UIFontWeightMedium];
            categoryView.titleFont = UIFont.systemFont(ofSize: 16)
//                [UIFont systemFontOfSize:14.f weight:UIFontWeightRegular];
            categoryView.isTitleColorGradientEnabled = true
            categoryView.isContentScrollViewClickTransitionAnimationEnabled = true
            
            categoryView.delegate = self
            categoryView.backgroundColor = UIColor.clear
            categoryView.titles = ["test1","test2","test3"]
            
//            categoryView.titles = self.titleDes;
//            categoryView.timeTitles = self.titles;
//            categoryView.titleLabelVerticalOffset = 13;
//            categoryView.titleColorGradientEnabled = YES;
//            categoryView.titleDataSource = self;
            let lineView = JXCategoryIndicatorLineView()
            lineView.indicatorColor = UIColor(hexInt: 0x0165b8)
            lineView.indicatorWidth = 24
            lineView.indicatorCornerRadius = 0
            lineView.verticalMargin = 6
            lineView.indicatorHeight = 2
//            let backgroundView = JXCategoryIndicatorBackgroundView()
//            backgroundView.indicatorHeight = 16
//            backgroundView.verticalMargin = CGFloat(-SPHomeCategoryHeaderCellTitleOffset)
//            backgroundView.indicatorCornerRadius = 0
//            backgroundView.indicatorWidthIncrement = 0
//            backgroundView.indicatorColor = UIColor(hexInt: 0x0165b8)
            categoryView.indicators = [lineView]
            return categoryView
        }()
        

        self.listContainerView = {
            let listContainerView = JXCategoryListContainerView(type: .scrollView, delegate: self)
            return listContainerView
        }()
        self.topView = {
           let view = SPHomeTopView()
            view.backgroundColor = UIColor.blue
            return view
        }()
        
        
        if !self.params.pageContentId.isEmpty {
            view.addSubview(topView)
            topView.snp.makeConstraints{
                $0.left.top.right.equalToSuperview()
                $0.height.equalTo(127 + kStatusBarHeight)
            }
        }
    
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(stackView)
        stackView.addArrangedSubview(pagerHeader)
        stackView.addArrangedSubview(pagerContainer)
        pagerContainer.addSubview(categoryView)
        pagerContainer.addSubview(listContainerView)
        self.categoryView.listContainer = self.listContainerView;

        
        mainScrollView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            if (!self.params.pageContentId.isEmpty) {
                $0.top.equalTo(self.topView.snp.bottom);
                $0.bottom.equalTo(-kSafeAreaBottom)
            }else{
                $0.top.equalTo(self.view);
                $0.bottom.equalTo(self.view);
            }
            $0.left.right.equalTo(0)
        }
        stackView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.centerX.equalTo(self.mainScrollView)
            $0.top.bottom.equalTo(self.mainScrollView)
        }
        
        stackView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.centerX.equalTo(self.mainScrollView)
            $0.top.bottom.equalTo(self.mainScrollView)
        }
        
        pagerHeader.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(0)
            $0.height.equalTo(100)
        }
        
        pagerContainer.snp.makeConstraints{
            $0.height.equalTo(kScreenHeight - (kNavBarHeight + kTabBarHeight))
        }
        categoryView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(0)
            $0.height.equalTo(Const.JXheightForHeaderInSection)
        }
        listContainerView.snp.makeConstraints{
            $0.edges.equalTo(UIEdgeInsets(top: Const.JXheightForHeaderInSection, left: 0, bottom: 0, right: 0))
        }
  
//
//        [self.bottomGuideView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(12.f);
//            make.right.mas_equalTo(-15.f);
//            make.bottom.mas_equalTo(-(20.f + TabBarHeight));
//            make.height.mas_equalTo(50.f);
//        }];

//        [self.anchorView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(0.f);
//            if (self.pageContentId) {
//                make.bottom.mas_equalTo(0);
//            }else{
//                make.bottom.mas_equalTo(-(TabBarHeight));
//            }
//            make.height.mas_equalTo(50.f);
//        }];

//        [self.suspendShopCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(0);
//            make.bottom.mas_equalTo(-188.f);
//            make.height.mas_equalTo(90.f);
//            make.width.mas_equalTo(90.f);
//        }];



        //        self.pagerHeader.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        self.pagerHeader.backgroundColor = UIColor.red
        self.pagerContainer.backgroundColor = UIColor.orange
        self.pagerHeader.rx.observe(CGSize.self, "contentSize").subscribe { (contentSize:CGSize?) in
            let height = contentSize?.height ?? 0
            self.pagerHeader.snp.updateConstraints{
                $0.height.equalTo(height)
            }
        }.disposed(by: disposeBag)
        
        self.mainScrollView.rx.observe(CGSize.self, "contentSize").subscribe {  (contentSize:CGSize?) in
            
            let size = contentSize ?? .zero
            let contentHeight = kScreenHeight  - kNavBarHeight - kTabBarHeight
            if size.height < contentHeight{
                self.mainScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: contentHeight - size.height, right: 0)
            }else{
                self.mainScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
            }
        }.disposed(by: disposeBag)
        


//
//        [RACObserve(self.mainScrollView, contentSize) subscribeNext:^(id  _Nullable x) {
//            CGSize size = [x CGSizeValue];
//            CGFloat contentHeight = SCREEN_HEIGHT - NavigationBarHeight - TabBarHeight;
//            if (size.height < contentHeight) {
//                self.mainScrollView.contentInset = UIEdgeInsetsMake(0, 0, contentHeight - size.height, 0);
//            } else {
//                self.mainScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//            }
//        }];
//
//        [RACObserve(self.mainModel, pageLocationViewModel) subscribeNext:^(id  _Nullable x) {
//            if (x) {
//                self.anchorView.viewModel = x;
//            }
//        }];
//
//        [RACObserve(self.anchorView, viewHeight) subscribeNext:^(id  _Nullable x) {
//            [self.anchorView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo([x floatValue]);
//            }];
//            [self.mainScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
//                if (self.pageContentId) {
//                    make.bottom.mas_equalTo(-[x floatValue]);
//                }else{
//                    make.bottom.mas_equalTo(-(TabBarHeight)-[x floatValue]);
//                }
//            }];
//            [self.pagerContainer mas_updateConstraints:^(MASConstraintMaker *make) {
//                if (self.pageContentId) {
//                    make.height.mas_equalTo(SCREEN_HEIGHT - (NavigationBarHeight + StatusBarHeight)-[x floatValue]);
//                }else{
//                    make.height.mas_equalTo(SCREEN_HEIGHT - (NavigationBarHeight + TabBarHeight + StatusBarHeight)-[x floatValue]);
//                }
//            }];
//        }];
        
        
        self.listContainerView.reloadData()
        
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//
//        let height = self.pagerHeader.contentSize.height
//        print("height====",height)
//
//        self.pagerHeader.snp.updateConstraints{
//            $0.height.equalTo(height)
//        }
//    }
//    override class func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        
        //            CGSize size = [x CGSizeValue];
        //            [self.pagerHeader mas_updateConstraints:^(MASConstraintMaker *make) {
        //                make.height.mas_equalTo(floorf(size.height));
        //            }];
        
//        guard let  height = self.tableView?.contentSize.height else { return}
//        if self.propertys.accountHeight != height {
//            self.stackView?.snp.updateConstraints({ make in
//                if let height = self.tableView?.contentSize.height {
//                    self.propertys.accountHeight  = height
//                    make.height.equalTo(height + 62)
//                }
//            })
//        }
//    }
    
    func refreshUI(){
        
        
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
}

extension SPHomeViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.propertys.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  viewModel = self.propertys.dataArr[safe: indexPath.row]
        let cellClass: SPHomeModuleBaseCell.Type = viewModel?.cellClass() as? SPHomeModuleBaseCell.Type ?? SPHomeModuleBaseCell.self
        let cellIndentifier = NSStringFromClass(cellClass)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier) as? SPHomeModuleBaseCell
        if cell == nil {
            cell = cellClass.init(style: .default, reuseIdentifier: cellIndentifier)
            cell?.refreshUI(viewModel)
        }
        return cell ?? SPHomeModuleBaseCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if !self.pagerContainer.isHidden {
            let conetentY = scrollView.contentOffset.y
            let subContentY: CGFloat = self.currentSubScroll?.contentOffset.y ?? 0
            
            if (conetentY > self.pagerHeader.frame.maxY) || subContentY > 0 {
                scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: self.pagerHeader.frame.maxY)
            }
        }
        
    }
}

extension SPHomeViewController: JXCategoryViewDelegate,JXCategoryListContainerViewDelegate{
    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        
        return self.categoryView.titles.count
    }
    
    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        
        
        let vc = SPHomeSubViewController()
        vc.handlerDidScrollBlock = { [weak self] scrollView in

            self?.currentSubScroll = scrollView
            
            if (self?.mainScrollView.contentOffset.y ?? 0 < floor(self?.pagerHeader.frame.maxY ?? 0)) || scrollView.contentOffset.y  < 0 {
                scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: 0)
            }
        }
        return vc
    }

}

extension SPHomeViewController: UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
    
        if otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer {
            return false
        }
        let visibleCells = self.pagerHeader.visibleCells
        for item in visibleCells {
//            if item.responds(to: #selector()) {
////                <#code#>
//            }
        }
        
        print("gestureRecognizer",gestureRecognizer)
        
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
    
}
