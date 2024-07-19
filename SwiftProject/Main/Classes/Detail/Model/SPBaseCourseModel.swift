//
//  SPBaseCourseModel.swift
//  SwiftProject
//
//  Created by flower on 2024/7/19.
//

import Foundation
import HandyJSON
public class SPBaseCourseModel: SPBaseModel{}

/// 获取资源详情数据模型
public class EXResourceDetailModel: SPBaseCourseModel {
    
    /// 是否购买
    public var available: Bool?
    /// 素材id
    public var material_id: String?
    /// 资源信息
    public var resource_info: EXResourceInfo?
    /// 专栏信息
    public var product_info: EXProductInfo?
    
    public required init() {}
    
    
    /// 专栏信息
    public class EXProductInfo: SPBaseCourseModel {
        /// 专栏数组
        public var product_list: [Product]?
        
        public required init() {}
        
        public class Product: SPBaseCourseModel{
            /// 应用 id
            public var app_id: String?
            /// id
            public var id: String?
            /// 图片链接
            public var img_url: String?
            /// 产品类型
            public var product_type: String?
            /// 购买数量
            public var purchase_count: String?
            /// 资源数
            public var resource_count: Int?
            /// 查看人数
            public var view_count: Int?
            /// 标题
            public var title: String?
            /// 更新数字
            public var update_num: String?
            /// 链接
            public var url: String?
            /// 简介
            public var summary: String?
            /// 资源类型
            public var resource_type: Int?
            /// 资源价格
            public var price: Int?

            public required init() {}
            
        }
    }
    
    /// 资源信息
    public class EXResourceInfo: SPBaseCourseModel {
        
        public required init() {}

        /// 内容
        public var content: String?
        
        public var org_content: String?
        /// 店铺id
        public var shop_id:String?
        /// 是否购买
        public var has_buy: Int?
        /// 是否 stock
        public var has_stock: Bool?
        /// 过期时间
        public var expire_time: String?
        /// H5链接
        public var h5_url: String?
        /// 过期时间
        public var member_expire_time: String?
        /// 过期更新
        public var expire_renew: String?
        /// 查看次数
        public var view_count: Int?
        /// 评论次数
        public var comment_count: Int?
        /// 期数
        public var periodical_count: Int?
        /// 压缩图片链接
        public var img_url_compressed: String?
        /// 图片链接
        public var img_url: String?
        /// 是否可以购买
        public var is_can_buy: Int?
        /// 是否停止销售
        public var is_stop_sell: Int?
        /// 是否试听
        public var is_try: Int?
        /// 是否免费
        public var is_free: Int?
        /// 是否相关
        public var is_related: Int?
        /// 状态
        public var state: Int?
        /// 价格
        public var line_price: Int?
        /// 原价格
        public var init_price: Int?
        /// 是否需要用户信息
        public var need_user_info: Int?
        /// 支付类型
        public var payment_type: Int?
        /// 价格
        public var price: Int?
        /// 专栏 id
        public var product_id: String?
        /// 购买书
        public var purchase_count: Int?
        /// 销售状态
        public var sale_status: Int?
        /// 单位
        public var member_unit: String?
        /// 开始于
        public var start_at: String?
        /// 资源 id
        public var resource_id: String?
        /// 资源类型
        public var resource_type: Int?
        /// stock
        public var stock: String?
        /// 简介
        public var summary: String?
        /// 剩余时间
        public var time_left: Int?
        /// 标题
        public var title: String?
        /// 预览内容
        public var preview_content: String?
        
        /// 视频链接 ------ 视频相关属性 ------
        public var video_url: String?
        public var video_mp4: String?
        public var video_mp4_high: String?
        public var video_mp4_size: Float?
        public var video_mp4_high_size: Float?
        public var video_url_size: Double?
        public var video_url_size_1080: Double?
        public var video_length: Int?
        public var video_url_1080: String?
        
        /// 音频链接
        public var audio_url: String?
        /// m3u8
        public var m3u8_url: String?
        /// m3u8
        public var audio_m3u8_url: String?
        /// 预览音频链接
        public var preview_audio_url: String?
        /// 预览音频链接 m3u8
        public var preview_audio_m3u8_url: String?
        /// 音频试听长度
        public var try_audio_length: Int?
        /// 音频播放时间
        public var audio_play_time: Int?
        /// 音频播放时间
        public var audio_length: Int?
        
        /// 音频播放次数
        public var audio_play_count: Int?
        /// 是否收藏
        public var has_favorite: Int?
        /// 视频封面图
        public var video_slice_img: String?
        /// 收藏数
        public var favorite_count: Int?
        /// 视频压缩封面图
        public var video_slice_img_compress: String?
        /// 超级会员价格
        public var use_svip_price: Bool?
        /// 是否展示蒙层
        public var visible_on: Int?
        public var can_select: Int?
        
        //音频大小
        public var audio_size: Double?
        
        //大专栏/专栏/会员 最后更新日期
        public var updated_at: String?
        
        /// 压缩音频链接
        public var audio_compress_url: String?
        
        /// 是否展示下载按钮  0 关闭 1 开启
        public var is_show_download_btn: Int?
        
        ///是否允许拖拽和倍速播放 0 不允许 1 允许
        public var is_draggable_and_various_speed: Int?
        
        /// 当前资源最大学习进度 0-100
        public var max_learn_progress: Int?
        
        /// 720P私有加密信息
        public var private_info: EXVideoPrivateInfo?
        /// 1080P私有加密信息
        public var private_info_1080: EXVideoPrivateInfo?
        ///加载n分钟内
        public var loading_check_period: String?
        ///加载时长
        public var loading_check_hold_time: String?
        ///加载出现的次数
        public var loading_check_hold_count: String?
        
        /// detail接口中的详情字段
        public class EXVideoPrivateInfo: SPBaseCourseModel{
            public  required init() {}
            public var ext: EXVideoPrivateInfoExt?
            public var is_support: Int?
            public var private_m3u8: String?
        }

        /// detail接口中的私有加密信息
        public class EXVideoPrivateInfoExt: SPBaseCourseModel {
            public  required init() {}
            public var host: String?
            public var param: String?
            public var path: String?
        }

    }
}






public enum CoursewareType:Int, HandyJSONEnum {
    case CoursewareImage = 1
    case CoursewareMusic = 2
    case CoursewareVideo = 3
    case CoursewarePowerPoint = 7
    case CoursewareWord = 6
    case CoursewareExcel = 8
    case CoursewarePDF = 9
    case CoursewarePacakge = 10
    case CoursewareTXT = 11
    case CoursewareDir
    case CoursewareForm
    case CoursewareUnknow
    
    func getIcon() -> String {
        switch self {
        case .CoursewarePowerPoint:
            return "doc_icon_ppt"
        case .CoursewareWord:
            return "doc_icon_word"
        case .CoursewareExcel:
            return "doc_icon_excel"
        case .CoursewareMusic:
            return "doc_icon_music"
        case .CoursewareVideo:
            return "doc_icon_video"
        case .CoursewareImage:
            return "doc_icon_image"
        case .CoursewareDir:
            return "doc_icon_dir"
        case .CoursewareTXT:
            return "doc_icon_txt"
        case .CoursewarePacakge:
            return "doc_icon_pack"
        case .CoursewarePDF:
            return "doc_icon_pdf"
        case .CoursewareForm:
            return "doc_icon_form"
        case .CoursewareUnknow:
            return "doc_icon_unknow"
        }
    }
    
}





/*************************************************************************************/


public class CourseInteractionBase: HandyJSON {
   public var detail_url: String?
   public var count: Int = 0
   public var type: String?
   public var url: String?
   public required init() {}
}

public class Activity: CourseInteractionBase {}

public class Community: CourseInteractionBase {}

public class Card: CourseInteractionBase {}

public class Exam: CourseInteractionBase {}

public class Form: CourseInteractionBase {}

public class Practice: CourseInteractionBase {}

public class Exercise: CourseInteractionBase {
    public var z_move_mysql_read: Int = 0
}

public class  CourseInteractionsResponse : NSObject, HandyJSON {
    
    /// 活动
    public var activity_url: Activity?
    
    /// 社群
    public var community_url: Community?
    
    /// 作业
    public var exercise_url: Exercise?
    
    /// 打卡
    public var card_url: Card?
    
    /// 考试
    public var exam_url: Exam?
    
    /// 表单
    public var form_url: Form?
    
    /// 练习
    public var practice_url: Practice?
    
    public override required init() {}
   
    func getInteractionArr() -> [CourseInteractionBase]? {
        
        var arr = [CourseInteractionBase]()
        
        if let cardUrl = card_url, cardUrl.count != 0 {
            arr.append(cardUrl)
        }
        
        if let examUrl = exam_url, examUrl.count != 0{
            arr.append(examUrl)
        }
        
        if let practiceUrl = practice_url, practiceUrl.count != 0 {
            arr.append(practiceUrl)
        }
        
        if let exerciseUrl = exercise_url, exerciseUrl.count != 0 {
            arr.append(exerciseUrl)
        }
        
        if let formUrl = form_url, formUrl.count != 0 {
            arr.append(formUrl)
        }
        
        if let activityUrl = activity_url, activityUrl.count != 0 {
            arr.append(activityUrl)
        }
        
        if let communityUrl = community_url, communityUrl.count != 0 {
            arr.append(communityUrl)
        }

        return arr
    }
}

extension CourseInteractionsResponse {
    /// 是否包含互动数据
    public var isContainInteract: Bool {
        var interaction = false
        if (self.card_url?.count ?? 0 > 0) ||
            (self.exam_url?.count ?? 0 > 0) ||
            (self.practice_url?.count ?? 0 > 0)  ||
            (self.exercise_url?.count ?? 0 > 0)  ||
            (self.form_url?.count ?? 0 > 0)  ||
            (self.activity_url?.count ?? 0 > 0)  ||
            (self.community_url?.count ?? 0 > 0) {
            interaction = true
        }
        return interaction
    }
}

/*************************************************************************************/
public enum CoursewareOperateType:Int, HandyJSONEnum {
    case previewAndDownload = 1
    case previewOnly = 2
    case downloadOnly = 3
    
    func getSheetData(size: Float) -> [String] {
        
        var sizeStr = ""
        if size > 1024.0 {
            sizeStr = "\(size/1024)MB"
        } else {
            sizeStr = "\(size)KB"
        }
        switch self {
        case .previewAndDownload:
            return ["预览", "下载 (\(sizeStr))", "复制下载链接"]
        case .downloadOnly:
            return ["预览(灰)", "下载 (\(sizeStr))", "复制下载链接"]
        case .previewOnly:
            return ["预览"]
        }
    }
}

public class CoursewareResponse: NSObject, HandyJSON {
    
    public var type: CoursewareType?
    public var operate_type: CoursewareOperateType?
    public var material_size: Float?
    public var url: String?
    public var title: String?
    public var preview_url: String?

    
    public override required init() {}
}







/*************************************************************************************/

///  查课评论
public class QueryCommentsRequestModel :HandyJSON {
    public var app_id: String = ""
    ///  user_id
    public var user_id: String = ""
    ///  资源id
    public var resourse_id: String = ""
    /// 评论跟ID
    public var root_id: Int = 0
    /// 上一次分页最后ID
    public var last_id:Int?
    ///排序方式，0 时间倒序，1 点赞倒序
    public var sort:Int = 0
    ///  页码，默认 1
    public var page: Int?
    ///  页大小，默认 10
    public var page_size: Int = 10
    
    public required init() {}
}
///  发表评论
public class InsertCommentRequestModel :HandyJSON {
    
    public var app_id: String = ""
    ///  user_id
    public var user_id: String = ""
    
    ///  类型，0-图文，1-音频，2-视频，3-圈子，20-电子书
    public var resource_type: Int = 0
    ///  对应内容记录的id（资源id）
    public var resource_id: String = ""
    ///  标题
    public var resource_title: String = ""
    
    /// 内容
    public var content: String = ""
    
    ///  被评论id
    public var src_comment_id: Int = 0
    ///   被评论用户ID
    public var src_comment_user_id: String?
    ///  被评论内容
    public var scr_comment_content: String?
    
    ///来源 固定传 1
    public var wx_app_type:Int = 1
    
    public  required init() {}
}
///  点赞/取消赞
public class LikeCommentRequestModel :HandyJSON {
    ///  对应内容记录的id
    public var resource_id: String = ""
    ///  被赞评论id
    public var comment_id: Int = 0
    ///  点赞状态
    public var status: Int = 0
    ///  店铺id
    public var app_id: String = ""
    ///  user_id
    public var user_id: String = ""
    
    public  required init() {}
}
///  删除评论
public class DeleteCommentRequestModel :HandyJSON {
    ///   对应内容记录的id
    public var resource_id: String = ""
    /// 评论ID
    public var comment_id: Int = 0
    ///  店铺id
    public var app_id: String = ""
    ///  用户id
    public var user_id: String = ""
    
    
    public  required init() {}
}
///  发表回复
public class InsertReplyRequestModel :HandyJSON {
    ///  类型，0-图文，1-音频，2-视频，3-圈子，20-电子书
    public var record_type: String?
    ///  对应内容记录的id（资源id）
    public var record_id: String = ""
    ///  富文本
    public var record_title: String?
    ///  被评论id
    public var src_comment_id: Int = 0
    ///  未知
    public var src_only_user_id: String?
    ///  被评论user_id
    public var src_user_id: String?
    ///  被评论内容
    public var src_content: String?
    ///  评论内容
    public var content: String = ""
    ///  被评论昵称
    public var src_nickname: String?
    ///  店铺id
    public var app_id: String = ""
    ///  user_id
    public var user_id: String?
    
    
    public  required init() {}
}

public class GoodsCommentsGetResponseModel: HandyJSON {
    public var list:[CommentModel] = []
    public var current_page = 0
    public var last_page = 0
    public var total = 0
    
    public  required init() {}
}

public class GoodsReplysResponseModel: HandyJSON {
    public var list:[CommentReplyModel] = []
    public var total = 0
    public  required init() {}
}


//public class CommentListModel:HandyJSON {
//    public var list:[CommentModel] = []
//    public  required init() {}
//}


public class CommentModel:HandyJSON {
    public var id = 0
    public var root_id = 0
    public var parent_id = 0
    public var user_id = ""
    public var wx_avatar = ""
    public var nickname = ""
    public var content = ""
    /// 被回复用户ID
    public var src_user_id = ""
    /// 被回复用户昵称
    public var src_nickname = ""
    /// 是否为管理员
    public var is_admin = 0
    /// 点赞数量
    public var zan_num = 0
    /// 是否为精选
    public var is_top = 0
    /// 是否点赞
    public var is_like = 0
    /// 发布格式化时间
    public var publish_time = ""
    // 回复数
    public var children_num = 0
    
    /// 回复数据
    public var children:[CommentReplyModel] = []
    
    public  required init() {}
    
   
    
}

public class CommentReplyModel:HandyJSON {
    
    public var id = 0
    public var root_id = 0
    public var parent_id = 0
    public var user_id = ""
    public var wx_avatar = ""
    public var nickname = ""
    public var content = ""
    /// 被回复用户ID
    public var src_user_id = ""
    /// 被回复用户昵称
    public var src_nickname = ""
    /// 是否为管理员
    public var is_admin = 0
    /// 点赞数量
    public var zan_num = 0
    /// 是否为精选
    public var is_top = 0
    /// 是否点赞
    public var is_like = 0
    /// 发布格式化时间
    public var publish_time = ""
    // 回复数
    public var children_num = 0
    
    /// 回复数据
    public var children:[CommentReplyModel] = []
    
    /*
    ///缓存记录
   private var cachCalculatedString:String = ""
    private var caceHeight:CGFloat = 0
    
    var cellHeight:CGFloat {
        get {
            return (calculateContentHeight() + 10 + 16 + 4 + 4 + 12 + 8)
        }
    }
    
    var contentHeight:CGFloat {
        get {
            return calculateContentHeight()
        }
    }
    
    func calculateContentHeight() -> CGFloat{
        if self.content == cachCalculatedString {
            return caceHeight
        }else {
            let height = content.calculateTextHeight(fontSize: 14, limitWidth: (kEXScreenWidth - 96))
//            content.calculateTextHeight(fontSize: 14, limitWidth: kEXScreenWidth - 96)
            //文字高度加上其余视图的高度和间距
            caceHeight = height
            cachCalculatedString = self.content
            return caceHeight
        }
    }
    
    func calculateTextHeight(text: String, maxWidth: CGFloat, font: UIFont) -> CGFloat {
        
        let texview = UITextView.init(frame: CGRectMake(0, 0, maxWidth,CGFLOAT_MAX))
        texview.text = text
        texview.font = font
        let size = CGSizeMake(maxWidth, CGFLOAT_MAX)
        let constaint = texview.sizeThatFits(size)
        return constaint.height
    }
     */
    
    public  required init() {}
}

public class NewCommentsOrReplyResponseModel :HandyJSON {
    public var comment_id: String = ""
    public var comment_times_add: String = ""
    public var wx_avatar: String = ""
    public var wx_nickname: String = ""
    
    
    public  required init() {}
}
