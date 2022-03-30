//
//  XMHomeListContainerView.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/3/27.
//

import Foundation
import JXCategoryView
protocol XMHomeListContainerViewDelegate: NSObjectProtocol{
    
    func scrollWillBegin()
    func scrollDidEnded()
}


class XMHomeListContainerView: JXCategoryListContainerView,UIScrollViewDelegate {
    
    weak var delegate: XMHomeListContainerViewDelegate?

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.delegate?.scrollWillBegin()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.scrollDidEnded()
    }
  
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if(!decelerate){ //真正停止了
            self.delegate?.scrollDidEnded()
        }

    }
  
    
}
