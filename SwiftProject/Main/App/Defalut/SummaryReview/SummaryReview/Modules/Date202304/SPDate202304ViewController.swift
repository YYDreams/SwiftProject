//
//  SPDate202304ViewController.swift
//  SwiftProject
//
//  Created by flower on 2023/5/6.
//

import Foundation
// MARK: ------------------------- Const/Enum/Struct
extension SPDate202304ViewController {
    /// 常量
    struct Const {
      
    }
    /// 内部属性
    struct Propertys {
        var dataArr = [SPDate202304Model]()
    }

    /// 外部参数
    struct Params {
        
    }
}

/*
 需求:
 右面的文案始终跟在左边文案的后面,如果左边的文案文案很长,则显示...,而右边的文案始终要完整的显示
 */

class SPDate202304ViewController: BaseUIViewController {
    
    // MARK: ------------------------- Propertys
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    public lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero, style: .plain)
        tableView.registerCell(ofType: SPDate202304Cell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(hexInt: 0xF5F5F5)
        tableView.rowHeight = 48
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupData()
        
    }
    func setupSubViews(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.top.equalTo(kNavBarHeight)
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
    func setupData(){
        let titleArr = ["交通订票量的增长被视为衡量经济活力的重要指标之一","今年的“五一”假期","每逢春暖花开之时，松花湖不再封冻","热门城市酒店预订量超疫情前1.9倍，连住天数增长20%。","鲜美的鱼类"]
        for i in titleArr {
            let model = SPDate202304Model()
            model.title = i
            self.propertys.dataArr.append(model)
        }
    }
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
}

extension SPDate202304ViewController: UITableViewDelegate,UITableViewDataSource{
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          self.propertys.dataArr.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.cell(ofType: SPDate202304Cell.self)
         cell.refreshUI(model: self.propertys.dataArr[indexPath.row])
        return cell
    }
}
class SPDate202304Model: SPBaseModel{
    
    var isShow: Int?
    
    var title: String?
        
}

class SPDate202304Cell : UITableViewCell {
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cellContainView: UIView = {
        let cellContainView = UIView()
        cellContainView.backgroundColor = UIColor(hexString: "#FAFAFA")
        return cellContainView
    }()

    
    lazy var leftLabel: UILabel = {
        let elblShopName = UILabel()
        elblShopName.font = .systemFont(ofSize: 14, weight: .medium)
        elblShopName.textColor = UIColor(hexString: "#333333")
        elblShopName.numberOfLines = 1
        return elblShopName
    }()
    
    
    lazy var rightLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.font = .systemFont(ofSize: 14, weight: .medium)
        tagLabel.textColor = UIColor(hexString: "#B2B2B2")
        tagLabel.text = "已售罄"
        return tagLabel
    }()

    //设置布局
    func setupSubView(){
        contentView.addSubview(cellContainView)
        cellContainView.addSubview(leftLabel)
        cellContainView.addSubview(rightLabel)

        cellContainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }


        leftLabel.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.left.equalTo(16)
            make.right.equalTo(rightLabel.snp.left).offset(-4)
        }
        
        rightLabel.snp.makeConstraints { make in
            make.top.equalTo(leftLabel)
            make.right.lessThanOrEqualTo(-16)
            make.left.equalTo(leftLabel.snp.right)
        }

        

    }
    
    //刷新数据
    func refreshUI(model: SPDate202304Model?) {
     
            
        leftLabel.text = model?.title
       
            if(model?.isShow == 1){
                rightLabel.isHidden = true
            }else{
                rightLabel.isHidden = false
            }
            
            if rightLabel.isHidden {
                leftLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                leftLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
            }else{
                rightLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                rightLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
                
                leftLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
                leftLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            }
            
    
        
    }
}

