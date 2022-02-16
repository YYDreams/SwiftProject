//
//  NMMacros.swift
//  NMBaseUI
//
//  Created by flowerflower on 2021/8/15.
//

import Foundation


/// 字符串是否为空
public func kStringIsEmpty(string: String) -> (Bool) {
    let trimmedStr = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
}
///
////数组是否为空
//public func kArrayIsEmpty()
//#define kArrayIsEmpty(array) (array == nil || (![array isKindOfClass:[NSArray class]]) || array.count == 0)
//
////字典是否为空
//#define kDictIsEmpty(dic) (dic == nil || (![dic isKindOfClass:[NSDictionary class]]) || dic.allKeys == 0)
//
////是否是空对象
//#define kObjectIsEmpty(_object) (_object == nil \
//|| [_object isKindOfClass:[NSNull class]] \
//|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
//|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//
