//
//  BaseTabBarViewController.swift
//  XMHomeUI
//
//  Created by flowerflower on 2021/9/1.
//

import UIKit

public class BaseTabBarViewController: UITabBarController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        setupAppearance()

        
    }
}

extension BaseTabBarViewController{
    
    private func setupViewControllers(){

        var controllers:[UIViewController]
        var titles:[String]
        switch SPAppCore.shared.appType {
        case .xmly:
            controllers =
                [XMHomeViewController(),XMHomeViewController(),XMHomeViewController(),XMHomeViewController(),XMHomeViewController()]
            titles = ["首页","VIP","待定","动态","我的"]
        default:
            controllers  =
                [SPHomeViewController(),SPSummaryReviewViewController(),SPTestViewController(),SPTestViewController(),SPUserCenterViewController()]
            titles = ["首页","复盘","待定","算法","我的"]
        }
        let normalImageNames = ["icon_play_stop","icon_play_stop","","icon_play_stop","icon_play_stop"]
        let selectImageNames = ["icon_play_stop","icon_play_stop","","icon_play_stop","icon_play_stop"]
        
        for (index, vc) in controllers.enumerated() {
            vc.tabBarItem.title = titles[index]
            vc.tabBarItem.image = UIImage(named: normalImageNames[index])
            vc.tabBarItem.selectedImage = UIImage(named: selectImageNames[index])
            //设置选中图标的颜色
            self.tabBar.tintColor = UIColor.red
      
            addChild( BaseNavViewController(rootViewController: vc))
            
        }
        self.selectedIndex = 0
    }

    private func setupAppearance(){
        
        let tabBar = UITabBarItem.appearance()
        let attrs_Normal = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attrs_Select = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.red]

        tabBar.setTitleTextAttributes(attrs_Normal, for: .normal)
        tabBar.setTitleTextAttributes(attrs_Select, for: .selected)
    }
}

