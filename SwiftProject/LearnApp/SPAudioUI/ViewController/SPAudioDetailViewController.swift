//
//  SPAudioDetailViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/9.
//

import Foundation
import UIKit
import XMUtil
// MARK: ------------------------- Const/Enum/Struct

extension SPAudioDetailViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Propertys {}
    
    /// 外部参数
    struct Params {}
    
}

class SPAudioDetailViewController: BaseUIViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 音频背景
    lazy var audioDetailView: SPAudioBgView = {
    
        let audioDetailView = SPAudioBgView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: (FixH(height: 540) + kNavBarHeight)))
        audioDetailView.audioBgCallbackBlock = { [weak self] (type, progress) in
            self?.audioDetailViewOnClick(type: type, progress: progress)
        }
        return audioDetailView
    }()
    
    ///
    
    
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubView()
        view.addSubview(audioDetailView)
        
    }
    
    func setupSubView(){
        
    }
    
    // MARK: ------------------------- Events
    func audioDetailViewOnClick(type: AudioBgClickType,progress:Float?){
        
    }
    
    
    // MARK: ------------------------- Methods
    
}
