//
//  SPCourseDetailApiRequest.swift
//  SwiftProject
//
//  Created by flower on 2024/7/19.
//

import Foundation
import PromiseKit
import HandyJSON
class SPCourseDetailApiRequest: NSObject{
    
    ///获取课程详情
    class func networkGetCourseDetail(appId: String,
                                      resourceType: Int,
                                      userId: String,
                                      resourceId: String,
                                      contentAppId: String = "") -> Promise<EXResourceDetailModel?>   {
        
        return NetworkPublicApi.default.sendRequestAndDataDecode(apiMethod: "/app/goods/xe.goods.detail.get/1.0.3",
                                                               parameters: ["app_id": appId,
                                                                            "content_app_id": contentAppId,
                                                                            "c_user_id": userId,
                                                                            "data": ["agent_type" : 14,
                                                                                     "goods_type" : resourceType,
                                                                                     "goods_id":resourceId,
                                                                                     "hide_view_count":0,
                                                                                     "is_show_resourcecount":1] as [String : Any]])
    }
    
    ///获取课件list
    class func networkGetCoursewareList(appId: String,
                                        resourceType: Int,
                                        resourceId: String,
                                        contentAppId: String = "") -> Promise<[CoursewareResponse]?> {
        return NetworkPublicApi.default.sendRequestAndDataDecode(apiMethod: "/app/goods/xe.detail.courseware.get/1.0.1",
                                                                parameters: ["app_id": appId,
                                                                             "resource_id": resourceId,
                                                                             "resource_type": resourceType,
                                                                             "content_app_id": contentAppId])
    }
    
    class func networkGetCourseInteraction(appId: String,
                                           userId:String,
                                           resourceType: Int,
                                           resourceId: String) -> Promise<CourseInteractionsResponse?> {
        return NetworkPublicApi.default.sendRequestAndDataDecode(apiMethod: "/app/course_interaction/1.0.0",
                                                                parameters: ["app_id": appId,
                                                                             "user_id": userId,
                                                                             "data": ["resource_id":resourceId,"resource_type":resourceType]])
    }
    
    
    /// 获取评论信息
    class func networkQuerycomments(appId: String,
                                    resourceType: Int,
                                    resourceId: String,
                                    userId: String,
                                    rootId:String,
                                    lastId:String,
                                    sort:String,
                                    page:Int,
                                    pageSize:Int) -> Promise<GoodsCommentsGetResponseModel?> {
        return NetworkPublicApi.default.sendRequestAndDataDecode(apiMethod: "/xe.app.xe.comment.resource.list/1.0.0", parameters: ["resource_id":resourceId,
                                                                                                                                   "app_id":appId,
                                                                                                                                   "user_id":userId,
                                                                                                                                   "root_id":rootId,
                                                                                                                                   "sort":sort,
                                                                                                                                    "last_id":lastId,
                                                                                                                                    "page":page,
                                                                                                                                   "page_size":pageSize])
    }
    
}
