//
//  SPHighImitationController.swift
//  SwiftProject
//
//  Created by flower on 2022/6/10.
//

import Foundation
import UIKit
class SPHighImitationController: UIViewController {
     
    var stackView:UIStackView!
  override  func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor
      setupSubViews()
    }
    @objc func injected(){
        
        print("xxxx==========")
        self.view.backgroundColor = UIColor.red
        stackView.removeFromSuperview()
        setupSubViews()
        
    }
    
    func setupSubViews(){
        
        stackView = UIStackView()
        stackView.backgroundColor = UIColor.green
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .top
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.left.equalTo(20)
            $0.right.equalTo(-20)
            $0.top.height.equalTo(100)
            
        }
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let label = createLabel()
        self.navigationController?.pushViewController(XELocalAudioPlayController(), animated: true)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        stackView?.addArrangedSubview(label)
            self.stackView.layoutIfNeeded()
    }
    
    func  createLabel() -> UILabel{
        let label = UILabel()
        label.backgroundColor = UIColor.blue
        label.text = "呵呵哈哈哈"
        return label
    }
    
}

