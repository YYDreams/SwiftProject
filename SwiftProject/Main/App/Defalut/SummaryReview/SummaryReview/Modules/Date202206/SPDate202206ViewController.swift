//
//  SPDate202206ViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/6/17.
//

import Foundation
import UIKit
import WebKit
import GGWkCookie

// MARK: ------------------------- Const/Enum/Struct

extension SPDate202206ViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Propertys {}
    
    /// 外部参数
    struct Params {
        var url = ""
        var appId = ""
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

    override func viewDidLoad() {
        super.viewDidLoad()
        clearWebCache()
        self.view.backgroundColor = UIColor.randomColor
        setupSubViews()
    }
    func setupSubViews(){
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect.zero, configuration: webConfig)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.cookieDelegate  = self
        
        webView.evaluateJavaScript("navigator.userAgent") { [weak self] result, error in
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
                self?.webView.customUserAgent = userAgent
            }
        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(kNavBarHeight)
            
        }
        loadRequestUrl()
    }
    
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    func loadRequestUrl() {
        
        webView?.startCustomCookie()
        
        let url:NSURL = NSURL(string:self.params.url)!

        let request : NSMutableURLRequest = NSMutableURLRequest(url: url as URL)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            self.webView?.load(request as URLRequest)
        }
    }
    
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
// MARK: ------------------------- Delegate
extension SPDate202206ViewController: GGWkWebViewDelegate{
    //设置cookies
    func webviewSetAppCookieKeyAndValue() -> [AnyHashable : Any]! {
        return ["app_token": "token_62a99c028136e3VXn5oPa5wWoFfixVLRx",
                "with_app_id": self.params.appId,
                "app-type":"merchant_assistant_app"
        ]
    }
}

extension SPDate202206ViewController: WKUIDelegate, WKNavigationDelegate {
    // 开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showLoadingView()
    }
    
    // 完成加载
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoadingView()
    }
    
    // 加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.hideLoadingView()
        printLog("error - \(error)")
        showHudText("加载失败，请稍后重试")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let urlstr = navigationAction.request.url
        printLog("urlstr -\(urlstr) allHTTPHeaderFields:\(navigationAction.request.allHTTPHeaderFields)")
        
        if #available(iOS 11.0, *) {
            let coolieStore = webView.configuration.websiteDataStore.httpCookieStore
            coolieStore.getAllCookies { cookies in
                for item in cookies {
                    HTTPCookieStorage.shared.setCookie(item)
                    printLog("item - \(item.name)=\(item.value)")
                }
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}
