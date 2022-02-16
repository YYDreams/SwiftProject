//
//  UITableView+Extension.swift
//  XMUtil
//
//  Created by flowerflower on 2021/9/4.
//

import Foundation
import UIKit
public protocol Reusable {
    static var reuserIdentifier:String {get}
}

public extension Reusable {
    
    static var reuserIdentifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell : Reusable {}

extension UITableViewHeaderFooterView :Reusable {}

extension UICollectionViewCell : Reusable {}

extension UICollectionReusableView : Reusable {}


public extension UITableView {
    
    
    func cell<T: UITableViewCell>(ofType cellType: T.Type = T.self, reuserIdentifier: String = T.reuserIdentifier) -> T {
        guard let cell  = self.dequeueReusableCell(withIdentifier: reuserIdentifier) as? T else {
            let cell  = T.init(style: .default, reuseIdentifier: reuserIdentifier)
            return cell
        }
        return cell
    }
    
    func headerFooter<T: UITableViewHeaderFooterView>(ofType viewType: T.Type, reuserIdentifier:String = T.reuserIdentifier)-> T {
        guard  let view = self.dequeueReusableHeaderFooterView(withIdentifier: reuserIdentifier) as? T  else {
            fatalError()
        }
        return view
    }
    func registerCell<T: UITableViewCell>(ofType cell: T.Type){
        register(cell, forCellReuseIdentifier: T.reuserIdentifier)
    }
    func registerHeader<T: UITableViewHeaderFooterView>(ofType header: T.Type){
        register(header, forHeaderFooterViewReuseIdentifier: T.reuserIdentifier)
    }
    
    
}
public extension UICollectionView {

    func cell<T: UICollectionViewCell>(ofType cellType: T.Type = T.self, reuserIdentifier: String = T.reuserIdentifier, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuserIdentifier, for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
    
    func registerCell<T :UICollectionViewCell>(ofType cell : T.Type) {
        register(cell, forCellWithReuseIdentifier: T.reuserIdentifier)
    }
    
    func headerFooter<T: UICollectionReusableView>(ofType cell : T.Type,
                                                   kind:String ,
                                                   reuserIdentifier: String = T.reuserIdentifier,
                                                   indepath:IndexPath) -> T {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: kind,
                                                               withReuseIdentifier: reuserIdentifier,
                                                               for: indepath) as? T else {
            fatalError()
        }
        return view
    }
    
    func registerHeader<T :UICollectionReusableView>(ofType header : T.Type,kind:String) {
        register(header, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuserIdentifier)
    }
    
}

