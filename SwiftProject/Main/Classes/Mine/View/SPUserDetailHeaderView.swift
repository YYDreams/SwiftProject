//
//  SPUserDetailView.swift
//  SwiftProject
//
//  Created by flower on 2022/4/11.
//

import Foundation
import UIKit

class SPUserDetailHeaderView: UIView {
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var avatarImgView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var concernButton: UIButton!
    
    @IBOutlet weak var recommendButton: UIButton!
    
    
    @IBOutlet weak var recommendView: UIView!
    
    @IBOutlet weak var recommendViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var topTabView: UIView!
    
    @IBOutlet weak var tapTabViewHeight: NSLayoutConstraint!

    
    @IBOutlet weak var separatorView: UIView!

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var baseView: UIView!
    
    
    
    class func headerView()-> SPUserDetailHeaderView{
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! SPUserDetailHeaderView
    }

    
}
