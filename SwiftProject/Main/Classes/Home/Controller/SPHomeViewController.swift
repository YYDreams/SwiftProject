//
//  SPHomeViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/10/20.
//

import UIKit
import XMUtil
import SPWidget
// MARK: ------------------------- Const/Enum/Struct

extension SPHomeViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Porpertys {
        var titleArr = [String]()
    }
    
    /// 外部参数
    struct Params {}
    
}


class SPHomeViewController: BaseTableViewController{
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Porpertys = Porpertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubView()
        
    }
    

    func setupSubView(){
   
        self.propertys.titleArr = ["弹框【单个按钮】","弹框【按钮为圆角样式】","弹框【按钮为非圆角样式】"]
        
        kStringIsEmpty(string: "fdfffffffffsdfsfds")
        
    }
    
    
//     func numberOfSections(in tableView: UITableView) -> Int {
//
//        return self.propertys.titleArr.count
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertys.titleArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.cell(ofType: UITableViewCell.self)
        cell.textLabel?.text = propertys.titleArr[safe: indexPath.row]
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            Show.showCustomAlert( attributedMessage:"按照4:3比例平铺展示，小于5M，支持JPG、PNG格式".attributedString(lineSpaceing: 8,textColor: UIColor(hexInt: 0x333333),font: UIFont.systemFont(ofSize: 16)),leftBtnTitle: "我知道了")  {
             } config: { config in
                config.cornerRadius = 8
                config.bottomSpacing = 0
                config.buttonRadius = 8
                config.lineHeight = 0.5
                config.lineColor = UIColor(hexInt: 0xEBEBEB)
                config.leftBtnTitleColor = UIColor(hexInt: 0x1472FF)
                config.leftBtnBorderWidth = 0
                config.leftBtnSpacing =  0
                config.rightBtnSpacing = 0
                config.buttonHeight = 48
                config.messageTopSpacing = 0
             }
         
            return
        }else if indexPath.row == 1{
            Show.showCustomAlert( attributedMessage:"删除后，已购买的用户将无法使用\n(30天内可在操作日志恢复课程)".attributedString(lineSpaceing: 10,font: UIFont.systemFont(ofSize: 16)),leftBtnTitle: "取消",
                                    rightBtnTitle: "删除") {
                 
             } rightBlock: {  [weak self] in
                print("----请求删除----")
             } config: { config in
                config.rightBtnBgColor = UIColor("#FF4747")
                config.cornerRadius = 8
             }
            return
        }
        
        Show.showCustomAlert( attributedMessage:"选择文件，大小不超过2G".attributedString(lineSpaceing: 8,textColor: UIColor(hexInt: 0x333333),font: UIFont.systemFont(ofSize: 16)),leftBtnTitle: "取消",rightBtnTitle: "确定")  {
         } config: { config in
            config.cornerRadius = 8
            config.bottomSpacing = 0
            config.buttonRadius = 8
            config.lineHeight = 0.5
            config.lineColor = UIColor(hexInt: 0xEBEBEB)
            config.leftBtnTitleColor = UIColor.gray
            config.rightBtnBgColor = UIColor.white
            config.rightBtnTitleColor = UIColor.black
            config.leftBtnBorderWidth = 0
            config.leftBtnSpacing =  0
            config.rightBtnBorderWidth = 0
            config.rightBtnSpacing = 0
            config.buttonHeight = 48
            config.messageTopSpacing = 0
         }
    }
    
}
// MARK: ------------------------- String
public extension String{

    
    /// 富文本设置 字体大小 行间距 字间距
    func attributedString(lineSpaceing: CGFloat,textColor:UIColor = .black,font:UIFont = UIFont.systemFont(ofSize: 14)) -> NSAttributedString {
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpaceing
        style.alignment = .center
        let attributes = [NSAttributedString.Key.paragraphStyle : style,
                          NSAttributedString.Key.font:font,
                          NSAttributedString.Key.foregroundColor:textColor] as [NSAttributedString.Key : Any]
        let attrStr = NSMutableAttributedString.init(string: self, attributes: attributes)
        return attrStr
    }

}
