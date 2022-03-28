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
        case .xmly:
            baseUrl = "https://mobile.ximalaya.com"
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
        case .xmly:
            let defaultParams: [String : Any] = ["gender": "9",
                                                 "idfaLimit": "0",
                                                 "version":Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "",
                                                 "app-version": Bundle.main.infoDictionary?["CFBundleVersion"] ?? "",
                                                 "deviceId":UIDevice.current.identifierForVendor?.uuidString ?? "",  //获取设备唯一标识符,
                                                 "device-os-version":UIDevice.current.systemVersion,                                                 "device-name":UIDevice.current.name,
                                                 "xt":Int64(Date().timeIntervalSince1970)]
            return defaultParams
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
    
            return params

        
        default:
            return [:]
        }
        
        
        
    }
}
