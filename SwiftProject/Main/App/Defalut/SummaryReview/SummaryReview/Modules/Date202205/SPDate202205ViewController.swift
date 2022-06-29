//
//  SPDate202205ViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/6/17.
//

import Foundation
import UIKit
// MARK: ------------------------- Const/Enum/Struct

extension SPDate202205ViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Propertys {}
    
    /// 外部参数
    struct Params {
        var type:SPInfoType = .none
    }
    
}

class SPDate202205ViewController: BaseUIViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    var imgView: UIImageView!
    
    lazy var rotationAnim: CABasicAnimation = {
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.fromValue = Double.pi * 2
        rotationAnim.toValue = 0
        rotationAnim.duration = 10
        rotationAnim.isCumulative = true
        rotationAnim.repeatCount = 100000
        // 这个属性很重要 如果不设置当页面运行到后台再次进入该页面的时候 动画会停止
        rotationAnim.isRemovedOnCompletion = false
        return rotationAnim
    }()
    // MARK: ------------------------- CycLife
    convenience init(type: SPInfoType) {
        self.init()
        self.params.type = type
        printLog("type===\(type)")
        
    }
    /*
     case  base64 =  "Base64字符与图片之间的转换"
     case saveScreenshot = "保存截图"
     case qrCode = "二维码生成"
     case imgViewRoe = "图片旋转"
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        
        
        switch self.params.type {
        case .base64:
            printLog("1")
        case .saveScreenshot:
            saveScreenShot()
        case .qrCode:
            printLog("3")
        case .imgViewRoe:
            imgViewRo()
        default:
            break
        }
    }

    func saveScreenShot(){
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.red
        bgView.frame = CGRect(x: (kScreenWidth - 200) * 0.5, y: kNavBarHeight, width: 200, height: 300)
        self.view.addSubview(bgView)
   
      let tempImage =   bgView.screenShot(size: bgView.size)
        guard let haveImage = tempImage else {
            showHudText("获取图片异常")
            return
        }
        
        SPAlbumManager.checkPhotoAuthState { isAuth in
            if isAuth {
                SPAlbumManager.saveImageToAlbum(image: haveImage){ [weak self]finish in
                    self?.showHudText(finish ? "保存成功" : "保存失败")
                }
            }
        }
    }
    @objc func btnOnClick(btn:UIButton){
        
        if btn.tag == 0 {
            imgView.layer.add(rotationAnim, forKey: "kLightImage")
        }else{
            imgView.layer.removeAnimation(forKey: "kLightImage")
        }

    }
    func imgViewRo(){
        
        let stackView:UIStackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        view.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.width.equalTo(200)
            $0.top.equalTo(100)
            $0.height.equalTo(48)
            $0.centerX.equalToSuperview()
        }

        for (i, element) in ["开始","暂停"].enumerated() {
            let btn = UIButton()
            btn.setTitle(element, for: .normal)
            btn.backgroundColor = UIColor.randomColor
            btn.tag = i
            btn.addTarget(self, action: #selector(btnOnClick(btn:)), for: .touchUpInside)
            stackView.addArrangedSubview(btn)
        }

        imgView = UIImageView()
        imgView.image = UIImage(named: "home_shop_pop_light")
        view.addSubview(imgView)
        imgView.snp.makeConstraints{
            $0.centerY.centerX.equalToSuperview()
        }
        imgView.layer.add(rotationAnim, forKey: "kLightImage")
   
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
}
