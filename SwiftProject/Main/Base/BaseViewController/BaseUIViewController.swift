//
//  BaseUIViewController.swift
//  BaseUI
//
//  Created by flowerflower on 2021/8/15.
//

import Foundation
import XMUtil


// MARK: ------------------------- Const/Enum/Struct

extension BaseUIViewController {
    

    
}

open  class BaseUIViewController: UIViewController {
    
    
    // MARK: ------------------------- Propertys
    
    
    
    // MARK: ------------------------- CycLife
    open override func viewDidLoad() {
        self.view.backgroundColor = kBgColor
        super.viewDidLoad()
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
    
    open func showLoadingView(){
        
    }
    
    open func hideLoadingView(){
        
    }
    
    
    
    open func showNetworkErrorView(){
        
    }
    
    open func hideNetworkErrorView(){
        
    }
    
    
    open func showNoDataErrorView(){
        
    }
    
    open func hideNoDataErrorView(){
        
    }
    
    
    open func onNetworkErrorViewReload(){
        
    }
    
    open func onNoDataErrorViewReload(){
        
    }
    
    ///服务挂了 显示正在连接中，请重试
    open func showConnectingErrorView(){
        
    }
    
    open func showHudText(text:String){
        
        
        showHudWithText(text: text)
    }
    open func showHudWithText(text:String,toView:UIView? = nil,afterDelay:TimeInterval? = 1.5){
        
        HudManager().showHudWithText(text: text, toView: toView, afterDelay: afterDelay)
        
    }
    
}
