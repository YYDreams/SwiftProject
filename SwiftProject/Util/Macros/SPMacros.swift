//
//  NMMacros.swift
//  NMBaseUI
//
//  Created by flowerflower on 2021/8/15.
//

import Foundation
import HandyJSON


/// 字符串是否为空
public func kStringIsEmpty(string: String) -> (Bool) {
    let trimmedStr = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr.isEmpty
}
/// 数组是否为空
public func kArrayIsEmpty<T>(_ array: [T]?) -> Bool {
    // 如果数组为nil，或者数组的元素个数为0，则返回true，否则返回false
    return array == nil || array!.isEmpty
}
/// 是否是模拟器
public func  kIsSimulator() -> Bool {
    return TARGET_OS_SIMULATOR != 0
}

/// 判断当前设备是否是iPAD设备
public let kIsIpad:Bool  = (UIDevice.current.userInterfaceIdiom == .pad )

/// 判断当前设备是否是iPhone设备
public let kIsPhone:Bool  = (UIDevice.current.userInterfaceIdiom == .phone )


public enum ResourceType: Int,HandyJSONEnum {
    case all
    /// 图文
    case document             = 1
    /// 音频
    case audio                = 2
    /// 视频
    case video                = 3
    /// 直播
    case live                 = 4
    /// 会员
    case vip                  = 5
    /// 专栏
    case column               = 6
    /// 圈子
    case group                = 7
    /// 大专栏
    case bigColumn            = 8
    /// 活动
    case activity             = 9
    /// 问答
    case qna                  = 10
    /// 作业
    case homework             = 11
    /// 表单
    case form                 = 13
    ///
    case testInteractive      = 14
    ///
    case homework_new         = 15
    /// 打卡
    case card                 = 16
    /// 电子书
    case eBook                = 20
    /// 训练营
    case trainingCamp         = 25
    /// 考试
    case test                 = 27
    /// 练习
    case practice             = 34
    /// AI互动课
    case aiInteractive        = 45
    /// 班课
    case classCourse          = 35
    /// 课堂互动
    case classroomInteraction = 82
    /// 线下课
    case offline              = 29
    /// 训练营pro
    case trainingCampPro      = 50
    
    case word                 = 51
    
    case none                 = 999
    
    
    
    public var title: String {
        switch self {
        case .document:
            return "图文"
        case .video:
            return "视频"
        case .audio:
            return "音频"
        case .column:
            return "专栏"
        case .bigColumn:
            return "大专栏"
        case .vip:
            return "会员"
        case .live:
            return "直播"
        case .trainingCamp:
            return "训练营"
        case .eBook:
            return "电子书"
        case .aiInteractive:
            return "AI互动课"
        case .classCourse:
            return "班课"
        case .classroomInteraction:
            return "课堂互动"
        case .offline:
            return "线下课"
        case .all:
            return "全部"
        case .group:
            return "圈子"
        case .activity:
            return "活动"
        case .qna:
            return "问答"
        case .homework, .homework_new:
            return "作业"
        case .testInteractive:
            return "测试互动"
        case .form:
            return "表单"
        case .card:
            return "打卡"
        case .test:
            return "考试"
        case .practice:
            return "练习"
        case .trainingCampPro:
            return "课程"
        case .word:
            return "文档"
        }
    }
}
