//
//  BaseTabBarViewController.swift
//  XMHomeUI
//
//  Created by flowerflower on 2021/9/1.
//

import Foundation
import XMUtil
//import XMMediator
//import XMHomeUIExtension
open class BaseTabBarViewController: UITabBarController {

    private lazy var playBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "home_vip_play_btn"), for: .normal)
        
        //        UIButton.init(imageName: "tab_play", bgImageName: "tab_play")

        return btn
    }()
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
//        setupPlayBtn()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViewControllers()
        setupAppearance()

        
    }
}

extension BaseTabBarViewController{
    
    private func setupViewControllers(){

        
//        guard let homeVc  =  XEMediator.shared().XMHomeUI_homeViewController() else{
//            return
//        }
//
        
//       let homeVc =   XEMediator.shared()?.XEAccountUI_launchViewController()
        //       let tingVc =   XEMediator.shared()?.XEAccountUI_launchViewController()
        //       let playVc =   XEMediator.shared()?.XEAccountUI_launchViewController()
        //       let discoverVc =   XEMediator.shared()?.XEAccountUI_launchViewController()
        //       let accountVc =   XEMediator.shared()?.XEAccountUI_launchViewController()
        
        let controllers:[UIViewController]  =
            [SPHomeViewController(),SPDeveloperViewController(),LearningCenterViewController(),SPAlgorithmViewController(),MineViewController()]
        let normalImageNames = ["icon_play_stop","icon_play_stop","","icon_play_stop","icon_play_stop"]
        let selectImageNames = ["icon_play_stop","icon_play_stop","","icon_play_stop","icon_play_stop"]
        
        let mineTitle = "账户"
//            !(LoginHelper.sharedInstance.userInfo?.isLogin ?? false)  ? "未登录" : "账户"
        let titles = ["首页","我听","","算法",mineTitle]
        
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
    
    private func setupPlayBtn(){
        
        tabBar.addSubview(playBtn)
        let w = tabBar.bounds.width / CGFloat(children.count) - 1
        // OC CGRectInset 正数向内索进 负数向外扩展 例如 中心向上凸出 -20
        //        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: -20)
        playBtn.frame = tabBar.bounds.insetBy(dx: 2 * w , dy: 0)
        playBtn.addTarget(self, action: #selector(playBtnOnClick), for: .touchUpInside)
        
    }
    @objc  private func  playBtnOnClick(){
        
        print("playBtnOnClick")
        present(BaseNavViewController(rootViewController: UIViewController()), animated: true, completion: nil)
        
    }
}
