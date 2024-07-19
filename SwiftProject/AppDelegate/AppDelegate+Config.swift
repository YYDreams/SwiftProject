//
//  AppDelegate+Config.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/12/17.
//

import Foundation

extension AppDelegate{
 
    // 配置UI调试神器
    func initInjectionConfig(){
        #if DEBUG
        let a =   Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
          print("=========InjectionIII======",a)
        #endif
    }
    
    //初始化网络配置
    func initNetworkConfig(){
        var envType: EnvType = .pruduct
        var baseUrl = ""
        switch envType {
        case .develop:
            baseUrl = ""
        case .test:
            baseUrl = ""
        case .pruduct:
            baseUrl = "https://community-app.xiaoeknow.com"
        }
        NetworkPublicApi.default.envType = envType
        NetworkPublicApi.default.requestBaseUrl = baseUrl
        NetworkPublicApi.default.isDebug = true
        NetworkPublicApi.default.header["App-Token"] = "mobileecommunitycpcjfh3u7llorqj5cun0"
        NetworkPublicApi.default.header["login_app"] = "ecommunity"
        NetworkPublicApi.default.header["login_client"] = "mobile"
        NetworkPublicApi.default.header["platform"] = "ios"

        NetworkPublicApi.default.baseParams = ["app_version": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "",
                                                                 "build_version": Bundle.main.infoDictionary?["CFBundleVersion"] ?? "",
                                                                 "channel_no": Bundle.main.infoDictionary?["ChannelNo"] ?? "",
                                                                 "client_info": ["phoneBrand": UIDevice.current.systemName,
//                                                                                 "phoneModel": Device.current.safeDescription,
                                                                                 "deviceName": UIDevice.current.name,
                                                                                 "systemVersion": UIDevice.current.systemVersion,
                                                                                 "batteryLevel": String(UIDevice.current.batteryLevel),
                                                                                 "bundleIdentifier": Bundle.main.bundleIdentifier ?? ""],
                                                                 "platform": "ios",
                                                                 "uuid": UserDefaults.standard.value(forKey: "KUUID") ?? "",  //获取设备唯一标识符,
                                                                 "check_login_version": true,
                                                                 "client": "6", // app 端定义为 6
                                                                 "timestamp": Int64(Date().timeIntervalSince1970),
                                                                 "nonce": arc4random()%100,
                                                                 "agent_type" : 14,// 小鹅 APP C 端接口专用
                                                                 "terminal_type" : 4] // 终端类型 (1pc,2mac,3android,4ios)
        
        
//        NetworkPublicApi.customParams = 
        
        
    }
    func initLogConfig(){

        
    }
}
