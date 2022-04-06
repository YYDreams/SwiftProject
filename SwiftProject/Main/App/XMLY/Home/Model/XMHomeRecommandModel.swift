//
//  XMHomeRecommand.swift
//
//
//  Created by JSONConverter on 2022/04/06.
//  Copyright © 2022年 JSONConverter. All rights reserved.
//

import Foundation
import HandyJSON

class XMHomeRecommandModel: HandyJSON {
    var body:[XMHomeRecommandBody]?
	var bucketId: Int = 0
	var clearModuleHis: Bool = false
	var code: String?
    var header : [XMHomeRecommandHeader]?
	var isNewUser: Bool = false
	var msg: String?
	var offset: Int = 0
	var profileId: Int = 0
	var ret: Int = 0
	var stream_option: XMHomeRecommandStream_option?
    var tabs: [XMHomeRecommandTabs]?

	required init() {}
}

class XMHomeRecommandHeader: HandyJSON {
	var item: XMHomeRecommandHeaderItem?
	var itemType: String?
	var layoutId: Int = 0
	var mtlId: Int = 0
	var mtlPosition: Int = 0
	var mtlPriority: Int = 0
	var mtlRankType: String?

	required init() {}
}

class XMHomeRecommandHeaderItem: HandyJSON {
	var lId: Int = 0
    var list: [XMHomeRecommandHeaderItemList]?
	var moduleId: Int = 0
	var moduleType: String?
	var tagSelected: Bool = false
	var title: String?

	required init() {}
}

class XMHomeRecommandHeaderItemList: HandyJSON {
    var data:[XMHomeRecommandHeaderItemListData]?
	var responseId: Int = 0
	var ret: Int = 0
    
    //square的数据
    var bubbleDisplayClass: String?
    var bucketId: Int = 0
    var contentType: String?
    var contentUpdatedAt: Int = 0
    var coverPath: String?
    var darkCoverPath: String?
    var displayClass: String?
    var enableShare: Bool = false
    var id: Int = 0
    var isExternalUrl: Bool = false
    var isHot: Bool = false
    var orderNum: Int = 0
//    var properties: RootClassProperties?
    var strategyName: String?
    var subtitle: String?
    var title: String?
    var url: String?
    
    

	required init() {}
}

class XMHomeRecommandHeaderItemListData: HandyJSON {
	var adId: Int = 0
	var adType: Int = 0
	var businessExtraInfo: XMHomeRecommandHeaderItemListDataBusinessExtraInfo?
	var buttonShowed: Bool = false
	var clickAction: Int = 0
	var clickTokenEnable: Bool = false
	var clickTokens = [String]()
	var clickType: Int = 0
	var cover: String?
	var description: String?
	var displayType: Int = 0
	var dpRealLink: String?
	var enableContinuePlay: Bool = false
	var frameIndex: Int = 0
	var isAd: Bool = false
	var isInternal: Int = 0
	var isLandScape: Bool = false
	var isShareFlag: Bool = false
	var isTrueExposure: Bool = false
	var link: String?
	var linkType: Int = 0
	var name: String?
	var openlinkType: Int = 0
	var realLink: String?
	var recSrc: String?
	var recTrack: String?
	var showTokenEnable: Bool = false
	var targetId: Int = 0
	var thirdStatUrl: String?
	var ubtTraceId: String?
	var videoCover: String?

	required init() {}
}

class XMHomeRecommandHeaderItemListDataBusinessExtraInfo: HandyJSON {

	required init() {}
}

class XMHomeRecommandTabs: HandyJSON {
	var channelId: Int = 0
	var firstShowOrNot: Bool = false
	var relativeCategory: String?
	var relativeCategoryId: Int = 0
	var streamType: String?
	var tabTitle: String?

	required init() {}
}

class XMHomeRecommandBody: HandyJSON {
	var item: XMHomeRecommandBodyItem?
	var itemType: String?
	var layoutId: Int = 0
	var mtlId: Int = 0
	var mtlPosition: Int = 0
	var mtlPriority: Int = 0
	var mtlProvider: String?
	var mtlRankType: String?
	var mtlType: String?
	var p: Int = 0
	var sourceModuleType: String?

	required init() {}
}

class XMHomeRecommandBodyItem: HandyJSON {
	var albumId: Int = 0
	var category: String?
	var categoryId: Int = 0
	var contractStatus: Int = 0
	var coverLarge: String?
	var coverMiddle: String?
	var coverPath: String?
	var coverSmall: String?
	var dislikeReasonNew: XMHomeRecommandBodyItemDislikeReasonNew?
    var dislikeReasonNewV1:[XMHomeRecommandBodyItemDislikeReasonNewV1]?
	var intro: String?
	var isPaid: Bool = false
	var isSampleAlbumTimeLimited: Bool = false
	var isVipFree: Bool = false
	var lastUptrackAt: Int = 0
	var nickname: String?
	var playsCounts: Int = 0
	var preferredType: Int = 0
	var recInfo: XMHomeRecommandBodyItemRecInfo?
	var subscribeStatus: Bool = false
	var title: String?
	var tracks: Int = 0
	var type: Int = 0

	required init() {}
}

class XMHomeRecommandBodyItemDislikeReasonNew: HandyJSON {
    var `default`: [XMHomeRecommandBodyItemDislikeReasonNewDefault]?
    var traits : [XMHomeRecommandBodyItemDislikeReasonNewTraits]?

	required init() {}
}

class XMHomeRecommandBodyItemDislikeReasonNewTraits: HandyJSON {
	var codeType: String?
	var name: String?

	required init() {}
}

class XMHomeRecommandBodyItemDislikeReasonNewDefault: HandyJSON {
	var codeType: String?
	var name: String?

	required init() {}
}

class XMHomeRecommandBodyItemRecInfo: HandyJSON {
	var recSrc: String?
	var recTrack: String?

	required init() {}
}

class XMHomeRecommandBodyItemDislikeReasonNewV1: HandyJSON {
	var negative: XMHomeRecommandBodyItemDislikeReasonNewV1Negative?
	var reasonRowType: Int = 0

	required init() {}
}

class XMHomeRecommandBodyItemDislikeReasonNewV1Negative: HandyJSON {
	var key: XMHomeRecommandBodyItemDislikeReasonNewV1NegativeKey?
	var setKey: Bool = false
	var setSubReasons: Bool = false
	var subReasonsOpt: XMHomeRecommandBodyItemDislikeReasonNewV1NegativeSubReasonsOpt?

	required init() {}
}

class XMHomeRecommandBodyItemDislikeReasonNewV1NegativeSubReasonsOpt: HandyJSON {
	var defined: Bool = false

	required init() {}
}

class XMHomeRecommandBodyItemDislikeReasonNewV1NegativeKey: HandyJSON {
	var codeType: String?
	var name: String?
	var setCodeType: Bool = false
	var setName: Bool = false

	required init() {}
}

class XMHomeRecommandStream_option: HandyJSON {
	var guessTip: String?
	var guessTipIting: String?
	var guessUbtTraceId: String?
	var showGuessCycle: Bool = false
	var title: String?
	var ubtTraceId: String?

	required init() {}
}
