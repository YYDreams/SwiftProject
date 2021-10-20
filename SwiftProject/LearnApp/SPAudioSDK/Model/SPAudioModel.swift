//
//  SPAudioModel.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/10.
//

import Foundation

// 音频模型
public class SPAudioModel {
    
    // 是否是会员单品
    public var isMemberSingle: Bool = false
    
    //MARK: - 接口返回字段
    public var resource_id: String = ""
    
    // 音频所属店铺id
    public var app_id: String = ""
    
    // 音频所属分销id
    public var content_app_id: String = ""
    
    // 信息流id
    public var flowId: String = ""
    // 音频链接(有可能会被替换成本地资源地址)
    public var audio_url: String = ""
    public var http_audio_url: String = ""
    // 原链接
    public var origin_audio_url = ""
    // 部分试听链接
    public var preview_audio_url: String = ""
    // 完全试听
    public var canCompleteTry: Bool = false
    // 音频标题
    public var title: String = ""
    // 封面图
    public var img_url: String = ""
    // 封面压缩图
    public var img_url_compress: String = ""
    //    var isPlaying: Bool = false
    public var progress: Float = 0.0
    // 记录学习记录
    public var learn_progress: Int = 0
    // 播放次数
    public var playCount: Int = 0
    // 音频是否已购
    public var hasBuy: Bool = false
    // 音频是否被收藏
    public var has_favorite = false
    // 购买前是否能够看全部详情
    public var can_preview_all = false
    // 详情内容
    public var webViewConttent: String = ""
    // 介绍信息
    public var preview_content: String = ""
    // 价格
    public var price: Float = 0
    // 音频长度(s)
    public var audio_length = 0
    // 是否是试听资源
    public var is_try: Bool = false
    
    //MARK: - 自定义属性
    // 音频归属位置的类型
//    public var type: AudioPositionType = .single
//    public var from: AudioVCFrom = .single
   
    // type == .littleColumn, .greatColumn, momber的时候，音频所属的专栏、大专栏、会员 id
    public var columnId: String = ""
    // type == .littleColumn, .greatColumn, momber的时候，专栏名
    public var columnName: String = ""
    public var columnIcon: String = ""
    // 大专栏id，非大专栏为“”
    public var bigColumnId: String = ""
    // 大专栏名
    public var bigColumnName: String = ""
    public var bigColumnIcon: String = ""
    // 会员id
    public var memberId: String = ""
    // 会员名
    public var memberName = ""
    public var memberIcon: String = ""
    // 是否已经下载******之前mp3下载逻辑（不加密的），非音视频缓存加密项目的缓存，目前已经废弃
    public var downloaded = false
    // 0 未下载，1 下载中，2 已下载
    public var download_state = 0
    // 当前model是否是已下载列表里面的
    public var isFromDownloadedList = false
    // 是否是播放的小巴FM资源
    public var isBelongToFm: Bool = false
    // 标记当前播放的音频是不是离线缓存播放列表
    public var isPlayingDownloadedList = false
    /// 是否是最后一个模型
    public var isLastOne = false
    
    public init() {
        
    }
}
