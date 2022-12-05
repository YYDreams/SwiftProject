//
//  SPAutoViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/12/3.
//

import Foundation
import UIKit

class XELocalAudioPlayController: BaseUIViewController {

    
//    public var jumpParam =  JumpParamModel()
//    public var audioPlayer = XENewAudioPlayer.shared
//    var reportItemKey: String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavView()
        setUI()
//        startPlay()
//        bindEvetn()

    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        view.bringSubviewToFront(navView)
//        audioPlayer.setDelegate(delegate: self)
//        audioPlayer.audioModel = getAudioModel()
//        testData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        XENewAudioPlayer.shared.removeDelegate(delegate: self)
    }
    // MARK: - UI
    func setNavView() {
//        navView.backgroundColor = .clear
//        navView.lineLabel.isHidden = true
//        let imageName = (self.presentingViewController != nil) ? "course_downback_icon" : "course_back_icon"
//        leftBtnImg = XEAudioTheme.image(imageName)
    }
    func setUI() {
        self.view.backgroundColor = .lightGray
//        addBackgrounView()

        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height)
        }
        contentView.addSubview(titleLabel)
        contentView.addSubview(coverImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(sliderView)
        contentView.addSubview(audioManagerView)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(40.5)
            make.right.equalTo(-40.5)
            make.top.equalTo(32 + kNavBarHeight)
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
        sliderView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(25)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(20)
        }
        sliderView.layoutIfNeeded()
        audioManagerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(sliderView.snp.bottom).offset(45)
            make.height.equalTo(80)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom).offset(-20)
        }
    }
// MARK: - property
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
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        view.backgroundColor = .clear
        return view
    }()
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        let btns = [sortBtn, timeBtn, speedBtn]
        for btn in btns {
            stackView.addArrangedSubview(btn)
            btn.snp.makeConstraints { make in
                make.size.equalTo(CGSize.init(width: 48, height: 44))
            }
        }
        return stackView
    }()
    lazy var sortBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("顺序播放", for: .normal)
        btn.setTitleColor(UIColor(hexInt: 0xFFFFFF), for: .normal)
        btn.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
//        buttonWithTitle("顺序播放", textColor: UIColor(hexInt: 0xFFFFFF, alpha: 0.8), fontSize: 12)
//        btn.setImage(XEAudioTheme.image("audio_icon_sort_new"), for: .normal)
        btn.isHidden = true
        return btn
    }()
    lazy var timeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("定时关闭", for: .normal)
        btn.setTitleColor(UIColor(hexInt: 0xFFFFFF), for: .normal)
        btn.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
//        let btn = UIButton.buttonWithTitle("定时关闭", textColor: UIColor(hexInt: 0xFFFFFF, alpha: 0.8), fontSize: 12)
//        btn.setImage(XEAudioTheme.image("audio_icon_time_new"), for: .normal)
        btn.addTarget(self, action: #selector(timeBtnDidClick), for: .touchUpInside)
        return btn
    }()
    lazy var speedBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("倍速播放", for: .normal)
        btn.setTitleColor(UIColor(hexInt: 0xFFFFFF), for: .normal)
        btn.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
//        let btn = UIButton.buttonWithTitle("倍速播放", textColor: UIColor(hexInt: 0xFFFFFF, alpha: 0.8), fontSize: 12)
//        btn.setImage(XEAudioTheme.image("audio_icon_speed2"), for: .normal)
        btn.addTarget(self, action: #selector(speedBtnDidClick), for: .touchUpInside)
        return btn
    }()
    lazy var sliderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        return view
    }()
    lazy var audioManagerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
//        view.playBtn.snp.remakeConstraints { make in
//            make.size.equalTo(CGSize(width: 80, height: 80))
//            make.center.equalToSuperview()
//        }
//        view.lastBtn.snp.remakeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.width.height.equalTo(36)
//            make.right.equalTo(view.playBtn.snp.left).offset(-32)
//        }
//
//        view.nextBtn.snp.remakeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.width.height.equalTo(36)
//            make.left.equalTo(view.playBtn.snp.right).offset(32)
//        }
//        view.lastBtn.isHidden = true
//        view.nextBtn.isHidden = true
        return view
    }()
    lazy var blurImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    // 设置播放速率的视图
//    lazy var playRateView: AudioPlayRateView = {
//        let rateView = AudioPlayRateView.init(frame: kScreenBound)
//        return rateView
//    }()
    // 选择定时器的视图
//    lazy var timeIntervalView: AudioIntervalSelectView = {
//        let timeView = AudioIntervalSelectView.init(frame: kScreenBound)
//        return timeView
//    }()
    func testData() {
//        sliderView.setDataForUI(resouceId:  "",
//                                nowTimeStr: "00:00",
//                                endTimeStr: "00:00",
//                                playProgress: 0)
//        let image = XEAudioTheme.image("avator")
//        coverImageView.image = image
//        blurImageView.image = createGaussianBlurImage(image ?? UIImage())
    }
    func updateUI() {
//        sliderView.setDataForUI(resouceId:  "",
//                                nowTimeStr: "00:00",
//                                endTimeStr: "00:00",
//                                playProgress: 0)
    }
}

// MARK: - Event
extension XELocalAudioPlayController {
    func setSpeedBtn(titile: String, image: String) {
        speedBtn.setTitle(titile, for: .normal)
//        speedBtn.setImage(XEAudioTheme.image(image), for: .normal)
//        ToolObject.exchangeImgwithTitleLabel(Btn: speedBtn, positionType: .top, space: 4)
    }
    func setTimeBtn(title: String, image: String = "") {
        timeBtn.setTitle(title, for: .normal)
        if image.isEmpty == false {
//            timeBtn.setImage(XEAudioTheme.image(image), for: .normal)
        }
//        ToolObject.exchangeImgwithTitleLabel(Btn: timeBtn, positionType: .top, space: 4)
    }
    @objc func speedBtnDidClick() {
//        self.playRateView.show(senderVC: self,playRate: audioPlayer.rate)
//        self.playRateView.snp.remakeConstraints({ make in
//            make.edges.equalToSuperview()
//        })
    }
    @objc func timeBtnDidClick() {
//        self.timeIntervalView.show(senderVC: self)
//        self.timeIntervalView.snp.remakeConstraints({ make in
//            make.edges.equalToSuperview()
//        })
    }
    
}
// MARK: - 背景
extension XELocalAudioPlayController {
    func addBackgrounView() {
//        self.view.addSubview(blurImageView)
//        blurImageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        /// 添加10%黑色蒙层
//        let view = UIView()
//        view.backgroundColor = UIColor.black.alpha(0.1)
//        self.view.addSubview(view)
//        view.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        /// 添加毛玻璃效果
//        let  blurEffect = UIBlurEffect.init(style: .light)
//        let effectView = UIVisualEffectView.init(effect: blurEffect)
//        self.view.addSubview(effectView)
//        effectView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
 
}

