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

        
        let controllers:[UIViewController]  =
            [SPHomeViewController(),SPSummaryReviewViewController(),SPTestViewController(),SPTestViewController(),SPUserCenterViewController()]
     
        let normalImageNames = ["icon_play_stop","icon_play_stop","","icon_play_stop","icon_play_stop"]
        let selectImageNames = ["icon_play_stop","icon_play_stop","","icon_play_stop","icon_play_stop"]
        
        let titles = ["首页","复盘","待定","算法","我的"]
        
        for (index, vc) in controllers.enumerated() {
            
            vc.tabBarItem.title = titles[index]
            vc.tabBarItem.image = UIImage(named: normalImageNames[index])
            vc.tabBarItem.selectedImage = UIImage(named: selectImageNames[index])
            //设置选中图标的颜色
            self.tabBar.tintColor = UIColor.red
      
            addChild( BaseNavViewController(rootViewController: vc))
            
        }
        self.selectedIndex = 1
    }

    private func setupAppearance(){
        
        let tabBar = UITabBarItem.appearance()
        let attrs_Normal = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attrs_Select = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.red]

        tabBar.setTitleTextAttributes(attrs_Normal, for: .normal)
        tabBar.setTitleTextAttributes(attrs_Select, for: .selected)
    }
}

