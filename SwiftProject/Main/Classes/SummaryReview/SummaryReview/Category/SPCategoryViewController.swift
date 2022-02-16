//
//  SPCategoryViewController.swift
//  SPSummaryReviewUI
//
//  Created by flowerflower on 2022/2/11.
//

import Foundation

import HandyJSON
import SnapKit

public  enum ResourseResType: Int,HandyJSONEnum {
    /// 图文
    case document =  1
    /// 视频
    case video  = 3
    /// 音频
    case audio  = 2
    /// 大专栏
    case bigColumn = 8
    /// 直播
    case live = 4
    /// 专栏
    case column  = 6
    /// 会员
    case member   = 5
    /// 训练营
    case camp  = 25
    /// 班课
    case bclass = 35
    
    public var resourceTypeText:String{
        var text = ""
        switch self {
        case .column:
            text = "专栏"
        case .member:
            text = "会员"
        case .camp:
            text = "训练营"
        case .document:
            text = "图文"
        case .video:
            text = "视频"
        case .audio:
            text = "音频"
        case .bigColumn:
            text = "大专栏"
        case .live:
            text = "直播"
        case .bclass:
            text = "班课"
        default:
            break
        }
        return text
    }
}

// MARK: ------------------------- Const/Enum/Struct

extension SPCategoryViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Propertys {
        
        var resourseResType : ResourseResType = .document
        
        var leftList:[ResourseResType] = [.document,.audio,.video,.live,.column,.member,.bigColumn,.bclass]
        
        var currentInx: IndexPath = IndexPath(row: 0, section: 0)
        
    }
    
    /// 外部参数
    struct Params {}
    
}

class SPCategoryViewController: BaseUIViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    public lazy var leftTableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero, style: .plain)
        tableView.registerCell(ofType: UITableViewCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hexInt: 0xF5F5F5)
        tableView.rowHeight = 48
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    public lazy var rightTableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero, style: .plain)
        tableView.registerCell(ofType: UITableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubView()
        loadData()
    }
    
    func setupSubView() {
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        
        leftTableView.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(88)
            $0.top.equalTo(kNavBarHeight)
        }
        
        rightTableView.snp.makeConstraints{
            $0.left.equalTo(self.leftTableView.snp.right).offset(16)
            $0.bottom.equalTo(-kSafeAreaBottom)
            $0.right.equalToSuperview()
            $0.top.equalTo(leftTableView)
        }
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    func setupMaskLayer(cell: UITableViewCell,byRoundingCorners:UIRectCorner,cornerRadii:CGSize){
        let frame =  CGRect(x: 0, y: 0, width: 88, height: 48)
        cell.contentView.layer.masksToBounds = true
        let maskPath  = UIBezierPath(roundedRect: frame, byRoundingCorners: byRoundingCorners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = frame
        maskLayer.path = maskPath.cgPath
        cell.contentView.layer.mask = maskLayer
        
    }
    
    func loadData(){
        
    }
    
}
// MARK: ------------------------- UITableViewDelegate,UITableViewDataSource
extension SPCategoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   tableView == leftTableView ?   self.propertys.leftList.count :  20
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == leftTableView {
            let type =  self.propertys.leftList[indexPath.row]
            let cell = tableView.cell(ofType: UITableViewCell.self)
            if indexPath.row - 1 == self.propertys.currentInx.row  { // 右下
                setupMaskLayer(cell: cell, byRoundingCorners: [.topRight], cornerRadii: CGSize(width: 8, height: 8))
            }else if indexPath.row + 1 ==  self.propertys.currentInx.row{  //右上
                setupMaskLayer(cell: cell, byRoundingCorners: [.bottomRight], cornerRadii: CGSize(width: 8, height: 8))
            }else{  //
                setupMaskLayer(cell: cell, byRoundingCorners: [.topRight,.bottomRight], cornerRadii: CGSize(width: 0, height: 0))
            }
            
            if indexPath.row == self.propertys.currentInx.row {
                cell.contentView.backgroundColor = UIColor.white
                cell.textLabel?.textColor = UIColor.red
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
                
            }else{
                cell.contentView.backgroundColor = UIColor(hexInt: 0xF5F5F5)
                cell.textLabel?.textColor = UIColor(hexInt:0x333333)
                cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
                
            }
            cell.textLabel?.text = type.resourceTypeText
            return cell
        }
        let cell = tableView.cell(ofType: UITableViewCell.self)
        cell.textLabel?.text = "\(self.propertys.resourseResType.resourceTypeText) to be number one \(indexPath.row)"
        
        return cell
        
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.leftTableView {
            self.propertys.currentInx = indexPath
            self.propertys.resourseResType = self.propertys.leftList[indexPath.row]
            tableView.reloadData()
            self.rightTableView.reloadData()
        }
    }
}
