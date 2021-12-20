//
//  AppDelegate.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/9.
//

import UIKit
import SPAppCore
import SPNetwork
import SPBaseUI
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = BaseTabBarViewController()
        self.window?.makeKeyAndVisible()
        initNetworkConfig()
 
        return true
    }

    func initNetworkConfig(){
        print("SPAppCore.shared.appType:",SPAppCore.shared.appType,SPAppCore.shared.environmentType)
        if SPAppCore.shared.appType == .none {
            SPAppCore.shared.appType  = .shop
            SPAppCore.shared.environmentType = .pruductEnviroment
            SPAppCore.shared.baseUrl = NetworkHelp.shared.baseUrl()
        } 
    }
}

