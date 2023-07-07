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
/// 判断当前设备是否是iPAD设备
public let kIS_IPAD:Bool  = (UIDevice.current.userInterfaceIdiom == .pad )

/// 判断当前设备是否是iPhone设备
public let kIS_PHONE:Bool  = (UIDevice.current.userInterfaceIdiom == .phone )
