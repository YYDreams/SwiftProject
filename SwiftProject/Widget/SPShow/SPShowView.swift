//
//  SPShowView.swift
//  SwiftProject
//
//  Created by flower on 2022/5/24.
//

import UIKit
public class SPShowView: UIView{
    
    private var btnClickCallBack: (( _ index: Int) -> Void)?
    
    //标记是否是自定义View
    private var isCustomView:Bool = false
    private var contentSize = CGSize.zero
    
    var config =  SPShowConfig()
    
    var contentView: UIView!
    
    var isAnimating = false
    
    var showTag:Int = 0
    
    @discardableResult
    //弹出自定义View
    public class func showCustomView(contentView:UIView,showConfig: SPShowConfig? = nil,callBack: ((_ index: Int) -> Void)? = nil) -> SPShowView{
        SPShowView(contentView: contentView, showConfig: showConfig,callBack:callBack)
    }
    
    @discardableResult
    
    public class  func show(title:String? = nil,
                            content:String? = nil,
                            showConfig: SPShowConfig? = nil,
                            buttonTitles:[String]? = nil,
                            callBack: ((_ index: Int) -> Void)? = nil) -> SPShowView{
        SPShowView(title: title, content: content, showConfig: showConfig, buttonTitles: buttonTitles,callBack:callBack)
    }
    
    convenience init(title:String? = nil,
                     content:String? = nil,
                     contentView:UIView? = nil,
                     showConfig: SPShowConfig? = nil,
                     buttonTitles:[String]? = nil,
                     callBack: ((_ index: Int) -> Void)? = nil) {
        self.init(frame: UIScreen.main.bounds)
        self.btnClickCallBack = callBack
        setupSubViews(title: title, content: content,customView: contentView, showConfig: showConfig, buttonTitles: buttonTitles)
    }
    
    func commonConfig(){

        config.showAnimateType = .center
    }
    
    
    func setupSubViews(title:String? = nil,
                       content:String? = nil,
                       customView:UIView? = nil,
                       showConfig: SPShowConfig? = nil,
                       buttonTitles:[String]? = nil){
        
        print("SPShowView  setupSubViews",self)
        if let config = showConfig{
            self.config = config
        }else{
            commonConfig()
        }
        // 初始化子视图
        self.backgroundColor = config.backgroundColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        self.addGestureRecognizer(tap)
        
        if let ctView = customView {
            contentView = ctView
            addSubview(contentView)
            isCustomView = true
            contentSize = ctView.bounds.size
        }else{
            isCustomView = false
            contentView = {
                let view = UIView(frame: CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: 200))
                view.backgroundColor = UIColor.white
                view.layer.masksToBounds = true
                addSubview(view)
                return view
            }()
        }
        showAnimate()
        if isCustomView{
            switch config.showAnimateType {
            case .bottom:
                contentView.snp.makeConstraints { (make) in
                    make.bottom.equalTo(self.snp.bottom).offset(contentSize.height)
                    make.centerX.equalToSuperview()
                    make.size.equalTo(contentSize)
                }
            case .center:
                contentView.snp.makeConstraints { (make) in
                    make.center.equalToSuperview()
                    make.size.equalTo(contentSize)
                }
                contentView?.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
            default:
                break
            }
            self.layoutIfNeeded()
            UIView.animate(withDuration: config.animateDuration) {
                switch self.config.showAnimateType {
                case .bottom:
                    
                    self.contentView.snp.updateConstraints {$0.right.equalToSuperview()}
                case .center:
                    self.contentView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
                default:
                    break
                }
            }
            
        }else {
            
            self.contentView.snp.makeConstraints{
                $0.center.equalToSuperview()
                $0.width.equalTo(config.maxWidth)
                $0.height.lessThanOrEqualTo(config.maxHeight)
            }
            var titleLabel:UILabel?
            var contentLabel:UILabel?
            if let title = title,title.count > 0 {
                let _:UILabel = {
                    let label = UILabel()
                    label.textColor = config.titleColor
                    label.font = config.titleFont
                    label.numberOfLines = 0
                    label.text = title
                    label.textAlignment = .center
                    contentView.addSubview(label)
                    titleLabel = label
                    return label
                }()
                titleLabel?.snp.makeConstraints{
                    $0.left.right.equalToSuperview()
                    $0.top.equalToSuperview().offset(config.titleTopSpacing)
                }
            }
    
            let scrollView  = UIScrollView()
            if let content = content,content.count > 0  {
                contentView.addSubview(scrollView)
                scrollView.backgroundColor = UIColor.orange
                let conentSize = content.caculateTextSize(text: content, font: config.contentFont, maxWidth: config.maxWidth - config.contentLeftSpacing * 2)
                
                let otherTotalHeight: CGFloat  = (config.titleTopSpacing + config.contentTopSpacing + config.buttonTopSpacing) + config.bottomSpacing + (title?.count ?? 0 > 0 ? 20 : 0) + config.buttonHeight
                print("conentSize====",conentSize.width,conentSize.height,otherTotalHeight)
                
                var contentTotalHeight =  conentSize.height
                if  conentSize.height > (config.maxHeight - otherTotalHeight) {
                    contentTotalHeight = config.maxHeight - otherTotalHeight
                    scrollView.isScrollEnabled = true
                    scrollView.contentSize = CGSize(width:0, height:conentSize.height)
                }else{
                    scrollView.isScrollEnabled = false
                }
                
                scrollView.snp.makeConstraints{
                    if let title = title,title.count > 0 {
                        $0.top.equalTo(titleLabel!.snp.bottom).offset(config.contentTopSpacing)
                    }else{
                        $0.top.equalToSuperview().offset(config.contentTopSpacing)
                    }
                    $0.left.equalToSuperview().offset(config.contentLeftSpacing)
                    $0.right.equalToSuperview().offset(-config.contentLeftSpacing)
                    $0.height.equalTo(contentTotalHeight)
                }
                let _:UILabel = {
                    let label = UILabel()
                    label.textColor = config.contentColor
                    label.font = config.contentFont
                    label.text = content
                    label.numberOfLines = 0
                    label.textAlignment = .center
                    scrollView.addSubview(label)
                    contentLabel = label
                    return label
                }()
                contentLabel?.snp.makeConstraints{
                    $0.top.left.width.bottom.equalTo(scrollView)
                }
            }
            guard let buttonTitles = buttonTitles else {
                contentLabel?.snp.makeConstraints{
                    $0.bottom.equalToSuperview().offset(-config.bottomSpacing)
                }
                return
            }
            
            let buttonStackView: UIStackView = {
                let stackView = UIStackView()
                stackView.spacing = config.buttonSpacing
                stackView.distribution = .fillEqually
                contentView.addSubview(stackView)
                return stackView
            }()
            buttonStackView.snp.makeConstraints { (make) in
                
                if let content = content,content.count > 0  {
                    make.top.equalTo(scrollView.snp.bottom).offset(config.buttonTopSpacing)
                }else{
                    make.top.equalTo(titleLabel!.snp.bottom).offset(config.buttonTopSpacing)
                }
                make.left.equalToSuperview().offset(config.leftBtnSpacing)
                make.right.equalToSuperview().offset(-config.rightBtnSpacing)
                make.height.equalTo(config.buttonHeight)
                make.bottom.equalToSuperview().offset(-config.bottomSpacing)
            }
            if buttonTitles.count > 0 {
                
                for (i,element) in buttonTitles.enumerated() {
                    let btn = UIButton()
                    btn.tag = i
                    btn.setTitle(element, for: .normal)
                    buttonStackView.addArrangedSubview(btn)
                    btn.addTarget(self, action: #selector(btnOnClick(sender:)), for: .touchUpInside)
                    if buttonTitles.count == 1 {
                        btn.setTitleColor(config.rightBtnTitleColor, for: .normal)
                    }else{
                        btn.setTitleColor(i == 0 ? config.leftBtnTitleColor : config.rightBtnTitleColor, for: .normal)
                    }
                    btn.titleLabel?.font = config.buttonFont
                    if i != buttonTitles.count - 1  {
                        let lineView = UIView()
                        btn.addSubview(lineView)
                        lineView.backgroundColor = config.lineColor
                        lineView.snp.makeConstraints{
                            $0.top.bottom.equalToSuperview()
                            $0.width.equalTo(config.lineHeight)
                            $0.right.equalTo(-0.5)
                        }
                    }
                }
                if config.lineHeight > 0{
                    let lineView = UIView()
                    lineView.backgroundColor = config.lineColor
                    buttonStackView.addSubview(lineView)
                    lineView.snp.makeConstraints{
                        $0.left.right.equalToSuperview()
                        $0.height.equalTo(config.lineHeight)
                        $0.top.equalToSuperview()
                    }
                }
                if config.cornerRadius > 0 {
                    contentView.layer.cornerRadius = config.cornerRadius
                    contentView.layer.masksToBounds = true
                }

                if config.buttonRadius > 0 {
                    self.viewWithTag(0)?.layer.cornerRadius = config.buttonRadius
                    self.viewWithTag(0)?.layer.masksToBounds = true
                    self.viewWithTag(1)?.layer.cornerRadius = config.buttonRadius
                    self.viewWithTag(1)?.layer.masksToBounds = true
                }
                
                if config.leftBtnBorderWidth > 0 {
                    self.viewWithTag(0)?.layer.borderWidth = config.leftBtnBorderWidth
                    self.viewWithTag(0)?.layer.borderColor = config.leftBtnBorderColor.cgColor
                }
                if config.rightBtnBorderWidth > 0 {
                    self.viewWithTag(1)?.layer.borderWidth = config.rightBtnBorderWidth
                    self.viewWithTag(1)?.layer.borderColor = config.rightBtnBorderColor.cgColor
                }
            }
        }
        
    }
    @objc func btnOnClick(sender:UIButton){
        self.btnClickCallBack?(sender.tag)
        self.dismiss()
    }
    
    public func showAnimate(){
        
        if isAnimating { return }
        let containerView = UIApplication.shared.keyWindow!
        
        var flag = false

            for view in containerView.subviews where view.isKind(of: SPShowView.self) {
                   flag = true
                   break
            }
        
        if !flag{
            containerView.addSubview(self)
        }
        
        
        switch self.config.showAnimateType {
        case .bottom:
            UIView.animate(withDuration: 0.25) {
                var frame = self.contentView.frame
                frame.origin.y = kScreenHeight - (frame.size.height) - kSafeAreaBottom
                self.contentView.frame = frame
            }
            break
        default:
            break
        }
        
    }
    @objc func dismiss(){
        self.tag = 0
        remove(animated: true, completion: nil)
    }
    
    public  func remove(animated: Bool, completion: (()->())?){
        if isAnimating {return}
        isAnimating = true
        
        if !isCustomView{
            UIView.animate(withDuration: self.config.animateDuration) {
                self.removeFromSuperview()
                completion?()
                self.isAnimating = false
            }
            return
        }
        switch config.showAnimateType {
        case .bottom:
            contentView.snp.updateConstraints { (make) in
                make.bottom.equalTo(self.snp.bottom).offset(contentSize.height)
            }
        case .center:
            contentView.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
            return
        default:
            break
        }
        UIView.animate(withDuration: config.animateDuration, animations: {
            self.layoutIfNeeded()
            self.removeFromSuperview()
            completion?()
            self.isAnimating = false
        }) { (finished) in
            
        }
    }
    deinit{
        print("SPShowView  deinit",self)
    }
    
}
