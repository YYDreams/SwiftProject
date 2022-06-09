//
//  AppDelegate+Config.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/12/17.
//

import Foundation
//
//

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
        
        print("SPAppCore.shared.appType:",SPAppCore.shared.appType,SPAppCore.shared.environmentType)

        if SPAppCore.shared.appType == .none {
            SPAppCore.shared.appType  = .defalut
            SPAppCore.shared.environmentType = .pruductEnviroment
            SPAppCore.shared.baseUrl = NetworkHelp.shared.baseUrl()
        }
    }
}
