//
//  SPHomeBaseCollection.swift
//  SPHomeUI
//
//  Created by flowerflower on 2021/12/19.
//

import Foundation
import UIKit

class SPHomeBaseCollection: UICollectionView,UIGestureRecognizerDelegate{
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
