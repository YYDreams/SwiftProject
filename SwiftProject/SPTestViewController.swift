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
    struct Propertys {}
    
    /// 外部参数
    struct Params {}
    
}

class SPTestViewController: UIViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.red
  
//        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(test), userInfo: nil, repeats: true)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(SPTestViewController(), animated: true)

        
        
    }
    
    @objc func injected() {
        #if DEBUG
        
        arrOpation()
//
//        var arr = [10,1,4,20,99]
//        print("arr-----",arr)
//        // 返回true: v1排在v2前面
//        // 返回false: v1排在v2后面
//        //等价
////        arr.sor t { v1, v2 in   return v1 > v2}
//        //        arr.sort(by: {$0 < $1})
//        //        arr.sort(by: >)
//        //        arr.sort{ $0 < $1 }
//
//
////        使用 append() 方法或者赋值运算符 += 在数组末尾添加元素
//        arr.append(100)
//        arr += [400]
//
//        //通过索引修改数组元素的值：
//        arr[0] = 10
//
//        //遍历数组
//        for item in arr {
//           print(item)
//        }
//
//
//        //需要每个数据项的值和索引值，可以使用 String 的 enumerate() 方法来进行数组遍历
//        for (index,item) in arr.enumerated() {
//
//        }
//        let btn = UIButton(type: .contactAdd)
//        btn.backgroundColor = UIColor.orange
//        btn.frame = CGRect(x: 200, y: 200, width: 100, height: 40)
//        btn.addTarget(self, action: #selector(testOnClick), for: .touchUpInside)
//        view.addSubview(btn)
//        //合并数组
//
//        print("arr--11---",arr)

        // 可选性绑定
//        if let
        
        // 只执行一次
//        static
        
        
        
        
        #endif
    }
    
    @objc func  arrOpation(){
        var arr = [[1,2,3,4],[3,4]]
        // map:会返回一个新的数组
//       arr =  arr.map { item in
//            return item + 1
//        }
        
        var arr1 = arr.flatMap { a in
            return a
        }
        // 遍历数组
//        arr.filter(<#T##isIncluded: (Int) throws -> Bool##(Int) throws -> Bool#>)
        // 也会遍历数组
        
        // 方式1
//      var arr1 =  arr.reduce(0) { reslut, element in
//
//            return reslut + element
//        }
//
//        // 方式2
//        // $0上一次遍历返回的结果（初始值是0）
//        // $1每次遍历到的数组元素
//        var arr2 = arr.reduce(0){$0 + $1}
        
        print("arr-----",arr)
        print("arr1-----",arr1)
//        print("arr2-----",arr2)
        

    }
    
   @objc func testOnClick(){
        
        print("Thread.current",Thread.current)
        
    }
    
    
    func exec(v1: Int, v2: Int, fn: (Int,Int) -> Int){

        print(fn(v1 + v2, 3))
        
    }
    
    // $0 最前面的参数
    
    
    
    deinit {
        
        print("I'SPTestViewController   deinit")
    }
    
    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
}



//同时只能有1条数线程可以访问



