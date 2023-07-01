//
//  DDMonthCalendarCell.swift
//  SwiftProject
//
//  Created by flower on 2023/6/23.
//

import Foundation
import JTAppleCalendar
import UIKit
enum DDCalendarPointType {
    case notStart //未开始
    case started //已开始
    case ended //已结束
    case none // 无
    var textColor: UIColor{
        switch self {
        case .notStart: return UIColor("#24ACFF")
        case .started:  return UIColor("#FF2424")
        case .ended:    return UIColor("#666666")
        case .none:    return UIColor("#FFFFFF")
        }
    }
}
class DDMonthCalendarCell: JTACDayCell {

    private lazy var numLabel:XLPaddingLabel = {
        let label = XLPaddingLabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.textInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        label.layer.cornerRadius =  16.5
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var pointLabel:UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        label.layer.cornerRadius = 1.5
        label.layer.masksToBounds = true
        
        return label
    }()
    private var selectedView:UIView = {
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor("#24ACFF")
        return selectedView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        contentView.addSubview(selectedView)
        contentView.addSubview(numLabel)
        contentView.addSubview(pointLabel)
        numLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.centerX.equalToSuperview()
            
        }
        pointLabel.snp.makeConstraints { make in
            make.top.equalTo(numLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(3)
        }
        selectedView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        selectedView.setCornerRadius(16)
   
    }
    
    func refreshUI(cellState: CellState,pointStatus:DDCalendarPointType = .none,isThisMonth: Bool,isToday:Bool) {
        numLabel.text = cellState.text
        print("cellState:\(cellState.text) isSelected:\(cellState.isSelected) isThisMonth:\(isThisMonth) isToday:\(isToday)")
        if cellState.isSelected {
            numLabel.textColor = isThisMonth ? (isToday ? UIColor.white:UIColor("#333333")) : UIColor("#CCCCCC")
            selectedView.isHidden = isThisMonth ? false : true

        }else{
            selectedView.isHidden = true
            numLabel.textColor = isThisMonth ? (isToday ? UIColor(hex: "#24ACFF"):UIColor("#333333")) : UIColor("#CCCCCC")
        }
        pointLabel.backgroundColor = pointStatus.textColor
    }
}
public class XLPaddingLabel: UILabel {

    public var textInsets: UIEdgeInsets = .zero
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = textInsets
        var rect = super.textRect(forBounds: bounds.inset(by: insets),
                                  limitedToNumberOfLines: numberOfLines)
        
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
}
