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
        var normalImageNames = [String]()
        var selectImageNames = [String]()
        switch SPAppCore.shared.appType {
        case .xmly:
            controllers =
                [XMHomeViewController(),XMHomeViewController(),XMHomeViewController(),XMHomeViewController(),XMHomeViewController()]
            titles = ["首页","VIP","待定","动态","我的"]
        default:
            controllers  =
                [SPHighImitationController(),SPSummaryReviewViewController(),SPTestViewController(),SPTestViewController(),SPUserCenterViewController()]
            titles = ["高仿","复盘","封装","算法","我的"]
            normalImageNames = ["ldld_houseSrc_normal","ldld_order_normal","ldld_message_normal","cleaner_cmpOrd_normal","ldld_user_normal"]
            selectImageNames = ["ldld_houseSrc_selected","ldld_order_selected","ldld_message_selected","cleaner_cmpOrd_selected","ldld_user_selected"]
        }
      
        
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

