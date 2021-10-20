//
//  LearningCenterViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/9.
//

import Foundation
import XMUtil
import SnapKit
class LearningCenterViewController:  BaseUIViewController {
    
    // MARK: ------------------------- Propertys
    
    // MARK: ------------------------- CycLife
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgView = UIImageView(image: UIImage(named: "icon"))
        imgView.frame = self.view.bounds
        self.view.addSubview(imgView)
        setupSubViews()

        
        
    }
    
    func setupSubViews(){
        
        
//        let person  = Person(name: "我是大花花", age: 20)
//        
//        UserDefaults.standard.setCodableObject(person, forKey: "person")


   
//        self.navigationController?.pushViewController(SPAudioDetailViewController(), animated: true)

        
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        let content = UIButton.init(frame: CGRect.init(x: 300, y: 100, width: kScreenWidth, height: 400))
        content.backgroundColor = UIColor.red
//        content.layer.masksToBounds = true
//        content.layer.cornerRadius = 30
//        content.addTarget(self, action: #selector(hideClick), for: .touchUpInside)
        Show.showPopView(contentView: content) { (config) in
            config.showAnimateType = .left
            config.maskType = .color
            config.clickOtherHidden = true
            config.animateDamping = false
            config.cornerRadius = 12
        }
        
  
        
    return
        let getPerson = UserDefaults.standard.getCodableObject(Person.self, with: "person")

        print("\(getPerson?.name)")
        
        print("\(getPerson?.age)")
        
        
        return
     
        self.view.backgroundColor = UIColor.randomColor
        
        self.navigationController?.pushViewController(SPAudioDetailViewController(), animated: true)
    }
    
    
    
    
}

struct Person: Codable {
    let name: String
    let age: Int
}

/**
 虽然UserDefault中的注释已经说明了，它只能保存基本的数据类型：NSString, NSData, NSNumber, NSDate, NSArray, and NSDictionar，
 但是有的时候我就是想保存一个Model数据应该怎么办呢？
 */

extension UserDefaults{
    
    
    public func setCodableObject<T: Codable>(_ object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        
         let data = try? encoder.encode(object)
          set(data, forKey: key)
    }
    
    
    public func getCodableObject<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }
    
}
