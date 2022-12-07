//
//  SPAudioViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/12/5.
//

import Foundation
// MARK: ------------------------- Const/Enum/Struct

extension SPAudioViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Porpertys {}
    
    /// 外部参数
    struct Params {}
    
}

class SPAudioViewController: BaseUIViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        setupSubViews()
        handerEvents()
        
    }
    func setupSubViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            $0.height.greaterThanOrEqualTo(view.snp.height)
            $0.width.equalTo(view.snp.width)
        }
    }
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
    lazy var contentView: SPAudioPlayerView = {
        let view = SPAudioPlayerView()
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: ------------------------- Events
    func handerEvents(){
        
        contentView.playerOnClickBlock = { [weak self] type  in
            print("--typetypetype---\(type)")
            switch type {
            case .lastclick:// 上一首
                print("上一首")
            case .nextclick:   // 下一首
                print("下一首")
            case .play:        // 播放
                print("播放")
            case .stop:        // 暂停
                print("暂停")
            case .playSort: // 播放顺序
                print("播放顺序")
            case .playTime: // 定时关闭
                print("定时关闭")
            case .speed: //倍速播放
                print("倍速播放")
            case .playList:  //播放列表
                print("播放列表")
            case .back15s:  //后退15秒
                print("后退15秒")
            case .forward15s:  //前进15秒
                print("前进15秒")
            default:
                print("你瞅啥瞅")
            }
            

            
        }
    }
    
    
    
    // MARK: ------------------------- Methods
    
    
}
