//
//  SPPrint.swift
//  SwiftProject
//
//  Created by flower on 2023/5/6.
//

import Foundation
import UIKit

public struct SPPrint{
    
    /// 日志打印输出
    /// - Parameters:
    ///   - content: 输出内容
    ///   - identifter: 打印的标志符号,方便查找
    ///   - file: 所在文件
    ///   - method: 所在方法
    ///   - line: 所在行数
    public static func print<T>(_ content: T, identifter: String = "", file: String = #file, method: String = #function, line: Int = #line){
        #if DEBUG
        let fileStr = "\((file as NSString).lastPathComponent)[\(line)]: \(method)"
        let type = handerData(content)
        let emo = type.getEmjio()
        let content = type.getContent()
        let toastStr = "👉👉👉 " + emo + " " + (identifter.count == 0 ? "" : "[\(identifter)] -> ") + fileStr + " " + content +  " "
            Swift.print(toastStr)
        #endif
        
    }
}
extension SPPrint{
    private static func handerData(_ content: Any) -> PrintContentType{
        if let string = content as? String{
            if let _ = URL(string: string) {
                return .url(string)
            }else{
                return .string(string)
            }
        }
        if let int = content as? Int{
            return .int(int)
        }
        if let double = content as? Double{
            return .double(double)
        }
        if let float = content as? Float{
            return .float(float)
        }
        if let cgfloat = content as? CGFloat{
            return .cgfloat(cgfloat)
        }
        if let bool = content as? Bool{
            return .bool(bool)
        }
        if let array = content as? [Any]{
            return .array(array)
        }
        if let dictionary = content as? Dictionary<String,Any>{
            return .dictionary(dictionary)
        }
        if let color = content as? UIColor{
            return .color(color)
        }
        
        if let error = content as? NSError{
            return .error(error)
        }
        
        if let date = content as? Date{
            return .date(date)
        }
        
        return .any(content)
    }

}

extension SPPrint{

    enum PrintContentType {
        /// 字符串
        case string(String)
        /// Int
        case int(Int)
        /// Doudle
        case double(Double)
        /// Float
        case float(Float)
        /// CGFloat
        case cgfloat(CGFloat)
        /// Bool
        case bool(Bool)
        /// 数组
        case array([Any])
        /// 字典
        case dictionary([String:Any])
        /// 颜色
        case color(UIColor)
        /// 错误
        case error(NSError)
        /// URL
        case url(String)
        /// 时间
        case date(Date)
        /// Any
        case any(Any)

        
        func getEmjio() ->String{
            switch self {
            case .string(_):
                return "[✏️ String]"
            case .any(_):
                return "[🎲 Any]"
            case .array(_):
                return "[🌲 Array]"
            case .dictionary(_):
                return "[📚 Dictionary]"
            case .color(_):
                return "[🎨 Color]"
            case .error(_):
                return "[❌ Error]"
            case .url(_):
                return "[🌏 URL]"
            case .date(_):
                return "[⏰ Date]"
            case .int(_):
                return "[Int]"
            case .double(_):
                return "[Double]"
            case .float(_):
                return "[Float]"
            case .cgfloat(_):
                return "[CGFloat]"
            case .bool(_):
                return "[Bool]"
            }
            
        }
        func getContent() ->String{
            
            func content<T>(_ object: T) -> String {
                let temp = "\(object)"
                return temp
            }
            switch self {
            case .string(let string):
                return content(string)
            case .int(let int):
                return content(int)
            case .double(let double):
                return content(double)
            case .float(let float):
                return content(float)
            case .cgfloat(let cGFloat):
                return content(cGFloat)
            case .bool(let bool):
                return content(bool)
            case .array(let array):
                return content(array)
            case .dictionary(let dictionary):
                return content(dictionary)
            case .color(let uIColor):
                return content(uIColor)
            case .error(let nSError):
                return content(nSError)
            case .url(let string):
                return content(string)
            case .date(let date):
                return content(date)
            case .any(let any):
                return content(any)
            }
        }
    }
}
