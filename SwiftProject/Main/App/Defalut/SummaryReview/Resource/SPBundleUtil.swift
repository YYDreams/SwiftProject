//
//  XEBundleUtil.swift
//  XEBaseUI_Example
//
//  Created by EliPeng on 2019/7/10.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

@objc public class SPBundleUtil: NSObject {
    
    @objc public static func oc_getCurrentBundle() -> Bundle {
        return self.getCurrentBundle()
    }
    
    public static func getCurrentBundle(bundleClass: AnyClass = SPBundleUtil.self,
                                 bundleResourceName: String = "SPSummaryReviewUI",
                                 bundleExtensionName: String = "bundle") -> Bundle{
        
        let podBundle = Bundle(for: bundleClass)
        
        let bundleURL = podBundle.url(forResource: bundleResourceName, withExtension: bundleExtensionName)
        
        if bundleURL == nil {
            if podBundle.bundlePath.contains("SPSummaryReviewUI.framework") {   // carthage
                return podBundle
            }
        }
        
        if bundleURL != nil {
            let bundle = Bundle(url: bundleURL!)!
            return bundle
        }else{
            return Bundle.main
        }
    }
    
    /// 获取合适的 Path
    public static func fetchAppropriatePath(forResource name: String?, ofType ext: String?) -> String? {
        // 1. 主工程优先获取
        var path = Bundle.main.path(forResource: name, ofType: ext)
        if let filePath = path {
            return filePath
        } else {
            // 2. Pod Bundle 获取
            path = SPBundleUtil.getCurrentBundle().path(forResource: name, ofType: ext)
            return path
        }
    }
}
