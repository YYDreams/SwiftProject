//
//  Foundation.swift
//  XMUtil
//
//  Created by flowerflower on 2021/10/20.
//

import Foundation
import UIKit

public extension Collection {
    
    subscript(safe index: Index) -> Element? {
        
        return indices.contains(index) ? self[index] : nil
    }
    
}

public extension Array {
    // 数组去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}


extension String{
    
    //计算文本的size
public func caculateTextSize(text:String?,font:UIFont?,maxWidth:CGFloat = CGFloat.greatestFiniteMagnitude,maxHeight:CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize{
    
    guard (text != nil), (text!.count > 0), (font != nil) else {
        return .zero
    }
    
    return (text! as NSString).boundingRect(with: CGSize(width: maxWidth, height: maxHeight),
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font!],
                                            context: nil).size
    }
}
    

    

