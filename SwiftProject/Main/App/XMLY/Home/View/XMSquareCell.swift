//
//  XMSquareCell.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/4/1.
//

import UIKit
import SnapKit
import Kingfisher
// MARK: ------------------------- Const/Enum/Struct

extension XMSquareCell {
    
    /// 常量
    struct Const {
        public  static let itemSizeWidth = 96
        public  static let margin = 16
        public  static let minimumLineSpacing = 12
        
    }
    
    /// 内部属性
    struct Propertys {}
    
    /// 外部参数
    struct Params {
        public var dataArr : [XMSquareCollectionCell.Model]?

    }
    
}

class XMSquareCell: UITableViewCell {
    
    // MARK: ------------------------- Propertys
   
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: CGFloat(Const.margin), bottom: 0, right: CGFloat(Const.margin))
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(XMSquareCollectionCell.self, forCellWithReuseIdentifier: XMSquareCollectionCell.reuserIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return collectionView
    }()
    
    
    // MARK: ------------------------- CycLife
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    func refreshUI(dataArr:[XMSquareCollectionCell.Model]?){
        self.params.dataArr = dataArr
        textLabel?.text = "xxxxxxxxxxx"
        print("refreshUI(shopList:[UserShopModel] ---",dataArr?.count ?? 0)
        collectionView.reloadData()
    }
    
}

extension XMSquareCell:UICollectionViewDataSource,UICollectionViewDelegate{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.params.dataArr?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XMSquareCollectionCell.reuserIdentifier, for: indexPath)
        
        return cell
    }
    
    
}

// MARK: ------------------------- Const/Enum/Struct

extension XMSquareCollectionCell {
    
    public class Model {
        public var title: String?
        public var imgUrl: String?
    }
    
    /// 常量
    struct Const {

    }
    
    /// 内部属性
    public struct Propertys {}
    
    /// 外部参数
    public struct Params {
        public var model: Model?
    }
    
}


class XMSquareCollectionCell: UICollectionViewCell{
    
    /// 内部属性
    public var propertys: Propertys = Propertys()
    /// 外部参数
    public var params: Params = Params()
    
    lazy var imgView: UIImageView = {
        let imgView: UIImageView = UIImageView()
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexInt: 0xB2B2B2)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupSubViews(){
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        imgView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.width.height.equalTo(48)
            $0.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(4)
            $0.left.right.equalToSuperview()
        }
        
    }
    public func refreshUI(model: Model?) {
        titleLabel.text = model?.title
        if let imgUrl = model?.imgUrl {
            imgView.kf.setImage(with: URL(string: imgUrl), placeholder: UIImage(named: ""))
        }
    }
  
}
