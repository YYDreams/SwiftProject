//
//  Foundation.swift
//  XMUtil
//
//  Created by flowerflower on 2021/10/20.
//

import Foundation

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


