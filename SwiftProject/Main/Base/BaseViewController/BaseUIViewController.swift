//
//  BaseUIViewController.swift
//  BaseUI
//
//  Created by flowerflower on 2021/8/15.
//

import UIKit


// MARK: ------------------------- Const/Enum/Struct

extension BaseUIViewController {
    

    
}

 class BaseUIViewController: UIViewController {
    
    
    // MARK: ------------------------- Propertys
    
    
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        super.viewDidLoad()
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
    
    public func showLoadingView(){
        
    }
    
    public func hideLoadingView(){
        
    }
    
    
    
    public func showNetworkErrorView(){
        
    }
    
    public func hideNetworkErrorView(){
        
    }
    
    
    public func showNoDataErrorView(){
        
    }
    
    public func hideNoDataErrorView(){
        
    }
    
    
    public func onNetworkErrorViewReload(){
        
    }
    
    public func onNoDataErrorViewReload(){
        
    }
    
    ///服务挂了 显示正在连接中，请重试
    public func showConnectingErrorView(){
        
    }
    
    public func showHudText(_ text:String){
        
        
        showHudWithText(text: text)
    }
    public func showHudWithText(text:String,toView:UIView? = nil,afterDelay:TimeInterval? = 1.5){
        
        HudManager().showHudWithText(text: text, toView: toView, afterDelay: afterDelay)
        
    }
    
}
