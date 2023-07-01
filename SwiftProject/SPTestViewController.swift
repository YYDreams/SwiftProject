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
class SPSwiftModel:NSObject{
    var currnetIndex = 0
}
class SPTestViewController: BaseTableViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    
    
    func fetchWeatherHistory(completion: @escaping ([Double]) -> Void) {
        // 用随机值来取代网络请求返回的数据
        DispatchQueue.global().async {
            let results = (1...100_000).map { _ in Double.random(in: -10...30) }
            completion(results)
        }
    }

    func calculateAverageTemperature(for records: [Double], completion: @escaping (Double) -> Void) {
        // 先求和再计算平均值
        DispatchQueue.global().async {
            let total = records.reduce(0, +)
            let average = total / Double(records.count)
            completion(average)
        }
    }

    func upload(result: Double, completion: @escaping (String) -> Void) {
        // 省略上传的网络请求代码，均返回"OK"
        DispatchQueue.global().async {
            completion("OK")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.propertys.dataArr.append("怎么回事")
//        SPUserDefaluts.setObjects(key: "123", value: self.propertys.dataArr)
        if let t =  SPUserDefaluts.getObjects(key: "123") as? [String]{
            t.forEach { item in
            SPPrint.print("viewWillAppear==\(item)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        SPUserDefaluts.setObjects(key: "123", value: self.propertys.dataArr)
        //
        let vc  =  BaseWebViewController()
        vc.params.requestUrl = "https://v.ixigua.com/AfmmcvB/"
        self.navigationController?.pushViewController(vc, animated: true)
        
        SPPrint.print("哈哈哈哈哈哈哈哈")
        let g: CGFloat = 13.2
        SPPrint.print(g)
        let d: Double = 122.33
        SPPrint.print(d)
        
        fetchWeatherHistory { [weak self] records in
            self?.calculateAverageTemperature(for: records) { average in
                self?.upload(result: average) { response in
                    print("Server response: \(response)")
                }
            }
        }
        
        
        
        
        var arr = ["a","d","c","b","f","e"];

//        arr.sort { obj1, obj2 in
//            return obj1 > obj2
//        }
        
        var array = [SPSwiftModel]()
        let model = SPSwiftModel()
        model.currnetIndex = 3
        array.append(model)
        
        let model1 = SPSwiftModel()
        model1.currnetIndex = 1;
        array.append(model1)

        
        let  model2 = SPSwiftModel()
        model2.currnetIndex = 2
        array.append(model2)
        
    
        array.sort(by: {$0.currnetIndex > $1.currnetIndex})
        print("arr------Swift\(arr)")
//        [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//               return [(NSString *)obj1 compare:(NSString *)obj2];
//           }];
//
//        NSLog(@"%@",arr);
        
      
        return
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
                
                SPShowView.show(title: "-------", buttonTitles: ["取消","去绑卡"]) { index in
                    
                    
                }
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



