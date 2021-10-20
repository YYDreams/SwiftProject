//
//  SPAudioManagerView.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/9.
//

import UIKit
import XMUtil
import SnapKit
/// 快进、快退、上下一首
public enum PlayOrPauseBtnState{
    case play
    case pause
    case loading
    case readyToPlay
}

public enum navAudioType {
    case navBack15      // 后退15秒
    case navForward15   // 前进15秒
    case navLastclick   // 上一首
    case navNextclick   // 下一首
    case navPlay        // 播放
    case navStop        // 暂停
}


public class XAAudioManagerView: UIView {

    public var callbackBlock:((navAudioType)->Void)?
    
    /// 后退15秒
    public var forbackBtn = UIButton()
    
    /// 前进15秒
    public var forwardBtn = UIButton()
    
    /// 上一首播放
    public var lastBtn = UIButton()
    
    /// 播放
    public var playBtn = UIButton()
    
    /// 下一首
    public var nextBtn = UIButton()
    
    /// 是否是顶部小图标
    var isSmallSize = false
    
    public var currentPlayState: PlayOrPauseBtnState = .loading
    

    public convenience init(frame: CGRect, isSmall: Bool = false) {
        self.init(frame: frame)
        isSmallSize = isSmall
        createUI(isSmall)
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
        
    func  createUI(_ isSmall: Bool = false) {
     
        var lastimage = ""
        var playimage = ""
        var nextimage = ""
        if isSmall {
            self.addSubview(lastBtn)
            self.addSubview(playBtn)
            self.addSubview(nextBtn)
            lastimage = "icon_play_last"
            playimage = "icon_play_stop"
            nextimage = "icon_play_next"
        } else {
            self.addSubview(lastBtn)
            self.addSubview(playBtn)
            self.addSubview(nextBtn)
            self.addSubview(forbackBtn)
            self.addSubview(forwardBtn)
            //小鹅3.0ui改版，快进快退放到了进度条旁边，所以隐藏掉
            forbackBtn.isHidden = true
            forwardBtn.isHidden = true
            lastimage = "audio_icon_last"
            playimage = "audio_icon_stop"
            nextimage = "audio_icon_next"
        }
        
        
        forbackBtn.setImage(UIImage(named: "audio_icon_backward"), for: .normal)
        forwardBtn.setImage(UIImage(named: "audio_icon_reserve"), for: .normal)
        lastBtn.setImage(UIImage(named: lastimage), for: .normal)
        nextBtn.setImage(UIImage(named: nextimage), for: .normal)
        playBtn.setImage(UIImage(named: playimage), for: .normal)
        
        if isSmall {
            refreshFrameToSmallSize()
        } else {
            nomarlFrameSize()
        }

        playBtn.addTarget(self, action: #selector(audioViewclick(_ :)), for: .touchUpInside)
        forbackBtn.addTarget(self, action: #selector(audioViewclick(_ :)), for: .touchUpInside)
        forwardBtn.addTarget(self, action: #selector(audioViewclick(_ :)), for: .touchUpInside)
        lastBtn.addTarget(self, action: #selector(audioViewclick(_ :)), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(audioViewclick(_ :)), for: .touchUpInside)
        
        forbackBtn.tag = 998
        lastBtn.tag = 999
        playBtn.tag = 1000
        nextBtn.tag = 1001
        forwardBtn.tag = 1002
    }
    
    
    /// 外部处于播放状态，改变详情页状态
    public func setPlayOrPauseBtnState(state: PlayOrPauseBtnState) {
        
        let playImage = isSmallSize ? "icon_play_play":"audio_icon_play"
        let pauseImage = isSmallSize ? "icon_play_stop":"audio_icon_stop"
        currentPlayState = state
        if state == .play {
            playBtn.setImage(UIImage(named:playImage), for: .normal)
        } else if state == .pause {
            playBtn.setImage(UIImage(named:pauseImage), for: .normal)
        } else if state == .loading {
            if let loadingImage = UIImage.getGIFImageWithGifName("loading") {
                playBtn.setImage(loadingImage, for: .normal)
            }
        }
    }
    
    
    /// 顶部小图布局
    func refreshFrameToSmallSize()  {
        lastBtn.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
            make.right.equalTo(playBtn.snp.left).offset(-40)
        }
        
        nextBtn.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
            make.left.equalTo(playBtn.snp.right).offset(40)
        }
        
        playBtn.snp.remakeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(32)
        }
    }
    
    /// 正常布局
    func nomarlFrameSize() {
        playBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(FixH(height: 56))
        }
        
        lastBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(playBtn.snp.centerY)
            make.width.height.equalTo(FixH(height: 24))
            make.right.equalTo(playBtn.snp.left).offset(-40)
        }
        
        nextBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(playBtn.snp.centerY)
            make.width.height.equalTo(FixH(height: 24))
            make.left.equalTo(playBtn.snp.right).offset(40)
        }
        
        forbackBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(playBtn.snp.centerY)
            make.width.height.equalTo(FixH(height: 24))
            make.right.equalTo(lastBtn.snp.left).offset(-40)
        }
        
        forwardBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(playBtn.snp.centerY)
            make.width.height.equalTo(FixH(height: 24))
            make.left.equalTo(nextBtn.snp.right).offset(40)
        }
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
            callbackBlock?(.navBack15)
        break
        case 999:
            callbackBlock?(.navLastclick)
        break
        case 1000:
            if btn.isSelected {
                callbackBlock?(.navStop)
                btn.isSelected = false
            } else {
                callbackBlock?(.navPlay)
                btn.isSelected = true
            }
        break
        case 1001:
            callbackBlock?(.navNextclick)
        break
        case 1002:
            callbackBlock?(.navForward15)
        break
        default:
            break
        }
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
