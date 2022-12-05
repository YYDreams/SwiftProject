//
//  SPAudioPlayerView.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/12/5.
//

import Foundation

public enum SPAudioPlayerViewType {
    case lastclick   // 上一首
    case nextclick   // 下一首
    case play        // 播放
    case stop        // 暂停
}


class SPAudioPlayerView: UIView {
    
    
    // MARK: ------------------------- Propertys
    lazy var lastBtn: UIButton = {
        let view = UIButton()
        return view
    }()
    
    lazy var nextBtn: UIButton = {
        let view = UIButton()
        return view
    }()
    
    lazy var playBtn: UIButton = {
        let view = UIButton()
        return view
    }()

    // MARK: ------------------------- CycLife
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubView(){
        self.addSubview(lastBtn)
        self.addSubview(playBtn)
        self.addSubview(nextBtn)
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
}
