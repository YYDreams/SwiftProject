//
//  SPAppCore.swift
//  SPAppCore
//
//  Created by flowerflower on 2021/12/3.
//

import Foundation

// MARK: - 持久化存储key
/// 角色
let kAppCoreAppType = "kAppCoreAppType"
let kAppCoreEnvType = "kAppCoreEnvType"
let kAppCoreBaseUrl = "kAppCoreBaseUrl"
/// 
public enum SPAppType :Int {
    case defalut //自己备用
    case xmly // 喜马拉雅
    case shop
    case learn
    case cartoon
}

/// 环境配置
public enum SPEnvironmentType:Int {
    case developEnvironment // 开发环境
    case testEnvironment // 测试环境
    case pruductEnviroment // 生产环境
}



// MARK: ------------------------- Const/Enum/Struct

public  class SPAppCore: NSObject {
    
    // MARK: ------------------------- Propertys
    
    public static let shared = SPAppCore()
    
    
    /// 
     public var appType: SPAppType? {
        get {
            if let type = UserDefaults.standard.object(forKey: kAppCoreAppType) as? Int {
                return SPAppType.init(rawValue: type)
            }else{
                return .shop
            }
        }
        set {
            UserDefaults.standard.setValue(newValue?.rawValue, forKey: kAppCoreAppType)
            UserDefaults.standard.synchronize()
        }
     }
    
    public var environmentType: SPEnvironmentType?{
        
        get {
            if let type = UserDefaults.standard.object(forKey: kAppCoreEnvType) as? Int {
                return SPEnvironmentType.init(rawValue: type)
            }else{
                return .pruductEnviroment
            }
        }
        set {
            UserDefaults.standard.setValue(newValue?.rawValue, forKey: kAppCoreEnvType)
            UserDefaults.standard.synchronize()
        }
        
    }
    public var baseUrl: String?{
        
        get {
            return UserDefaults.standard.object(forKey: kAppCoreBaseUrl) as? String
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: kAppCoreBaseUrl)
            UserDefaults.standard.synchronize()
  
        }
    }
    
    
    
    // MARK: ------------------------- CycLife
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
    public func netWorkConfig(){
        
    }
    
    /// 退出登录
    public func logout() {
        
        
    }
    
}
