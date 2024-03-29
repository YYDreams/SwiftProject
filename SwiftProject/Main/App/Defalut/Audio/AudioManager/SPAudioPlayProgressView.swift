//
//  SPAudioPlayProgressView.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/12/5.
//

import Foundation
import UIKit
class SPAudioPlayProgressView: UIView {
    
    public let sliderPadding: CGFloat = 39
    public let sliderWidth: CGFloat = 68
    public let buttonHeight: CGFloat = 24
    public let sliderHeight: CGFloat = 20
    
    public enum AudioType {
        case back15      // 后退15秒
        case forward15   // 前进15秒
    }
    
    public var callbackBlock:((AudioType)->Void)?
    
    public var draggingClosure: ((Float)->Void)?
    
    public var dragEndClosure: ((Float)->Void)?
    
    public var isDraging = false // 是否正在拖动
    
    public var sliderProgressChangedWhenPause = false // 在音频b暂停的期间，进度条是否被拖动过

    public var currentTimeLabel = UILabel() // 总时长、当前时间标签
    
    public lazy var topTimeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.3)
        label.textAlignment = .center
        label.isHidden = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    var totalTime = "00:00"
    
    public var slider: UISlider // 进度条
    
    /// 后退15秒
    public var forbackBtn = UIButton()
    
    /// 前进15秒
    public var forwardBtn = UIButton()
        
    public override init(frame: CGRect) {
        slider = UISlider()
        super.init(frame: frame)
        setUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     public override func layoutSubviews() {
        super.layoutSubviews()
         
    }
    
    public func setUI() {

        currentTimeLabel.font = UIFont.systemFont(ofSize: 10)
        currentTimeLabel.textColor = UIColorHexFromRGB(rgbValue: 0x333333)
        currentTimeLabel.layer.cornerRadius = 10
        currentTimeLabel.layer.masksToBounds = true
        currentTimeLabel.backgroundColor = .white
        currentTimeLabel.textAlignment = .center
        currentTimeLabel.adjustsFontSizeToFitWidth = true
        currentTimeLabel.minimumScaleFactor = 0.5
        
        let image = getdrawimg(size: CGSize(width: sliderWidth, height: sliderHeight), backcolor: .clear)
        
        slider.minimumTrackTintColor = .white //左边槽的颜色
        slider.maximumTrackTintColor = UIColor(hex: "#FFFFFF")?.withAlphaComponent(0.2) //右边槽的颜色
        slider.setThumbImage(image, for: .normal)
        slider.setThumbImage(image, for: .highlighted)
        slider.addTarget(self, action: #selector(changingProgress), for: UIControl.Event.touchUpOutside)
        slider.addTarget(self, action: #selector(changingProgress), for: UIControl.Event.touchUpInside)
        slider.addTarget(self, action: #selector(changingProgress2), for: UIControl.Event.touchDown)
        slider.addTarget(self, action: #selector(valueChanging), for: UIControl.Event.valueChanged)
        
        forbackBtn.setImage(UIImage(named: "audio_icon_backward"), for: .normal)
        forwardBtn.setImage(UIImage(named: "audio_icon_reserve"), for: .normal)
        forbackBtn.addTarget(self, action: #selector(audioViewclick(_ :)), for: .touchUpInside)
        forwardBtn.addTarget(self, action: #selector(audioViewclick(_ :)), for: .touchUpInside)
        forbackBtn.tag = 998
        forwardBtn.tag = 1002
        
        self.addSubview(slider)
        self.addSubview(currentTimeLabel)
        self.addSubview(forbackBtn)
        self.addSubview(forwardBtn)
        self.addSubview(topTimeLabel)
        
        
        slider.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(sliderPadding)
            make.right.equalToSuperview().offset(-sliderPadding)
        }
        
        slider.value = SPAudioPlayerManager.shared.getCurrentProgress()
        let X:CGFloat = (self.bounds.width - sliderPadding * 2 - sliderWidth) * CGFloat(slider.value) + sliderPadding
        
        currentTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(X)
            make.width.equalTo(67)
            make.height.equalTo(sliderHeight)
        }
        
        forbackBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }

        forwardBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        topTimeLabel.snp.makeConstraints { make in
            make.width.equalTo(84)
            make.height.equalTo(24)
            make.bottom.equalTo(currentTimeLabel.snp.top).offset(-6)
            make.centerX.equalTo(currentTimeLabel)
        }
    }
    
    func getdrawimg(size: CGSize, backcolor: UIColor) -> UIImage{

        let rect = CGRect.init(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backcolor.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    public func setDataForUI(resouceId: String, nowTimeStr: String, endTimeStr: String, playProgress: Float) {
        totalTime = endTimeStr
        slider.value = playProgress
        currentTimeLabel.text = "\(nowTimeStr)/\(totalTime)"
        changeSliderFrame()
    }
    
    @objc public func changingProgress() {
        draggingClosure?(slider.value)
        isDraging = false
        topTimeLabel.isHidden = true
    }
    
    @objc public func changingProgress2() {

        isDraging = true
        topTimeLabel.text = currentTimeLabel.text
        topTimeLabel.isHidden = false
        if SPAudioPlayerManager.shared.playState == .paused {
            sliderProgressChangedWhenPause = true
        } else {
            sliderProgressChangedWhenPause = false
        }
    }

    @objc public func valueChanging() {
//        let str: String = SPAudioPlayerManager.shared.timeStrFromSecTime(time: Float(SPAudioPlayerManager.shared.getTotalSec() * slider.value))
//        currentTimeLabel.text = "\(str)/\(totalTime)"
        changeSliderFrame()
    }
    
    func changeSliderFrame() {
        var X:CGFloat = (self.bounds.width - sliderPadding * 2 - sliderWidth) * CGFloat(slider.value) + sliderPadding
        if X + 67.0 + 5.0 > forwardBtn.frame.origin.x {
            X = forwardBtn.frame.origin.x - 67.0 - 5.0
        }
        currentTimeLabel.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(X)
            make.width.equalTo(67)
            make.height.equalTo(sliderHeight)
        }
        
        //刷新顶部的时间条
        topTimeLabel.text = currentTimeLabel.text
    }
    
    /// 暂停中的时候设置播放条进度需要前进
    /// - Parameter value:
    public func setSliderProgress(second: Float) {
     
//        var progressTemp: Float
//        
//        let duration = XEAudioPlayer.shared.getTotalSec()
//        let nowSecond = XEAudioPlayer.shared.getCurrentSec()
//        if nowSecond + second < 0 {
//            progressTemp = 0
//            currentTimeLabel.text = "00:00/\(totalTime)"
//        } else if nowSecond + second > duration {
//            progressTemp = 1
//            currentTimeLabel.text = "\(totalTime)/\(totalTime)"
//        } else {
//            progressTemp = (nowSecond + second) / duration
//            let now =  SPAudioPlayerManager.shared.timeStrFromSecTime(time: (nowSecond + second))
//            currentTimeLabel.text = "\(now)/\(totalTime)"
//        }
//        slider.value = progressTemp
//        
//        changeSliderFrame()
//        
//        sliderProgressChangedWhenPause = true
        
    }
    
    @objc func audioViewclick(_ btn: UIButton) {
//        if XEReachability.shared.status == .notReachable {
//            XEDispatchOnMainThread {
//                Hud.showToast("网络异常")
//                return
//            }
//        }
        
        switch btn.tag {
        case 998:
            callbackBlock?(.back15)
        case 1002:
            callbackBlock?(.forward15)
        default: break
        }
    }
    
}
