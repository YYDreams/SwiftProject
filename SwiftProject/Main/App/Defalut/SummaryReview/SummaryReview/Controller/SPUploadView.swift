//
//  SPUploadView.swift
//  SwiftProject
//
//  Created by flower on 2024/5/31.
//

import Foundation

class SPUploadView:UIView{
    
     var imageDataArr = [SPUploadModel]()
     var videoDataArr = [SPUploadModel]()
     var type: SPUploadType?
    lazy var layout: EXWaterFlowLayout = {
       let flowLayout = EXWaterFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = .zero
        flowLayout.delegate = self
        flowLayout.columnCount = Int(3)
        flowLayout.rowMargin = 8
        flowLayout.columnMargin = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor(hex: "#F5F5F5")
        collection.showsVerticalScrollIndicator = false
        collection.register(SPUploadCell.self, forCellWithReuseIdentifier: "SPUploadCellID")
        return collection
    }()
    // MARK: ------------------------- CycLife
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  
    func reloadItem(type:SPUploadType, localFileId: String,progress: Double){
        self.type = type
        if type == .image{
            if let model = imageDataArr.first(where: {$0.localFileId == localFileId}){
                model.progress = progress
                collectionView.reloadData()
            }
        }else{
            if let model = videoDataArr.first(where: {$0.localFileId == localFileId}){
                model.progress = progress
                collectionView.reloadData()
            }
        }
        
//        if let index = imageDataArr.firstIndex(where: {$0.localFileId == localFileId}){
//            collectionView.reloadItems(at: [IndexPath(index: index)])
//        }
//        if let index = videoDataArr.firstIndex(where: {$0.localFileId == localFileId}){
//            collectionView.reloadItems(at: [IndexPath(index: index)])
//        }
    }
//    func reloadVideoItem(type:SPUploadType, localFileId: String,progress: Double){
//        self.type = type
//
//    }
    
    func setupSubViews(){
        addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
}
extension SPUploadView:UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type == .image ? imageDataArr.count : videoDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = type == .image ? imageDataArr[safe:indexPath.row] : videoDataArr[safe:indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SPUploadCellID", for: indexPath) as? SPUploadCell
        cell?.refreshUI(model)
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let model = type == .image ? imageDataArr[safe:indexPath.row] : videoDataArr[safe:indexPath.row]
          
        
        
    }
  
    
}
extension SPUploadView:EXWaterFlowLayoutDelegate{
    func waterflowLayout(waterflowLayout: EXWaterFlowLayout, indexPath: IndexPath) -> CGFloat{
        return 100
    }
}
