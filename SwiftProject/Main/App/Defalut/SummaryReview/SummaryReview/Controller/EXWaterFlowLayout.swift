//
//  EXWaterFlowLayout.swift
//  EXMediaReaderApp
//
//  Created by flower on 2024/2/21.
//

import Foundation

protocol EXWaterFlowLayoutDelegate: NSObject{
    func waterflowLayout(waterflowLayout: EXWaterFlowLayout, indexPath: IndexPath) -> CGFloat
}

class EXWaterFlowLayout: UICollectionViewFlowLayout{
    
    var columnMargin = 10.0 //每一列之间的间距
    var rowMargin = 10.0 //每一行之间的间距
    var columnCount = 2 //一行显示多少列
    
    weak var delegate: EXWaterFlowLayoutDelegate?
    
    private var maxYDict: [Int: CGFloat] = [:]
    private var attrsArray: [UICollectionViewLayoutAttributes] = []
    
    override init() {
        super.init()
        sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        attrsArray.removeAll()
        maxYDict.removeAll()
        
        for i in 0..<columnCount {
            maxYDict[i] = sectionInset.top
        }
        
        let layoutHeader = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(index: 0))
        layoutHeader.frame = CGRect(x: 0, y: 0, width: headerReferenceSize.width, height: headerReferenceSize.height)
        attrsArray.append(layoutHeader)
        
        let itemCount = collectionView.numberOfItems(inSection: 0)
        for i in 0..<itemCount {
            if let attrs = layoutAttributesForItem(at: IndexPath(item: i, section: 0)) {
                attrsArray.append(attrs)
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        var maxHeight: CGFloat = 0
        maxYDict.forEach { (_, value) in
            if value > maxHeight {
                maxHeight = value
            }
        }
        return CGSize(width: collectionView?.frame.width ?? 0, height: maxHeight + sectionInset.bottom + headerReferenceSize.height)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else { return nil }
        var minColumn = 0
        var minYValue = maxYDict[minColumn] ?? 0
        // 找出高度最短的那一列
        for (column, maxY) in maxYDict {
            if maxY < minYValue {
                minColumn = column
                minYValue = maxY
            }
            if maxY == minYValue && column < minColumn {
                minColumn = column
            }
        }        
        // 计算尺寸
        let width = (collectionView.frame.size.width - sectionInset.left - sectionInset.right - CGFloat(columnCount - 1) * columnMargin) / CGFloat(columnCount)
        let height = delegate?.waterflowLayout(waterflowLayout: self, indexPath: indexPath) ?? 0
        
        let x = sectionInset.left + (width + columnMargin) * CGFloat(minColumn)

        let y = minYValue + rowMargin
        
        maxYDict[minColumn] = y + height
        
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attrs.frame = CGRect(x: x, y: headerReferenceSize.height + y, width: width, height: height)
        return attrs
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
}

