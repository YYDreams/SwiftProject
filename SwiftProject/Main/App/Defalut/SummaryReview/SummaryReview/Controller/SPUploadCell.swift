//
//  SPUploadCell.swift
//  SwiftProject
//
//  Created by flower on 2024/5/31.
//

import Foundation
import SnapKit
import Kingfisher
class SPUploadCell: UICollectionViewCell{
    public var stateBtnBlock:((_ isSelect: Bool)->Void)?
    lazy var bgImgView: UIImageView = {
        var tempImgView = UIImageView()
        return tempImgView
    }()
    lazy var maskBgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexInt: 0x000000, alpha: 0.4)
        return view
    }()
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = UIColor.white
        progressView.trackTintColor = UIColor(hex: "#FFFFFF", alpha: 0.5)
        progressView.layer.masksToBounds = true
        progressView.layer.cornerRadius = 2
        return progressView
    }()
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#FFFFFF")
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()

    
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews(){
        contentView.addSubview(bgImgView)
        contentView.addSubview(maskBgView)
        contentView.addSubview(progressView)
        contentView.addSubview(progressLabel)
        
    }
    
    func setupConstraints(){
        
        bgImgView.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.height.equalTo(90)
            $0.width.equalTo(self.bgImgView.snp.height).multipliedBy(1)
        }
        maskBgView.snp.makeConstraints{
            $0.edges.equalTo(bgImgView)
        }
        progressView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(4)
            $0.centerY.equalToSuperview()
        }
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(self.progressView.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
        
    }
  
    func refreshUI(_ model: SPUploadModel?){
        let progress = model?.progress ?? 0
//        if let url = model?.url,model?.uploadType == .image{
//            bgImgView.kf.setImage(with: URL(string: url))
//        }else{
//            
//        }
        bgImgView.image = model?.image
        progressView.setProgress(Float(progress), animated: false)
        if !progress.isNaN && !progress.isInfinite {
            progressLabel.text = "\(Int(progress * 100))%"
        }
        maskBgView.isHidden = progress >= 1
        progressView.isHidden = progress >= 1
        progressLabel.isHidden = progress >= 1
        print("--222-3--\(progress) \(model?.localFileId) \(maskBgView.isHidden)")
    }
    
    
}
