//
//  SPSummaryReviewViewController.swift
//  SPSummaryReviewUI
//
//  Created by flowerflower on 2022/1/15.
//

import UIKit


// MARK: ------------------------- Const/Enum/Struct
enum  SPSectionType:Int {
    
    case date202204
    
    case date202205
    
    case date202206
    
    case date202207
    
    case date202304
    
    public var typeString: String{
        switch self {
        case .date202204:
            return "2021年04月复盘篇"
        case .date202205:
            return "2022年05月复盘篇"
        case .date202206:
            return "2022年06月复盘篇"
        case .date202207:
            return "2022年07月复盘篇"
        case .date202304:
            return "2023年04月复盘篇"
        }
    }
}

enum  SPInfoType:String {
    case none = ""
    // 4月
    case richText = "富文本编辑器"
    case customTime = "自定义时间选择器"
    case libJXSegmentedViewDemo = "使用JXSegmentedView导致页面卡顿问题"
    case category = "分类圆弧"
    // 5月
    case  base64 =  "Base64字符与图片之间的转换"
    case saveScreenshot = "保存截图"
    case qrCode = "二维码生成"
    case imgViewRoe = "图片旋转"
    // 6月
    case webViewCookies = "原生js、css注入cookie"
    case libWebViewCookies = "第三方GGWKCookie注入js、css注入cookie"
    // 7月
    case scan = "扫一扫功能，以及从相册识别二维码和条形码"
    
    // 10月 ipad分屏

    case sp202304 = "2023年04月"


}
extension SPSummaryReviewViewController {
    
    /// 常量
    struct Const {
        static let tableHeaderViewHeight:CGFloat = 40
    }
    
    /// 内部属性
    struct Propertys {
        var localData:[SPSectionType:[SPInfoType]] = [
            .date202204: [.richText, .customTime, .libJXSegmentedViewDemo,.category],
            .date202205: [.base64, .saveScreenshot, .qrCode,.imgViewRoe],
            .date202206: [.webViewCookies,.libWebViewCookies,],
            .date202207: [.scan],
            .date202304: [.sp202304]
        ]
    }
    
    /// 外部参数
    struct Params {}
}

class SPSummaryReviewViewController: BaseTableViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    var calendarView = DDMonthCalendarView()
    // MARK: ------------------------- CycLife
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.snp.updateConstraints{
            $0.bottom.equalTo(-kTabBarHeight)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(refreshData))
    }
    @objc func injected(){
        
//        calendarView.removeFromSuperview()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.addSubview(self.calendarView)
        calendarView.selectDateBlock = { [weak self ] (date) in
            SPPrint.print("date==\(date)")
        }
            self.calendarView.snp.makeConstraints{
                $0.edges.equalToSuperview()
//                $0.left.equalTo(22)
//                $0.height.equalTo(350)
//                $0.center.equalToSuperview()
            }
            print("xxxx==========")
            self.view.backgroundColor = UIColor.red
//            self.calendarView.backgroundColor = UIColor.orange
//        }
  
    }
    
    @objc func refreshData(){
        injected()
        
        
        
//        navigationController?.pushViewController(SPSearchHistoryViewController(), animated: true)
//        tableView.reloadData()
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.propertys.localData.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let type = SPSectionType(rawValue: section) else {return 0 }
        return self.propertys.localData[type]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(ofType: UITableViewCell.self)
        cell.selectionStyle = .none
        guard let type = SPSectionType(rawValue: indexPath.section) else {  return UITableViewCell()}
        cell.textLabel?.text = self.propertys.localData[type]?[safe:indexPath.row]?.rawValue
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame:  CGRect(x: 0, y: 0, width: kScreenWidth, height: Const.tableHeaderViewHeight))
        let headerTitleLabel = UILabel()
        headerTitleLabel.textAlignment = .left
        headerView.backgroundColor = kBgColor
        headerTitleLabel.textColor = UIColor.black
        guard let type = SPSectionType(rawValue: section)else {return UIView()}
        headerTitleLabel.text = type.typeString
        headerView.addSubview(headerTitleLabel)
        headerTitleLabel.frame = CGRect(x: 12, y: 0, width: kScreenWidth, height: Const.tableHeaderViewHeight)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Const.tableHeaderViewHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sectionType = SPSectionType(rawValue: indexPath.section) else {  return}
        let infoType = self.propertys.localData[sectionType]?[safe: indexPath.row]
        switch infoType {
        case .richText:
               print("富文本")

        case .customTime:
            print("日期")
        case .libJXSegmentedViewDemo:
            print("xxxxx")
        case .category:
            self.navigationController?.pushViewController(SPCategoryViewController(), animated: true)
            
        case  .base64,.saveScreenshot,.qrCode,.imgViewRoe:
            self.navigationController?.pushViewController(SPDate202205ViewController(type: infoType ?? .none), animated: true)
        case .webViewCookies:
            let vc  =  BaseWebViewController()
            vc.params.requestUrl = "https://admin-mobile.xiaoeknow.com/v1/adminMobile/businessWeekly/businessWeeklyList"
            self.navigationController?.pushViewController(vc, animated: true)
        case .libWebViewCookies:
           let webView =  SPDate202206ViewController()
            webView.params.appId = "appptaa4nql6484"
            webView.params.url = "https://admin-mobile.xiaoeknow.com/v1/adminMobile/businessWeekly/businessWeeklyList"
            self.navigationController?.pushViewController(webView, animated: true)
        case.sp202304:
            self.navigationController?.pushViewController(SPDate202304ViewController(), animated: true)
        default:
            break
        }
    }
}
