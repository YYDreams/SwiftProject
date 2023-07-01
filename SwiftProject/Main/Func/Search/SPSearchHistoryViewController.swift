//
//  SPSearchHistoryViewController.swift
//  SwiftProject
//
//  Created by flower on 2023/5/9.
//

import Foundation
import TTGTags
import UIKit
class SPSearchHistoryViewController: UIViewController{
 
    var tagViews = [UIView]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        
    }
    func setupSubViews(){
       let tagCollectionView =  TTGTagCollectionView()
        view.addSubview(tagCollectionView)
        tagCollectionView.snp.makeConstraints{
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.height.equalTo(300)
            $0.top.equalTo(kNavBarHeight)
        }
        tagCollectionView.layoutIfNeeded()
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.numberOfLines = 2

        
        tagCollectionView.backgroundColor = UIColor.orange
        tagViews.append(newButtonTitle(title: "AutoLayout方法急急急急急急急急急急急急急急急急急急急急急叽叽叽叽我饿福娃福娃额发急急急急急急急急急急急急急急叽叽叽叽我饿福娃福娃额发急急急急急急急急急急急急急急叽叽叽叽我饿福娃福娃额发急急急急急急急急急急急急急急叽叽叽叽我饿福娃福娃额发"))
        tagViews.append(newButtonTitle(title: "AutoL娃额发"))
        tagViews.append(newButtonTitle(title: "Au急发"))
        tagViews.append(newButtonTitle(title: "发"))
        tagViews.append(newButtonTitle(title: "就还好发"))
        tagViews.append(newButtonTitle(title: "AutoL娃额发"))
        tagViews.append(newButtonTitle(title: "Au急发"))
        tagViews.append(newButtonTitle(title: "发"))
        tagViews.append(newButtonTitle(title: "就还好发"))
        tagViews.append(newButtonTitle(title: "AutoL娃额发"))
        tagViews.append(newButtonTitle(title: "Au急发"))
        tagViews.append(newButtonTitle(title: "发"))
        tagViews.append(newButtonTitle(title: "就还好发"))
        tagCollectionView.reload()

    }
    func newButtonTitle(title:String) -> UILabel{

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = title
        label.backgroundColor = UIColor.randomColor
        label.sizeToFit()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 4
        expandSizeForView(view: label, extraWidth: 10, extraHeight: 8)
        return label
    }

    func expandSizeForView(view:UIView,extraWidth:CGFloat,extraHeight:CGFloat){
        var frame = view.frame
        frame.size.width += extraWidth
        frame.size.height += extraHeight
        view.frame = frame
    }
   @objc func btnOnClick(sender:UIButton){
       SPPrint.print(sender.titleLabel?.text)
    }
    

}

extension SPSearchHistoryViewController: TTGTagCollectionViewDelegate, TTGTagCollectionViewDataSource{
    
    func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, sizeForTagAt index: UInt) -> CGSize {
        return tagViews[Int(index)].frame.size
    }
    func numberOfTags(in tagCollectionView: TTGTagCollectionView!) -> UInt {
        return UInt(tagViews.count)
    }
    
    func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, tagViewFor index: UInt) -> UIView! {
        return tagViews[Int(index)]
    }
    func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, didSelectTag tagView: UIView!, at index: UInt) {
        SPPrint.print("------\(tagView.classForCoder) \(index)")
    }
}
