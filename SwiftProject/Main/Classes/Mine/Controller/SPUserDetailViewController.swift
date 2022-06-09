//
//  SPUserDetailViewController.swift
//  SwiftProject
//
//  Created by flower on 2022/4/11.
//

import Foundation
import SnapKit
import UIKit

class SPUserDetailViewController: BaseUIViewController{
    
    var scrollView: UIScrollView!
    
    var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    @objc func injected() {
        #if DEBUG
        print("I've been injected: \(self)")
        #endif
    }

    lazy var headerView:SPUserDetailHeaderView = {
        let headerView = SPUserDetailHeaderView.headerView()
        return headerView
    }()
    
    func setupSubViews(){
        
        bottomView = {
            let  bottomView  = UIView()
            bottomView.backgroundColor = kThemeColor
            return bottomView
        }()
        scrollView = {
            let scrollView = UIScrollView()
            scrollView.backgroundColor = UIColor.orange
            return scrollView
        }()
        self.view.addSubview(bottomView)
        self.view.addSubview(scrollView)
        
        bottomView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.height.equalTo(44)
            $0.bottom.equalTo(-kSafeAreaBottom)
            
        }
        scrollView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(kNavBarHeight)
            $0.bottom.equalTo(bottomView.snp.top)
            
        }
        
        scrollView.addSubview(headerView)
        scrollView.contentSize = CGSize(width: kScreenWidth, height: 1000)
        
        
        
        
    }
    
}
