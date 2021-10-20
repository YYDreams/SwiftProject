//
//  SPAudioBgView.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/9.
//

import Foundation
import UIKit
import XMUtil
enum AudioBgClickType:Int{
    case sort        // 点击顺序
    case time        // 点击定时
    case speed       // 定级倍数
    case playList    // 播放列表
    case back15      // 后退15秒
    case forward15   // 前进15秒
    case lastclick   // 上一首
    case nextclick   // 下一首
    case play        // 播放
    case stop        // 暂停
    case dragprogress// 拖动进度条
}


class SPAudioBgView: UIView{
    
    // MARK: ------------------------- Propertys
    var audioBgCallbackBlock:((AudioBgClickType, Float?)->Void)?
    
    /// 背景图
    lazy var bgView:UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.init(hex: "333333")
        return view
    }()
    
    /// 标题
    lazy var audioNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.setLineSpacing(2)
        return label
    }()
    
    /// 时间，学习人数
    lazy var timeStudyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        
        
        label.alpha = 0.6
        return label
    }()
    
    /// 音乐背景图
    lazy var audioImage:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    ///
    lazy var buttonListStackView: UIStackView = {
        let view: UIStackView = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 0
        return view
    }()
    
    /// 顺序播放
    lazy var sortBtn: UIButton = {
        let button = UIButton()
        button.setTitle("顺序播放", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: "audio_icon_sort_new"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
        button.tag = AudioBgClickType.sort.rawValue
        button.setImagePosition(.top, spacing: 4)
        return button
    }()
    
    /// 定时关闭
    lazy var timeBtn: UIButton = {
        let button = UIButton()
        button.setTitle("定时关闭", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: "audio_icon_time_new"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
        button.tag = AudioBgClickType.time.rawValue
        button.setImagePosition(.top, spacing: 4)
        return button
    }()
    
    /// 倍速播放
    lazy var speedBtn: UIButton = {
        let button = UIButton()
        button.setTitle("倍速播放", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: "audio_icon_speed2"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
        button.tag = AudioBgClickType.speed.rawValue
        button.setImagePosition(.top, spacing: 4)
        return button
    }()
    
    /// 播放列表
    lazy var playListBtn: UIButton = {
        let button = UIButton()
        button.setTitle("播放列表", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: "btn_playlist_new"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
        button.tag = AudioBgClickType.playList.rawValue
        button.setImagePosition(.top, spacing: 4)
        return button
    }()
    
    /// 播放比例
    lazy var sliderView: SPAudioPlayProgressView = {
        let sliderView = SPAudioPlayProgressView()
        return sliderView
    }()
    
    /// 音乐管理
    lazy var audioManager: XAAudioManagerView = {
        let audioManager = XAAudioManagerView(frame: .zero,isSmall: false)
        return audioManager
    }()
    
    // MARK: ------------------------- CycLife
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubViews(){
        addSubview(bgView)
        addSubview(audioNameLabel)
        addSubview(timeStudyLabel)
        addSubview(audioImage)
        addSubview(buttonListStackView)
        buttonListStackView.addArrangedSubview(sortBtn)
        buttonListStackView.addArrangedSubview(timeBtn)
        buttonListStackView.addArrangedSubview(speedBtn)
        buttonListStackView.addArrangedSubview(playListBtn)
        self.addSubview(sliderView)
        self.addSubview(audioManager)
        
        
        
        
        
    }
    
    func setupConstraints() {
        
        bgView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo((FixH(height: 540) + kNavBarHeight))
        }
        
        audioNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(FixW(width: 40))
            make.width.equalTo((kScreenWidth - FixW(width: 80)))
            make.top.equalTo(kNavBarHeight)
        }
        
        timeStudyLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(audioNameLabel)
            make.top.equalTo(audioNameLabel.snp.bottom).offset(FixH(height: 8))
            make.height.equalTo(FixH(height: 18))
        }
        
        audioImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(FixW(width: 192))
            make.height.equalTo(FixH(height: 144))
            make.top.equalTo((FixH(height: 110) + kNavBarHeight))
        }
        
        buttonListStackView.snp.makeConstraints {
            $0.top.equalTo(audioImage.snp.bottom).offset(FixH(height: 24))
            $0.height.equalTo(FixH(height: 44))
            $0.width.equalTo(kScreenWidth - 12 * 2)
            $0.centerX.equalToSuperview()
        }
        timeBtn.snp.makeConstraints { (make) in
            make.width.equalTo((kScreenWidth - 24)/4)
            make.height.equalTo(FixH(height: 44))
        }
        sortBtn.snp.makeConstraints { (make) in
            make.size.equalTo(timeBtn)
        }
        
        speedBtn.snp.makeConstraints { (make) in
            make.size.equalTo(timeBtn)
        }
        
        playListBtn.snp.makeConstraints { (make) in
            make.size.equalTo(timeBtn)
        }
        sliderView.snp.makeConstraints { (make) in
            make.top.equalTo(timeBtn.snp_bottom).offset(FixH(height: 46))
            make.left.right.equalToSuperview()
            make.height.equalTo(sliderView.buttonHeight)
        }
        
        
        audioManager.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(sliderView.snp_bottom).offset(FixH(height: 46))
            make.height.equalTo(FixH(height: 56))
        }
        
    }
    
    
    // MARK: ------------------------- Events
    
    @objc func btnOnClick(_ btn: UIButton) {
        let tag:AudioBgClickType = AudioBgClickType(rawValue: btn.tag) ?? .sort
        
        switch tag {
        case .sort:
            //            XEAudioPlayer.shared.playSort = (XEAudioPlayer.shared.playSort == .normalSort ? .singleSort : .normalSort)
            audioBgCallbackBlock?(.sort, nil)
        case .time:
            audioBgCallbackBlock?(.time, nil)
        case .speed:
            audioBgCallbackBlock?(.speed, nil)
        case .playList:
            audioBgCallbackBlock?(.playList, nil)
        default:
            break
        }
    }
    
    // MARK: ------------------------- Methods
    
}
