//
//  SPDate202206ViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/6/17.
//

import Foundation
import UIKit
import WebKit

// MARK: ------------------------- Const/Enum/Struct

extension SPDate202206ViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Propertys {}
    
    /// 外部参数
    struct Params {

    }
    
}

class SPDate202206ViewController: BaseUIViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    var webView: WKWebView!
    // MARK: ------------------------- CycLife
 
    public func loadUrl(url:String){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor
        setupSubViews()
        
    }
    func setupSubViews(){
            let webConfig = WKWebViewConfiguration()
            webView = WKWebView(frame: CGRect.zero, configuration: webConfig)
            webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
            webView.uiDelegate = self
            webView.navigationDelegate = self
//            webView.cookieDelegate  = self

            webView.evaluateJavaScript("navigator.userAgent") { result, error in
                if let result = (result as? String) {
                    var userAgent = result
                    let currentUA = ";XiaoEApp"
                    if !userAgent.contains(currentUA) {
                        userAgent = userAgent + currentUA
                        let dictionary = ["UserAgent": userAgent]
                        UserDefaults.standard.register(defaults: dictionary)
                        UserDefaults.standard.synchronize()
                    }
                    
                    // 关键代码, 必须实现这个方法, 否则第一次打开UA还是原始值, 待第二次打开webview才是正确的UA;
//                    webView.customUserAgent = userAgent
                }
            }
    }
   
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    func clearWebCache() {
        // MARK: - 清空缓存
        let dateFrom: NSDate = NSDate.init(timeIntervalSince1970: 0)
        if #available(iOS 9.0, *) {
            let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
            WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes , modifiedSince: dateFrom as Date) {
                print("清空缓存完成")
            }
        } else {
            let libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let cookiesFolderPath = libraryPath.appending("/Cookies")
            try? FileManager.default.removeItem(atPath: cookiesFolderPath)
        }
    }

    
    
}
extension SPDate202206ViewController: WKUIDelegate, WKNavigationDelegate {
    
}
