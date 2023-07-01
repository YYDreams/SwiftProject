//
//  SPArrayOperationViewController.swift
//  SwiftProject
//
//  Created by flower on 2023/5/10.
//

import Foundation
struct Person{
    var name: String
    var age: Int
    var hobbies:[String]
}
class SPArrayOperationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        test1()
    }
    func test1(){
        var array = [Person(name: "张三", age: 30, hobbies: ["吃"]),
                     Person(name: "李四", age: 10, hobbies: ["合"]),
                     Person(name: "王五", age: 40, hobbies: [])]
        var result = [String]()
        for p in array {
        result.append(p.name)
        }
        SPPrint.print(result) //["张三", "李四", "王五"]

        let result1 = array.map{ $0.name }
        SPPrint.print(result1) //["张三", "李四", "王五"]
        
        
        
        var result2 = [String]()
        for p in array {
            if p.age > 10 {
              result2.append(p.name)
            }
        }
        SPPrint.print(result2) // 输出 ["张三", "王五"]
        let result3 = array.filter { $0.age > 10 }.map { $0.name }
        SPPrint.print(result3) // 输出 ["张三", "王五"]
        
        let allHobbies = array.flatMap { $0.hobbies }
        SPPrint.print(allHobbies) // ["吃", "合"]
        
        let ages = array.reduce(0) { $0 + $1.age}
        SPPrint.print(ages) // 80
        
//        let numbers = [1, 2, 3, 4]
//        let sum = numbers.reduce(0, +)
//        SPPrint.print(sum) // 10
        
        
        let numbers = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
        let sortedNumbers = numbers.sorted()
        SPPrint.print(sortedNumbers) // [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]
        
        let descendingNumbers = numbers.sorted(by: >)
        SPPrint.print(descendingNumbers) // [9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1]
        
        var students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
        students.sort(by: >)
        SPPrint.print(students) //["Peter", "Kweku", "Kofi", "Akosua", "Abena"]
        
        
        numbers.forEach { SPPrint.print($0) }
        
        let strs = ["1", "2", "3", "hello", "4"]
        let nums = strs.compactMap { Int($0) }
        SPPrint.print(nums) // [1, 2, 3, 4]
        
        let evenNumbers = strs.compactMap { Int($0) }.filter { $0 % 2 == 0 }
        SPPrint.print(evenNumbers) //[2, 4]
        
        SPPrint.print(array)
        
        //需要从一个包含多个元素的数组中查找符合某些条件的元素。例如，在一个视频库应用中，我们可以根据视频名称来查找视频对象。
       // 有时候一个数组中可能包含一些空元素，我们只关心里面的非空元素。此时，可以使用 first(where:) 方法来查找第一个非空元素。

       // let numbers = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
     
        if let person = array.first(where: { $0.name  == "王五"}) {
            SPPrint.print("\(person.name)") //王五
        }else {
            SPPrint.print("not found")
        }
        
        let numbersssss = [1, 2, 3, 4]
        let firstEvenIndex = numbersssss.firstIndex(where: { $0 % 2 == 0 })
        SPPrint.print(firstEvenIndex ?? 0) // 1

        let index = array.firstIndex(where: { $0.name  == "王五"})
        SPPrint.print(index) // 2

        //使用 stride 函数创建了一个由 0 到 10 的整数（不包括 10）组成的序列，步长为 2。
        for i in stride(from: 0, to: 10, by: 2) {
            SPPrint.print(i) //打印的结果是 0、2、4、6、8
        }
        //使用 stride 函数创建了一个从 10 到 1 的整数序列，步长为 -1。因此
        for i in stride(from: 10, to: 0, by: -1) {
            SPPrint.print(i) //打印的结果是 10、9、8、...、2、1
        }
        
        // 将数组分成两部分，满足条件的元素在左侧，不满足条件的元素在右侧。然后，只需要遍历左侧部分的元素，就可以获得所有满足条件的元素。
        var passengers = ["Alice", "Bob", "Charlie", "David","b"]
        SPPrint.print(passengers.partition { $0.count <= 4 }) // ["Alice", "David", "Charlie", "Bob", "b"]

 
        
        

         array = array.filter { $0.name != "王五" }
        SPPrint.print(array) //[SwiftProject.Person(name: "张三", age: 30, hobbies: ["吃"]), SwiftProject.Person(name: "李四", age: 10, hobbies: ["合"])]
        
        
        array.removeAll { $0.name == "王五" }
        SPPrint.print(array) // [SwiftProject.Person(name: "张三", age: 30, hobbies: ["吃"]), SwiftProject.Person(name: "李四", age: 10, hobbies: ["合"])]
        
        let numbs = [1, 2, 3]
        let letters = ["A", "B", "C"]
        let pairs = zip(numbs, letters)
        SPPrint.print(Array(pairs)) //[(1, "A"), (2, "B"), (3, "C")]
        
        let numberss = [1, 2, 3, 4]
        let allGreaterThanZero = numberss.allSatisfy { $0 > 0 }
        let allGreaterThanOne = numberss.allSatisfy { $0 > 1 }
        SPPrint.print(allGreaterThanZero) // true
        SPPrint.print(allGreaterThanOne) // false
        
        
        let numbersss = [[1, 2], [3, 4], [5, 6]]
        let joinNumbers = numbersss.joined()
        print(Array(joinNumbers)) // [1, 2, 3, 4, 5, 6]
        
 
        
    }
}
