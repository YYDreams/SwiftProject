//
//  SPUserDefaluts.swift
//  SwiftProject
//
//  Created by flower on 2023/3/23.
//

import Foundation


public class SPUserDefaluts {
    
    public static func setObjects(key: String,value: [Any]){

        // 将数组转换成 Data 类型
        if #available(iOS 11.0, *) {
        
            let data = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)

            // 保存数组到 UserDefaults 中
            UserDefaults.standard.set(data, forKey: key)
        } else {
            // Fallback on earlier versions
        }


    }
    public static func getObjects(key: String) -> [Any]? {
        // 从 UserDefaults 中读取数据
        guard let data = UserDefaults.standard.data(forKey: key) else  {
            return nil
        }
        // 将 Data 转换成数组String类型
        if let array = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String] {
           return array
        }
        // 将 Data 转换成数组Int类型
        if let array = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Int] {
           return array
        }
        
        return nil
    }


    
    /// 设置缓存
    ///
    /// - Parameters:
    ///   - key: 键
    ///   - value: 值
    public static func set(key: String, value: Any?) {
        if value != nil {
            
            UserDefaults.standard.set(value, forKey: key)
        } else {
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.synchronize()
    }
    
    /// 获取缓存
    ///
    /// - Parameter key: 键
    /// - Returns: 缓存对象
    public static func get(key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    /// 删除缓存
    ///
    /// - Parameter key: 键
    public static func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}


