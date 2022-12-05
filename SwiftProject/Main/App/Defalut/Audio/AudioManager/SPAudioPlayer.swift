//
//  SPAudioPlayer.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/12/5.
//

import Foundation
// 播放状态
public enum SPAudioPlayState: String {
    case none    // 未知（比如都没有开始播放音视频资源）
    case loading // 加载中
    case playing // 播放中
    case paused // 暂停
    case stopped // 停止
    case buffering //缓冲
    case seeking // 音频跳转进度中
    case retryingSucceeded // 检索URL成功
    case failed //失败(比如没有网络缓存失败, 地址找不到)
    case audioStreamBufferingEnd // 文件全部缓冲完成
    case audioStreamPlayCompleted // 自动播放完当前音频
    
}
// 选择定时播放类型
public enum SPPlayTimeType: Int {
    case notOpen = 0     // 不开启
    case playCurrent = 1     // 播放完当前
    case tenMinutes = 2      // 10分钟后
    case twentyMinutes = 3   // 20分钟后
    case thirtyMinutes = 4   // 30分钟后
    case sixtyMinutes = 5    // 60分钟后
}
// 播放顺序
public enum SPAudioPlaySortType {
    case normalSort       // 顺序播放
    case singleSort       // 单曲播放
}

class SPAudioPlayer: NSObject{
    
    public static let shared = SPAudioPlayer.init()
    
    
    
    
}
