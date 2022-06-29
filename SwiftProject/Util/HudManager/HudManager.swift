//
//  HudManager.swift
//  XMUtil
//
//  Created by flowerflower on 2021/8/31.
//

import Foundation
import MBProgressHUD

public class HudManager: NSObject {

    
    public func showHudText(_ text:String){
        showHudWithText(text: text)
    }
    public func showHudWithText(text:String,toView:UIView? = nil,afterDelay:TimeInterval? = 1.5){
        if kStringIsEmpty(string: text) {return}
        var  view = toView
        if (view == nil){
            view = UIApplication.shared.windows.last!
        }
        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        hud.mode = .text
        hud.label.text = text;
        hud.label.font = UIFont.systemFont(ofSize: 15)
        hud.label.textColor = UIColor.white
        hud.label.numberOfLines = 0;
        hud.bezelView.layer.cornerRadius = 0;
        hud.margin = 12;
        hud.isUserInteractionEnabled = false;
        hud.hide(animated: true, afterDelay: afterDelay ?? 1.5)
    }
//
//    // 显示成功  带勾勾图标
//    + (void)showSuccessText:(NSString *)text;
//
//    // 显示失败 带x图标
//    + (void)showErrorText:(NSString *)text;
//
//    // 显示警告 带⚠️图标
//    + (void)showWarnText:(NSString *)text;
//
//    // 显示自定义图片和提示语
//    + (void)showCustomIcon:(NSString *)iconName text:(NSString *)text;

    
}
