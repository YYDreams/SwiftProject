//
//  SPHomeSubViewController.swift
//  SPHomeUI
//
//  Created by flowerflower on 2021/12/18.
//

import Foundation
import JXCategoryView
import UIKit


// MARK: ------------------------- Const/Enum/Struct

extension SPHomeSubViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Propertys {}
    
    /// 外部参数
    struct Params {}
    
}

class SPHomeSubViewController: BaseUIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    

    
    
    // MARK: ------------------------- Propertys
    
    var handlerDidScrollBlock:((_ scrollView: UIScrollView) -> Void)?
    
    var handerListWillAppearCallBack:((_ scrollView: UIScrollView) -> Void)?
    
    
    
    lazy var collectionView: SPHomeBaseCollection = {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 0.1
        layout.minimumInteritemSpacing = 0.1
        var collectionView: SPHomeBaseCollection = SPHomeBaseCollection.init(frame: .zero, collectionViewLayout: layout)
        collectionView.scrollsToTop = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerCell(ofType: SPHomeRecommendGoodsCell.self)
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(UIEdgeInsets.zero)
        }

    }
    
    func setupSubViews(){
        
        
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
 
    
//     func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scrollView,",scrollView)
//        self.handlerDidScrollBlock?(scrollView)
//    }
    
   
}
extension SPHomeSubViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(ofType: SPHomeRecommendGoodsCell.self, indexPath: indexPath)
        cell.titleLabel.text = "index====\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        let itemW: CGFloat = (kScreenWidth)
        var itemH: CGFloat = 50
      
        return CGSize(width: itemW, height: itemH)
        
        
    }
}

extension SPHomeSubViewController:JXCategoryListContentViewDelegate,JXCategoryViewDelegate{
    func listView() -> UIView! {
        return self.view
    }
 
    
    func listWillAppear() {
        handerListWillAppearCallBack?(self.collectionView)
    }
    
    
    
}
