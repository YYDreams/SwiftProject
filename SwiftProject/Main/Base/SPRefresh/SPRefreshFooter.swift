////
////  SPRefreshFooter.swift
////  SPBaseUI
////
////  Created by flowerflower on 2021/12/16.
////
//
//import UIKit
//import Lottie
//import MJRefresh
//
//@objc public class SPRefreshFooter: MJRefreshAutoFooter {
//
//    var animationView = AnimationView()
//    var noDateLabel = UILabel()
//
//    override public var state: MJRefreshState {
//        didSet {
//            setSate()
//        }
//    }
//
//    override public func prepare() {
//        super.prepare()
//
//        noDateLabel.text = "没有更多了～"
//        noDateLabel.textAlignment = .center
//        noDateLabel.font = UIFont.systemFont(ofSize: 12)
//        noDateLabel.textColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1)
//        noDateLabel.isHidden = true
//        addSubview(noDateLabel)
//
//        addAnimationView()
//    }
//
//    override public func placeSubviews() {
//        super.placeSubviews()
//
//        animationView.center = CGPoint(x: self.mj_w * 0.5, y: self.animationView.mj_h)
//        noDateLabel.frame = self.bounds
//    }
//
////    public override func endRefreshing() {
////
////        let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
////        DispatchQueue.main.asyncAfter(deadline: delayTime) {
////            super.endRefreshing()
////        }
////    }
//
////    public override func endRefreshingWithNoMoreData() {
////        let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
////        DispatchQueue.main.asyncAfter(deadline: delayTime) {
////            super.endRefreshingWithNoMoreData()
////        }
////    }
//
//    func addAnimationView() {
//
//        let animation = Animation.named("pullUpToRefresh")
////        let animation = Animation.named("pullUpToRefresh", bundle: SPBundleUtil.getCurrentBundle())
//
//        animationView.animation = animation
//        animationView.loopMode = .loop
//        animationView.contentMode = .scaleAspectFit
//        self.addSubview(animationView)
//        animationView.play()
//        animationView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
//        animationView.isHidden = true
//    }
//
//    public override func resetNoMoreData() {
//        super.resetNoMoreData()
//        noDateLabel.isHidden = true
//    }
//
//    func stopAnimation() {
//        animationView.play { [weak self](finish) in
//            if finish {
//                self?.animationView.stop()
//            }
//        }
//
//        animationView.isHidden = true
//    }
//
//    func setSate() {
//        switch state {
//        case .idle:
//            stopAnimation()
//        case .pulling:
//            animationView.stop()
//            animationView.isHidden = false
//        case .refreshing:
//            animationView.play()
//            animationView.isHidden = false
//        case .noMoreData:
//            stopAnimation()
//            noDateLabel.isHidden = false
//        default:
//            stopAnimation()
//        }
//    }
//
//}
