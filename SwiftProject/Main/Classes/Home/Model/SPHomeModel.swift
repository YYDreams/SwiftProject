//
//  SPHomeModel.swift
//  SPHomeUI
//
//  Created by flowerflower on 2021/12/18.
//

import Foundation
import HandyJSON



enum SPModuleSignType: String,HandyJSONEnum {
    case none  //默认值
    case sliderModule //轮播广告
    case recommendGoodsModule //推荐商品
    case separatorModule //分隔
    case searchModule //搜索栏
    case imageAdsModule // 图片广告/图片导航
    case titleModule  // 标题组件
    case storeTopModule //店铺头部
    case goodsModule // 商品组件
    case hotZoneModule  //热区模组
    case liveBroadcastModule  // 直播组件
    case couponModule //优惠券组件
    case newsExpressModule // 消息快报
    case richTextModule //富文本组件
    case saveMoneyCounterModule  //省钱计算器组件
    case videoModule  //视频组件
    case buyCardModule  //购卡组件
    case imageTextNavigationModule //商品导航组件
}

class SPPageContentVOModel: SPBaseModel {
    
}
class SPPageModuleVOListModel: SPBaseModel {
    
    public  var pageModuleId: String?
    public  var pageContentId: String?
    public   var name: String?
    public  var title: String?
    public  var moduleSign: SPModuleSignType?
    
    public  var bizStyle: SPBizStyleModel?
    
    public  var moduleContent: SPModuleContentModel?
    
    public  var externJson: SPExternJsonModel?
    
    public  var anchorContent: SPAnchorContentModel?
    
    public  var renderContent: [String : Any]?
    
    public required  init() {}
}

class SPBizStyleModel: SPBaseModel {
    public required  init() {}
}

class SPModuleContentModel: SPBaseModel {

    public required  init() {}
}
class SPExternJsonModel: SPBaseModel {
    public required  init() {}
}

class SPAnchorContentModel: SPBaseModel {
    public required  init() {}
    
}

class SPRenderContentModel: SPBaseModel {
    
    public  var originalItemList: [Any]?

    
    public required  init() {}
}



class SPAbtReportMapModel: SPBaseModel {
    public required  init() {}
}
class SPStoreInfoListModel: SPBaseModel {
    public required  init() {}
}
class SPAdgroupDataListModel: SPBaseModel {
    public required  init() {}
}

 class SPHomeDataModel:SPBaseModel{
    
    public  var pageContentVO: SPPageContentVOModel?
    public  var pageModuleVOList: [SPPageModuleVOListModel]?
    public   var end: Bool?
    public  var abtReportMap: SPAbtReportMapModel?
    public  var storeInfoList: [SPStoreInfoListModel]?
    public  var storeId: String?
    public  var storeType: Int?
    public  var showWaterMark: Bool?
    public  var showShare: Bool?
    public  var showCart: Bool?
    public  var adgroupDataList: [SPAdgroupDataListModel]?
    
    public var miniProgramConfig: String?
    
    public  var miniProgramPagePath: String?
//    public  var storeGeoInfoList: ?
    public   var homePageDataSource: String?
    public  var isDefaultStore: Bool?
    public  var isMatchStoreGeo: Bool?
    public  var bpageAsync: Bool?
    public required  init() {}
    
}
 class SPHomeModel:SPBaseModel{
    
    
    public  var code: String?
    public  var msg: String?
    public   var errorMsg: String?
    public  var traceId: String?
    public  var requestId: String?
    public  var rt: Int?
    public  var success: Bool?
    public var data: SPHomeDataModel?

    public required  init() {}


    
}
