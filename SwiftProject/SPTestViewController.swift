//
//  SPTestViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/12/17.
//

import UIKit

// MARK: ------------------------- Const/Enum/Struct

extension SPTestViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Propertys {
       var  dataArr = ["单行展示2个按钮","单行单个按钮","只有title没有conent","多文案"]
    }
    
    /// 外部参数
    struct Params {}
    
}

class SPTestViewController: BaseTableViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        for i  in 0...1000 {
            
            print("----",i)
            let view1 = UIView()
            if i == 50{
                self.view.addSubview(UIImageView())
            }
            self.view.addSubview(view1)
        }
        
        self.tableView.registerCell(ofType: UITableViewCell.self)

//        Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true, block: { timer in
//            print("viewDidLoad ===")
//            let c = SPShowConfig()
//            c.isAutoTrigger = true
//            SPShowView.show(title: "领卡失败，请先绑定会籍卡",showConfig: c, buttonTitles: ["取消","去绑卡"]) { index in
//                print("======index",index)
//            }
//        })
//
    }
 
    
    @objc func injected() {
     
        self.tableView.reloadData()

    }
    func test1(){
        let startTime = CFAbsoluteTimeGetCurrent()
        for v in self.view.subviews {
            if v.isKind(of: UIImageView.self) {
                let endTime = CFAbsoluteTimeGetCurrent()
                print("----1代码执行时长毫秒:", (endTime - startTime)*1000)
            }
        }
    }
//    ----1代码执行时长毫秒: 0.07808208465576172
//    ----1代码执行时长毫秒: 0.04601478576660156
//    ----1代码执行时长毫秒: 0.048995018005371094
//    ----1代码执行时长毫秒: 0.04696846008300781
//    ----1代码执行时长毫秒: 0.034928321838378906
//    ----1代码执行时长毫秒: 0.051021575927734375
//    ----1代码执行时长毫秒: 0.031948089599609375
//    ----1代码执行时长毫秒: 0.03504753112792969
//    ----1代码执行时长毫秒: 0.034928321838378906
//    ----1代码执行时长毫秒: 0.03802776336669922
//    ----1代码执行时长毫秒: 0.04792213439941406

    func test2(){
        let startTime = CFAbsoluteTimeGetCurrent()
        for v in self.view.subviews where v.isKind(of: UIImageView.self) {
            let endTime = CFAbsoluteTimeGetCurrent()
            print("----2代码执行时长毫秒:", (endTime - startTime)*1000)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertys.dataArr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.cell(ofType: UITableViewCell.self)
        cell.textLabel?.text = propertys.dataArr[safe: indexPath.row]
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        switch indexPath.row {
        case 0:
     
            test1()
//            SPShowView.show(title: "删除商品",content: "确认从列表中删除所选商品", buttonTitles: ["取消","删除"]) { index in
//                print("======index",index)
//            }
        case 1:
            test2()
//            SPShowView.show(title: "暂不支持退换",content: "取件费已超出订单费，请联系客服", buttonTitles: ["我知道了"]) { index in
//                print("======index",index)
//            }
        case 2:
            SPShowView.show(title: "领卡失败，请先绑定会籍卡", buttonTitles: ["取消","去绑卡"]) { index in
                print("======index",index)
            }
        case 3:

            SPShowView.show(title: "提示",content: "人的事业会遇到瓶颈期，生活也会被各种鸡毛蒜皮小事烦扰，就需要清理自己，极致坦诚的告诉自己内心真实的想法，提出问题解决问题。人的事业会遇到瓶颈期，生活也会被各种鸡毛蒜皮小事烦扰，就需要清理自己，极致坦诚的告诉自己内心真实的想法，提出问题解决问题。是因为努力可以变得更好，成为更好的自己，而当你变成更好的自己的时候，也会认识到更多优秀的人，成为同行的人，从而激励和帮助自己变得更好。每个人对成功和满足感的定义都不同，你只要把握好自己的节奏即可。我们都一样，年幼时渴望长大，长大后却会彷徨。“这本书将讲述青春里的你我都曾经历的故事，或许每个人的青春都有一张相似的脸，它写满困惑，也可爱至极——渴望被爱，却畏惧表达；向往自由，却有勇无谋；偏爱某人，却负气离开；听过那么多道理，还是任性而为，明知前路多艰，还要逆流直上，后悔错过良辰美景无数，却依然坚持特立独行。我一直不信这个世界有什么一夜成名的神话，在外人只看结果的环境下，没有人在意你努力了多少年，因为在你默默无闻时没有人关心你是谁，只有当你有所收获时才能拿着结果去证实自己的能力。", buttonTitles: ["取消","去绑卡"]) { index in
                print("======index",index)
            }
        case 4:
            SPShowView.show(content: "人的事业会遇到瓶颈期，生活也会被各种鸡毛蒜皮小事烦扰，就需要清理自己，极致坦诚的告诉自己内心真实的想法，提出问题解决问题。人的事业会遇到瓶颈期，生活也会被各种鸡毛蒜皮小事烦扰，就需要清理自己，极致坦诚的告诉自己内心真实的想法，提出问题解决问题。是因为努力可以变得更好，成为更好的自己，而当你变成更好的自己的时候，也会认识到更多优秀的人，成为同行的人，从而激励和帮助自己变得更好。每个人对成功和满足感的定义都不同，你只要把握好自己的节奏即可。我们都一样，年幼时渴望长大，长大后却会彷徨。“这本书将讲述青春里的你我都曾经历的故事，或许每个人的青春都有一张相似的脸，它写满困惑，也可爱至极——渴望被爱，却畏惧表达；向往自由，却有勇无谋；偏爱某人，却负气离开；听过那么多道理，还是任性而为，明知前路多艰，还要逆流直上，后悔错过良辰美景无数，却依然坚持特立独行。我一直不信这个世界有什么一夜成名的神话，在外人只看结果的环境下，没有人在意你努力了多少年，因为在你默默无闻时没有人关心你是谁，只有当你有所收获时才能拿着结果去证实自己的能力。", buttonTitles: ["取消","去绑卡"]) { index in
                print("======index",index)
            }
            
            
        default:
            break
        }
        
    }
    
    deinit {
        
        print("I'SPTestViewController   deinit")
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
}



