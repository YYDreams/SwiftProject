//
//  SPPageSmoothView.swift
//  SwiftProject
//
//  Created by flower on 2024/7/8.
//

import Foundation
import UIKit
@objc public protocol SPPageSmoothListViewDelegate: NSObjectProtocol{
    
    /// 返回listView，如果是vc就返回vc.view,如果是自定义view，就返回view本身
    func listView() -> UIView
    
    /// 返回vc或view内部持有的UIScrollView或UITableView或UICollectionView
    func listScrollView() -> UIScrollView
    
    /// 当contentSize改变且不足一屏时，是否重置scrollView的位置，默认YES
    @objc optional func listScrollViewShouldReset() -> Bool
    
}

@objc public protocol SPPageSmoothViewDelegate: NSObjectProtocol{
    
    /// 当前列表滑动代理
    /// - Parameters:
    ///   - smoothView: smoothView
    ///   - scrollView: 当前的列表scrollView
    ///   - contentOffset: 转换后的contentOffset
    @objc optional func smoothViewListScrollViewDidScroll(_ smoothView: SPPageSmoothView, scrollView: UIScrollView, contentOffset: CGPoint)
}

@objc public protocol SPPageSmoothViewDataSource : NSObjectProtocol {
    
    /// 返回页面header视图
    /// - Parameter smoothView: smoothView
    /// - Returns: UIView
    func headerView(in smoothView: SPPageSmoothView) -> UIView
    
    /// 返回需要悬浮的分段视图
    /// - Parameter smoothView: smoothView
    /// - Returns: UIView
    func segmentedView(in smoothView: SPPageSmoothView) -> UIView
    
    /// 返回列表个数
    /// - Parameter smoothView: smoothView
    func numberOfLists(in smoothView: SPPageSmoothView) -> Int
    
    /// 根据index初始化一个列表实例，列表需实现`SPPageSmoothListViewDelegate`代理
    /// - Parameters:
    ///   - smoothView: smoothView
    ///   - index: 列表索引
    func smoothView(_ smoothView: SPPageSmoothView, initListAtIndex index: Int) -> SPPageSmoothListViewDelegate
    
}

open  class SPPageSmoothView: UIView{
    private let cellIdentifier = "YYPageSmoothViewCellID"
    
    public weak var delegate: SPPageSmoothViewDelegate?
    
    public weak var dataSource: SPPageSmoothViewDataSource?
    
    /// view
    lazy var headerContainerView: UIView = { return UIView() }()
    lazy var bottomContainerView: UIView = { return UIView() }()
    
    var headerView: UIView?
    var segmentedView: UIView?
    
    public var listCollectionView: SPPageSmoothCollectionView
    // 当前列表
    public private(set) var currentListScrollView: UIScrollView?
    
    /// header容器的高度
    public private(set) var headerContainerHeight: CGFloat = 0
    var headerHeight: CGFloat = 0
    var segmentedHeight: CGFloat = 0
    var currentListInitailzeContentOffsetY: CGFloat = 0
    
    ///辅助属性
    var isLoaded: Bool = false
    var isSyncListContentOffsetEnabled: Bool = false
    var currentHeaderContainerViewY: CGFloat = 0
    // 吸顶临界高度，默认0
    public var ceilPointHeight: CGFloat = 0
    // 是否撑起scrollView，默认false
    // 如果设置为YES则当scrollView的contentSize不足时会修改scrollView的contentSize使其能够滑动到悬浮状态
    public var isHoldUpScrollView: Bool = false
    
    // 当前索引
    public private(set) var currentIndex: Int = 0
    
    var listHeaderDict = [Int: UIView]()
    // 当前已经加载过的可用的列表字典，key是index值，value是对应列表
    public private(set) var listDict = [Int: SPPageSmoothListViewDelegate]()
    // 是否内部控制指示器的显示与隐藏（默认为false）
    public var isControlVerticalIndicator: Bool = false
    
    public init(dataSource: SPPageSmoothViewDataSource) {
        self.dataSource = dataSource
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        listCollectionView = SPPageSmoothCollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: .zero)
        initSubViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func reloadData(){
        currentListScrollView = nil
        currentHeaderContainerViewY = 0
        isSyncListContentOffsetEnabled = false
        isLoaded = true
        listHeaderDict.removeAll()
        removeObserver()
        listDict.removeAll()
        refreshWidth { size in
            self.set(scrollView: self.listCollectionView, offset: CGPoint(x: Int(size.width) * self.currentIndex, y: 0))
            self.listCollectionView.reloadData()
        }
    }
    /// 刷新headerView，headerView高度改变时调用
    public func refreshHeaderView() {
        loadHeaderAndSegmentedView()
        refreshHeaderContainerView()
    }
    
    /// 刷新segmentedView，segmentedView高度改变时调用
    public func refreshSegmentedView() {
        segmentedView = dataSource?.segmentedView(in: self)
        headerContainerView.addSubview(segmentedView!)
        refreshHeaderContainerHeight()
        refreshHeaderContainerView()
    }
    
    deinit{
        removeObserver()
        listCollectionView.dataSource = nil
        listCollectionView.delegate = nil
    }
    func removeObserver(){
        listDict.values.forEach{
            $0.listScrollView().removeObserver(self, forKeyPath: "contentOffset")
            $0.listScrollView().removeObserver(self, forKeyPath: "contentSize")
            $0.listView().removeFromSuperview()
        }
        listDict.removeAll()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if listCollectionView.superview == self{
            refreshList(frame: bounds)
            listCollectionView.frame = bounds
        }
        listHeaderDict.values.forEach {
            var frame = $0.frame
            frame.origin.y = -headerContainerHeight
            frame.size.height = headerContainerHeight
            $0.frame = frame
        }
    }
    func refreshList(frame: CGRect) {
        listDict.values.forEach {
            var f = $0.listView().frame
            if ((f.width != 0 && f.width != frame.width) || (f.height != 0 && f.height != frame.height)) {
                f.size.width = frame.width
                f.size.height = frame.height
                $0.listView().frame = f
                listCollectionView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) { [weak self] in
                    guard let self = self else { return }
                    self.set(scrollView: self.listCollectionView, offset: CGPointMake(CGFloat(self.currentIndex) * frame.width, 0))
                }
            }
        }
    }
    private func initSubViews(){
        
        listCollectionView.dataSource = self
        listCollectionView.delegate = self
        listCollectionView.isPagingEnabled = true
        listCollectionView.bounces = false
        listCollectionView.showsHorizontalScrollIndicator = false
        listCollectionView.showsVerticalScrollIndicator = false
        listCollectionView.scrollsToTop = false
        listCollectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: cellIdentifier)
        if #available(iOS 10.0, *) {
            listCollectionView.isPrefetchingEnabled = false
        }
        if #available(iOS 11.0, *) {
            listCollectionView.contentInsetAdjustmentBehavior = .never
        }
        listCollectionView.headerContainerView = headerContainerView
        addSubview(listCollectionView)
        addSubview(headerContainerView)
        refreshHeaderView()
    }
    
    func loadHeaderAndSegmentedView(){
        headerView = dataSource?.headerView(in: self)
        segmentedView = dataSource?.segmentedView(in: self)
        headerContainerView.addSubview(headerView!)
        headerContainerView.addSubview(segmentedView!)
        refreshHeaderContainerHeight()
    }
    func refreshHeaderContainerHeight(){
        headerHeight = headerView?.bounds.height ?? 0
        segmentedHeight = segmentedView?.bounds.height ?? 0
        headerContainerHeight = headerHeight + segmentedHeight
        
    }
    
    func refreshHeaderContainerView() {
        refreshWidth { [weak self] (size) in
            guard let self = self else { return }
            self.refreshHeaderContainerHeight()
            
            var frame = self.headerContainerView.frame
            if __CGSizeEqualToSize(frame.size, .zero) {
                frame = CGRect(x: 0, y: 0, width: size.width, height: self.headerContainerHeight)
            }else {
                frame.size.height = self.headerContainerHeight
            }
            self.headerContainerView.frame = frame
            
            self.headerView?.frame = CGRect(x: 0, y: 0, width: size.width, height: self.headerHeight)
            self.segmentedView?.frame = CGRect(x: 0, y: self.headerHeight, width: size.width, height: self.segmentedHeight)
            
            if self.segmentedView?.superview != self.headerContainerView { // 修复headerHeight < size.height, headerContainerHeight > size.height时segmentedView.superView为bottomContainerView
                self.headerContainerView.addSubview(self.segmentedView!)
            }
            
            self.listDict.values.forEach {
                var insets = $0.listScrollView().contentInset
                insets.top = self.headerContainerHeight
                $0.listScrollView().contentInset = insets
                self.set(scrollView: $0.listScrollView(), offset: CGPoint(x: 0, y: -self.headerContainerHeight))
            }
            self.listHeaderDict.values.forEach {
                var frame = $0.frame
                frame.origin.y = -self.headerContainerHeight
                frame.size.height = self.headerContainerHeight
                $0.frame = frame
            }
            
        }
    }
    // MARK: - KVO
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            if let scrollView = object as? UIScrollView {
                listDidScroll(scrollView: scrollView)
            }
        } else if keyPath == "contentSize" {
            let minContentSizeHeight = bounds.height - segmentedHeight - ceilPointHeight
            if let scrollView = object as? UIScrollView {
                let contentH = scrollView.contentSize.height
                if minContentSizeHeight > contentH && isHoldUpScrollView {
                    scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: minContentSizeHeight)
                    //新的scrollView第一次加载的时候重置contentOffset
                    if let listScrollView = currentListScrollView {
                        if scrollView != listScrollView && scrollView.contentSize != .zero {
                            set(scrollView: scrollView, offset: CGPoint(x: 0, y: currentListInitailzeContentOffsetY))
                        }
                    }
                }else {
                    var shoudReset = true
                    for list in listDict.values {
                        if list.listScrollView() == scrollView && list.listScrollViewShouldReset?() != nil {
                            shoudReset = list.listScrollViewShouldReset!()
                        }
                    }
                    
                    if minContentSizeHeight > contentH && shoudReset  {
                        set(scrollView: scrollView, offset: CGPoint(x: scrollView.contentOffset.x, y: -headerContainerHeight))
                        listDidScroll(scrollView: scrollView)
                    }
                }
            }
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    func listHeader(for listScrollView: UIScrollView) -> UIView? {
        for (index, list) in listDict {
            if list.listScrollView() == listScrollView {
                return listHeaderDict[index]
            }
        }
        return nil
    }
    
    func listIndex(for listScrollView: UIScrollView) -> Int {
        for (index, list) in listDict {
            if list.listScrollView() == listScrollView {
                return index
            }
        }
        return 0
    }
    
    // MARK: - Private Methods
    func listDidScroll(scrollView: UIScrollView) {
        if listCollectionView.isDragging || listCollectionView.isDecelerating { return }
        
        let index = listIndex(for: scrollView)
        if index != currentIndex { return }
        currentListScrollView = scrollView
        let contentOffsetY = scrollView.contentOffset.y + headerContainerHeight
        
        if contentOffsetY < (headerHeight - ceilPointHeight) {
            isSyncListContentOffsetEnabled = true
            currentHeaderContainerViewY = -contentOffsetY
            listDict.values.forEach {
                if $0.listScrollView() != scrollView {
                    set(scrollView: $0.listScrollView(), offset: scrollView.contentOffset)
                }
            }
            let header = listHeader(for: scrollView)
            if headerContainerView.superview != header {
                headerContainerView.frame.origin.y = 0
                header?.addSubview(headerContainerView)
            }
            
            if isControlVerticalIndicator && ceilPointHeight != 0 {
                currentListScrollView?.showsVerticalScrollIndicator = false
            }
            
        }else {
            if headerContainerView.superview != self {
                headerContainerView.frame.origin.y = -(headerHeight - ceilPointHeight)
                addSubview(headerContainerView)
            }
            
            if isControlVerticalIndicator {
                currentListScrollView?.showsVerticalScrollIndicator = true
            }
            
            if isSyncListContentOffsetEnabled {
                isSyncListContentOffsetEnabled = false
                currentHeaderContainerViewY = -(headerHeight - ceilPointHeight)
                listDict.values.forEach {
                    if ($0.listScrollView() != currentListScrollView) {
                        set(scrollView: $0.listScrollView(), offset: CGPoint(x: 0, y: -(segmentedHeight + ceilPointHeight)))
                    }
                }
            }
        }
        let contentOffset = CGPoint(x: scrollView.contentOffset.x, y: contentOffsetY)
        delegate?.smoothViewListScrollViewDidScroll?(self, scrollView: scrollView, contentOffset: contentOffset)
    }
    
    
    private func set(scrollView: UIScrollView?, offset: CGPoint){
        guard let scrollView = scrollView else { return }
        if !__CGPointEqualToPoint(scrollView.contentOffset, offset){
            scrollView.setContentOffset(offset, animated: false)
        }
    }
    func refreshWidth(completion: @escaping (_ size: CGSize)->()){
        if bounds.width == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                completion(self.bounds.size)
            }
        }else{
            completion(self.bounds.size)
        }
    }
}
extension SPPageSmoothView: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        return isLoaded ? dataSource.numberOfLists(in: self) : 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let dataSource = dataSource else { return UICollectionViewCell(frame: CGRect.zero) }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        var list = listDict[indexPath.item]
        if list == nil {
            list = dataSource.smoothView(self, initListAtIndex: indexPath.item)
            if let listVC = list as? UIViewController {
                var next: UIResponder? = superview
                while next != nil {
                    if let vc = next as? UIViewController {
                        vc.addChild(listVC)
                        break
                    }
                    next = next?.next
                }
            }
            listDict[indexPath.item] = list!
            list?.listView().setNeedsLayout()
            
            let listScrollView = list?.listScrollView()
            if #available(iOS 11.0, *) {
                list?.listScrollView().contentInsetAdjustmentBehavior = .never
            }
            
            if let scrollView = list?.listScrollView() {
                let minContentSizeHeight = bounds.height - segmentedHeight - ceilPointHeight
                if scrollView.contentSize.height < minContentSizeHeight && isHoldUpScrollView {
                    scrollView.contentSize = CGSize(width: bounds.width, height: minContentSizeHeight)
                }
            }
            var insets = list?.listScrollView().contentInset
            insets?.top = headerContainerHeight
            list?.listScrollView().contentInset = insets ?? .zero
            currentListInitailzeContentOffsetY = -headerContainerHeight + min(-currentHeaderContainerViewY, (headerHeight - ceilPointHeight))
            set(scrollView: list?.listScrollView(), offset: CGPoint(x: 0, y: currentListInitailzeContentOffsetY))
            
            let listHeader = UIView(frame: CGRect(x: 0, y: -headerContainerHeight, width: bounds.width, height: headerContainerHeight))
            listScrollView?.addSubview(listHeader)
            
            if headerContainerView.superview == nil {
                listHeader.addSubview(headerContainerView)
            }
            listHeaderDict[indexPath.item] = listHeader
            
            list?.listScrollView().addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
            list?.listScrollView().addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
            // bug fix #69 修复首次进入时可能出现的headerView无法下拉的问题
            listScrollView?.contentOffset = listScrollView!.contentOffset
        }
        listDict.values.forEach {
            $0.listScrollView().scrollsToTop = ($0 === list)
        }
        if let listView = list?.listView(), listView.superview != cell.contentView {
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            listView.frame = cell.bounds
            cell.contentView.addSubview(listView)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        listDict.values.forEach { [weak self] in
            guard let self = self else { return }
            $0.listView().frame = CGRect.init(origin: .zero, size: self.listCollectionView.bounds.size)
        }
        return listCollectionView.bounds.size
    }
}

public class SPPageSmoothCollectionView:UICollectionView,UIGestureRecognizerDelegate{
    var headerContainerView: UIView?
    
    /// 判断手势识别器是否应接收触摸事件。
    /// - Parameters:
    ///   - gestureRecognizer: 手势识别器对象。
    ///   - touch: 发生的触摸事件。
    /// - Returns: 如果手势识别器应接收触摸事件，则返回 `true`，否则返回 `false`。
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // 获取触摸点相对于 `headerContainerView` 的位置。
        let point = touch.location(in: headerContainerView)
        
        // 检查触摸点是否在 `headerContainerView` 的边界内。
        if headerContainerView?.bounds.contains(point) == true {
            // 如果触摸点在 `headerContainerView` 内部，则不接收触摸事件。
            return false
        }
        // 如果触摸点在 `headerContainerView` 外部，则接收触摸事件。
        return true
    }
}
