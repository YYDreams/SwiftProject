//
//  NetworkHelp.swift
//  SPNetwork
//
//  Created by flowerflower on 2021/12/3.
//

import UIKit

public extension NetworkPublicApi{
    // 当前环境
    open var envType: EnvType{
        get{
            guard let env =  (UserDefaults.standard.string(forKey: "kEnvType") as? String) else { return .pruduct }
            return EnvType(rawValue:env) ?? .pruduct
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "kEnvType")
        }
    }
    
    //灰度appId
    var grayscaleAppId: String?{
        
        get{
            UserDefaults.standard.string(forKey: "kSpecialAppID")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "kSpecialAppID")
        }
    }
    
    /// 是否开启切换环境功能
    var isDebug: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "kIsSwitchEnv")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "kIsSwitchEnv")
        }
    }
}
