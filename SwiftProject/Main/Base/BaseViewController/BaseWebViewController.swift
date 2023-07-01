//
//  BaseWebViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/6/15.
//

import Foundation
import WebKit

class CookieModel: NSObject{
    var key = ""
    var value = ""
}

// MARK: ------------------------- Const/Enum/Struct

extension BaseWebViewController {

    /// 常量
    struct Const {}

    /// 内部属性
    struct Propertys {}

    /// 外部参数
    struct Params {
        var requestUrl = ""
    }

}

class BaseWebViewController: BaseUIViewController {

    // MARK: ------------------------- Propertys

    var webView: WKWebView!

    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()

    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    @objc func test(){
    
        self.params.requestUrl = "https://v.ixigua.com/AfmmcvB/"
        
//        self.webView.reload()
        
    }
    func setupSubViews(){
        
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(test), userInfo: nil, repeats: true)
        let configuration =  WKWebViewConfiguration()
        let contentController =  WKUserContentController()
        if #available(iOS 10.0, *){
//            configuration.mediaTypesRequiringUserActionForPlayback  = .none
        } else {
            // Fallback on earlier versions
            configuration.mediaPlaybackRequiresUserAction = false
        }
        
        var cookie = ""
        for cookieModel in cookieArr() {
            cookie = cookie.appendingFormat("document.cookie = '\(cookieModel.key)=\(cookieModel.value); path=/; domain=.xiaoeknow.com';")
            
        }
        let cookieScript = WKUserScript.init(source: cookie, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        contentController.addUserScript(cookieScript)
        configuration.userContentController = contentController
        
        webView = WKWebView(frame: CGRect(x: 0, y: kNavBarHeight, width: kScreenWidth, height: kScreenHeight),configuration: configuration)
        webView.scrollView.bounces = false
        webView.backgroundColor = UIColor.white
//        webView.scrollView.delegate = self
        webView.clipsToBounds = false
//        webView.customUserAgent = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserAgent"];
//        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
//        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        
        //设置userAgent
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
    
        loadWebViewUrl()
        
    }
    
    // 设置cookie
    func cookieArr() -> [CookieModel]{
        var cookies = [CookieModel]()
        
        let app_token =  CookieModel()
        app_token.key = "app_token"
        app_token.value = "token_62a99c028136e3VXn5oPa5wWoFfixVLRx"
        
        let with_app_id =  CookieModel()
        with_app_id.key = "with_app_id"
        with_app_id.value = "appptaa4nql6484"
        
        let app_type = CookieModel()
        app_type.key = " app-type"
        app_type.value = "merchant_assistant_app"
        
        cookies.append(app_token)
        cookies.append(with_app_id)
        cookies.append(app_type)
        return cookies
    }
    
    func loadWebViewUrl(){
        
        if webView.isLoading {
            return
        }
        if params.requestUrl.count > 0 {
            let request = NSMutableURLRequest(url: URL(string: params.requestUrl)!)
            var cookie = ""
            for cookieModel in cookieArr() {
                cookie = cookie.appendingFormat("\(cookieModel.key)=\(cookieModel.value),")
            }
            request.setValue(cookie, forHTTPHeaderField: "Cookie")
            self.webView?.load(request as URLRequest)
        }
    }
    

    // MARK: ------------------------- Events
    

    // MARK: ------------------------- Methods

}
