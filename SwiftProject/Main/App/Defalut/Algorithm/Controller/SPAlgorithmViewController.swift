//
//  SPAlgorithmViewController.swift
//  SwiftProject
//
//  Created by flowerflower on 2021/11/23.
//

import Foundation
import UIKit
import SwiftUI
// MARK: ------------------------- Const/Enum/Struct

extension SPAlgorithmViewController {
    
    /// 常量
    struct Const {}
    
    /// 内部属性
    struct Propertys {
        var array: [Int] = [2,5,3,1,4,8,10,7,6,9]
    }
    
    /// 外部参数
    struct Params {}
    
}

class SPAlgorithmViewController: UIViewController {
    
    // MARK: ------------------------- Propertys
    
    /// 内部属性
    var propertys: Propertys = Propertys()
    /// 外部参数
    var params: Params = Params()
    
    // MARK: ------------------------- CycLife
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let btn = UIButton()
        btn.centerX = self.view.centerX
        btn.centerY = self.view.centerY
        btn.width = 100
        btn.height = 50
        btn.backgroundColor = UIColor.red
        
        btn.addTarget(self, action: #selector(testtest), for: .touchUpInside)
        view.addSubview(btn)
   
        
        
    }
    @objc func testtest(){
     let e =    exchange([1,2,3,4])
        
        print("e:==========",e)
        
        
    }
    
    
    
    // 调整数组顺序使奇数位于偶数前面
    /**
     *   输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有奇数在数组的前半部分，所有偶数在数组的后半部分。
     示例：
     输入：nums = [1,2,3,4]
     输出：[1,3,2,4]
     注：[3,1,2,4] 也是正确的答案之一。
     */
   @objc func exchange(_ nums: [Int]) -> [Int] {
        var temp: [Int] = []
        nums.forEach {
            if $0 & 1 == 1 {
                temp.insert($0, at: 0)
            }
            else {
                temp.append($0)
            }
        }
        return temp
    }


    
    

    
    @objc func injected(){
        
        print("xxxx==========")
        self.view.backgroundColor = UIColor.red
        xx()
    }
    
    
    func xx(){
        let array:[Int] = [90,20,50,40,30,60,10,70,80]
        
        
        for (index) in array{
          print(index)
            
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//     let s =  twoSum([1,2,3,4,5,3,2,7,11,15], 9)
        
//        print("s=========",s);
        test1( self.propertys.array)
        
    }

    
    
    
    

    // MARK: ------------------------- Events
    
    // MARK: ------------------------- Methods
    
    // 冒泡排序
    func test1(_ arr: [Int]) -> [Int]{
//        [2,5,3,1,4,8,10,7,6,9]
        var array = arr
        for i in 0..<array.count {
            for j in 0..<array.count - (i+1) {
                
                if array[j] > array[j+1] {
                    let temp = array[j]
                    array[j] = array[j+1]
                    array[j+1] = temp
                }
            }
        }

        print("array::",array);

        return array
        
        
        
    }
    
    
    //给定一个整数数组 nums 和一个整数目标值 target，请你iijy在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。
    /*
     输入：nums = [2,7,11,15], target = 9
     输出：[0,1]
     解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
     
     **/
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {

        var dict: [Int: Int] = [:]
        for (i ,n ) in nums.enumerated() {
            print("i:\(i) n:\(n)")
            if let index = dict[target - n]{
                print("index:\(index)")
                print("111======dict:\(dict)")
                return [i, index]
            }
            dict[n] = i
            print("222======dict:\(dict)")
        }
        return []
     }
    
    
    
}
