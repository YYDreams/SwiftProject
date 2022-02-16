//
//  NetworkHelp.swift
//  SPNetwork
//
//  Created by flowerflower on 2021/12/3.
//

import UIKit


public class NetworkHelp {
    
    
    open class var shared: NetworkHelp{
        get {
            let instance = NetworkHelp()
            //            instance.onceConfig()
            return instance
        }
        
    }
    
    // MARK: ------------------------- Methods
    
    /// 网络请求基础url
    public func baseURL() -> URL{
        
        return URL(string: baseUrl())!
    }
    public func baseUrl() -> String{
        var baseUrl = ""
        switch SPAppCore.shared.appType {
        case .shop:
            baseUrl = "https://api-sams.walmartmobile.cn"
//            if SPAppCore.shared.environmentType == .testEnvironment {
//                baseUrl = "https://api-qa-sams.walmartmobile.cn"
//            }else{
//                baseUrl = "https://api-sams.walmartmobile.cn"
//            }
        case .learn:
            baseUrl = "https://xiaoeapp-server.xiaoeknow.com"
        case .cartoon:
            baseUrl = ""
        default:
            baseUrl = "https://api-sams.walmartmobile.cn"
        }
        SPAppCore.shared.baseUrl  = baseUrl
        return baseUrl
    }
    
    
    
    public func formatNetworkParams(_ originParams: [String: Any]?) -> [String: Any] {
        
        switch SPAppCore.shared.appType {
        case .shop:
            let languageStr = "CN"; //EN
            let authToken = ""
            let localLatitude = ""
            let localLongitude = ""
            let defaultParams: [String : Any] = ["apptype": "ios",
                                                 "device-type": "ios",
                                                 "tpg":"1",
                                                 "system-language": languageStr,
                                                 "auth-token": authToken,
                                                 "tversion":Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "",
                                                 "app-version": Bundle.main.infoDictionary?["CFBundleVersion"] ?? "",
                                                 "device-id":UIDevice.current.identifierForVendor?.uuidString ?? "",  //获取设备唯一标识符,
                                                 "device-os-version":UIDevice.current.systemVersion,
                                                 "device-name":UIDevice.current.name,
                                                 "latitude":localLatitude,
                                                 "longitude":localLongitude]
            return defaultParams
            
        case .learn:
            let clientInfoDic = ["phoneBrand": UIDevice.current.systemName,
                                 "phoneModel": UIDevice.current.model,
                                 "deviceName": UIDevice.current.name,
                                 "systemVersion": UIDevice.current.systemVersion,
                                 "batteryLevel": String(UIDevice.current.batteryLevel)]
            let defaultParams: [String : Any] = ["app_version": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "",
                                                 "build_version": Bundle.main.infoDictionary?["CFBundleVersion"] ?? "",
                                                 "channel_no": Bundle.main.infoDictionary?["ChannelNo"] ?? "",
                                                 "client_info": clientInfoDic,
                                                 "platform": "ios",
                                                 "uuid": UIDevice.current.identifierForVendor?.uuidString ?? "",  //获取设备唯一标识符,
                                                 "client": "6", // app 端定义为 6
                                                 "timestamp": Int64(Date().timeIntervalSince1970),
                                                 "nonce": arc4random()%100,
            ]
            
            var params: [String: Any] = originParams != nil ? originParams! : [:]
            params.merge(defaultParams) { (param, defaultParam) -> Any in
                return param
            }
            
            //            if let apiToken = XAAppCore.shared.token {
            //                params["api_token"] = apiToken
            //                params["token"] = apiToken
            //            }
            //
            //            if let app_user_id = XAAppCore.shared.userId {
            //                params["app_user_id"] = app_user_id
            //            }
            //
            //            // app_id
            //            if (params["app_id"] == nil) {
            //                if let shop_id = XMAppCore.shared.shop_id {
            //                    params["app_id"] = shop_id
            //                }
            //            }
            
            /// 内灰外灰准现网环境，如果没有 app_id 则写死固定 app_id
            //        switch XAAppCore.shared.environmentType {
            //        case .innerProductEnviroment, .externalProductEnviroment, .prepruductEnviroment:
            //            if let appId = self.appId(),
            //               params["app_id"] == nil,
            //               isNeedAppId == true {
            //                params["app_id"] = appId
            //            }
            //        default: break
            //        }
            
            return params
            
//        case .cartoon
//           return [:]
        
        default:
            return [:]
        }
        
        
        
    }
}
