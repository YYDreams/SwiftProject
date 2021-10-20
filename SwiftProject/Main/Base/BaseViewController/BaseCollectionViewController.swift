//
//  BaseCollectionViewController.swift
//  XMHomeUI
//
//  Created by flowerflower on 2021/9/9.
//

import Foundation
import XMUtil



open  class BaseCollectionViewController: UIViewController {



    // MARK: ------------------------- Propertys
    public lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()


    // MARK: ------------------------- CycLife
    open override func viewDidLoad() {

        super.viewDidLoad()
        self.view.addSubview(collectionView)

    }

    // MARK: ------------------------- Events

    public func test(){

    }

    // MARK: ------------------------- Methods

}

extension  BaseCollectionViewController:UICollectionViewDataSource,UICollectionViewDelegate{



    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }


}

