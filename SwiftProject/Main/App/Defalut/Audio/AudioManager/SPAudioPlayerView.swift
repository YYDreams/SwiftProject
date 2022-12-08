//
//  SPAudioPlayerView.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/12/5.
//

import Foundation
import UIKit

public enum SPAudioPlayerViewType {
    
    case lastclick   // 上一首
    case nextclick   // 下一首
    case play        // 播放
    case stop        // 暂停
    case playSort // 播放顺序
    case playTime // 定时关闭
    case speed //倍速播放
    case playList  //播放列表
    case back15s  //后退15秒
    case forward15s  //前进15秒
}


class SPAudioPlayerView: UIView {
    
    //所有事件回调
    var playerOnClickBlock:((SPAudioPlayerViewType) -> Void)?
    
    
    // MARK: ------------------------- Propertys
    
    // MARK: ------------------------- CycLife
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubView(){
        //        self.addSubview(lastBtn)
        //        self.addSubview(playBtn)
        //        self.addSubview(nextBtn)
        
        addSubview(titleLabel)
        addSubview(coverImageView)
        addSubview(stackView)
        addSubview(progressView)
        addSubview(playerView)
        
        titleLabel.snp.makeConstraints{
            $0.left.equalTo(40.5)
            $0.right.equalTo(-40.5)
            $0.top.equalTo(32+kNavBarHeight)
        }
        coverImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 288, height: 216))
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom).offset(32)
            make.left.equalTo(coverImageView.snp.left).offset(24)
            make.right.equalTo(coverImageView.snp.right).offset(-24)
            make.height.equalTo(44)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(25)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(20)
        }
        playerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(progressView.snp.bottom).offset(45)
            make.height.equalTo(80)
            make.bottom.lessThanOrEqualTo(self.snp.bottom).offset(-kTabBarHeight - 20)
        }
        
    }
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        let btns = [sortBtn, timeBtn, speedBtn,playListBtn]
        for btn in btns {
            stackView.addArrangedSubview(btn)
            btn.snp.makeConstraints { make in
                make.size.equalTo(CGSize.init(width: 48, height: 44))
            }
        }
        return stackView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式\n超级思考术-升级思维模式"
        return label
    }()
    lazy var coverImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 8
        view.clipsToBounds =  true
        return view
    }()
    
    lazy var sortBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("顺序播放", for: .normal)
        btn.setTitleColor(UIColor(hexInt: 0xFFFFFF), for: .normal)
        btn.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
        btn.setImage(UIImage(named: "audio_icon_sort_new"), for: .normal)
        return btn
    }()
    lazy var timeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("定时关闭", for: .normal)
        btn.setTitleColor(UIColor(hexInt: 0xFFFFFF), for: .normal)
        btn.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
        btn.setImage(UIImage(named: "audio_icon_time_new"), for: .normal)
        return btn
    }()
    lazy var speedBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("倍速播放", for: .normal)
        btn.setTitleColor(UIColor(hexInt: 0xFFFFFF), for: .normal)
        btn.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
        btn.setImage(UIImage(named: "audio_icon_speed2"), for: .normal)
        return btn
    }()
    lazy var playListBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("播放列表", for: .normal)
        btn.setTitleColor(UIColor(hexInt: 0xFFFFFF), for: .normal)
        btn.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
        btn.setImage(UIImage(named: "btn_playlist_new"), for: .normal)
        return btn
    }()
    
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
    
    lazy var progressView: SPAudioPlayProgressView = {
        let view = SPAudioPlayProgressView()
        view.backgroundColor = UIColor.orange
        return view
    }()
    lazy var playerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
}
