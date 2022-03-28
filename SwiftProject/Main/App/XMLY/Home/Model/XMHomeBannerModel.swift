//
//  XMHomeBannerModel.swift
//  SwiftProject
//
//  Created by flower on 2022/3/28.
//

import HandyJSON
import UIKit


class XMHomeTabModel:HandyJSON{
    var msg: String?
    
    var ret: Int?
    
    var focusImages: XMHomeFocusImagesModel?
    
    required init(){}

    
}
class XMHomeFocusImagesModel:HandyJSON{
    
    var data: [XMHomeBannerModel]?


    required init(){}

    
    
}

    

class XMHomeBannerModel:HandyJSON{
    //"adId": 235133,
    var adId: String?
    //"adType": 0,
    var adType: Int?
    
    //"buttonShowed": false,
    var buttonShowed: Bool?
    //"clickAction": -1,
    var clickAction: Int?
    //"clickType": 1,
    var clickType: Int?

    //"cover": "http://fdfs.xmcdn.com/group57/M00/2C/C4/wKgLgVychFyTYN0iAAJL3IH3r0Y903.jpg",
    var cover: String?
    //"description": "",
    var description: String?
    //"displayType": 1,
    var displayType: Int?
    //"isAd": false,
    var isAd: Bool?
    //"isInternal": 0,
    var isInternal: Int?
    //"isLandScape": false,
    var isLandScape: Bool?
    //"isShareFlag": false,
    var isShareFlag: Bool?
    //"link": "http://ad.ximalaya.com/adrecord?sdn=H4sIAAAAAAAAAKtWykhNTEktUrLKK83J0VFKzs_PzkyF8QoSixJzU0tSi4qVrKqVElM8S1JzPVOUrJSMjE0NjY2VamsBCAvHJEAAAAA&ad=235133&bucketIds=0&xmly=uiwebview&rec_src=146V11&rec_track=r.20000&rec_src=146V11&rec_track=r.20000",
//    var description: String?

    //"name": "",
    var name: String?

    var headerBgColor: UIColor?

    required init(){}
    
}
