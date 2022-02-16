//
//  AppDelegate.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/9.
//

import UIKit

//import SPBaseUI
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UITabBarController()
        self.window?.makeKeyAndVisible()
        
        // 配置UI调试神器
        initInjectionConfig()
        
        //初始化网络配置
        initNetworkConfig()
        
        return true
    }

}

