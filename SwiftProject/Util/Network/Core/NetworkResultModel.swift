//
//  NetworkResultModel.swift
//  SwiftProject
//
//  Created by flower on 2024/5/31.
//

import Foundation
import HandyJSON
import Alamofire
import SwiftyJSON

extension SPRequestResultModel {
    
    /** 转换为网络请求model */
    class func decode(json:NSDictionary?) ->(SPRequestResultModel?, Swift.Error?) {
        let resultModel = SPRequestResultModel.deserialize(from: json)
        if resultModel?.code.isSuccess == true {
            return (resultModel, nil)
        } else {
            let error = NetworkError.error(resultModel?.originCode, resultModel?.msg, resultModel?.data)
            return (nil, error)
        }
    }
    
}
public class SPRequestResultModel: HandyJSON {
  
    public var data: Any?
    public var code: Code = .unknown
    public var originCode: Int?
    public var httpStatusCode: Int?
    public var httpResponseData: Data?
    public var msg: String = ""
    public var status: Int = NSURLErrorBadServerResponse
    
    public required init() {}
    public func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.code <-- TransformOf<Code, Any>(fromJSON: { [weak self] originCode -> Code in
                if let strCode = originCode as? String {
                    self?.originCode = Int(strCode)
                    return Code(rawValue: Int(strCode) ?? Code.unknown.rawValue) ?? .unknown
                } else if let intCode = originCode as? Int {
                    self?.originCode = intCode
                    return Code(rawValue: intCode) ?? .unknown
                }
                return .unknown
            }, toJSON: { transCode -> Int in
                return transCode?.rawValue ?? Code.unknown.rawValue
            })
    }
    
    public func model<Model: HandyJSON>() -> Model? {
        return self.model(type: Model.self)
    }
    
    public func model<Model: HandyJSON>(type: Model.Type) -> Model? {
        if let datastring = self.data as? String , let dataDic = JSON(parseJSON: datastring).dictionaryObject {
            return type.deserialize(from: dataDic)
        }
        return type.deserialize(from: self.data as? [String: Any])
    }
    public func models<Model: HandyJSON>() -> [Model]? {
        return self.models(type: Model.self)
    }
    
    public func models<Model: HandyJSON>(type: Model.Type) -> [Model]? {
        return Array<Model>.deserialize(from: self.data as? [[String: Any]])?.compactMap{$0}
    }
    
    public func modelsByDataList<Model: HandyJSON>() -> [Model]? {
        return self.modelsByDataList(type: Model.self)
    }
    
    public func modelsByDataList<Model: HandyJSON>(type: Model.Type) -> [Model]? {
        if let data = self.data as? [String: Any] , let list = data["list"] as? [[String: Any]] {
            return Array<Model>.deserialize(from: list)?.compactMap{$0}
        }
        return nil
    }
    
}
public extension SPRequestResultModel.Code {
    
    /** 判断网络请求是否成功 */
    var isSuccess: Bool {self == .success}
    
}

public extension SPRequestResultModel {
    
    /** 网络请求状态码 */
    enum Code: Int {
        /** 未知，默认值 */
        case unknown = -1
        /** token失效 */
        case relogin = -1001
        /** 挤登的设备*/
        case userLogoutByDevice = -2001
        /** 无页面 */
        case notFound = 404
        /** 成功 */
        case success = 0
    }
    
}

public enum NetworkError: Error {
    /**< 通用错误 */
    case common(String?)
    /**< 取消 */
    case cancelled(String?)
    /** 带错误码的错误 */
    case error(Int?, String?, Any? = nil)
}

extension NetworkError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .common(let des):
            return des ?? "未知错误"
        case .cancelled(let des):
            return des ?? "取消操作"
        case .error(_, let des, _):
            return des ?? "未知错误"
        }
        
    }
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        return debugDescription
    }
}

extension NetworkError: CustomNSError {
    
    public var errorCode: Int {
        switch self {
        case .common(_):
            return NetworkError.undefined
        case .cancelled(_):
            return NSURLErrorCancelled
        case .error(let code, _, _):
            return code ?? NetworkError.undefined
        }
    }
    
    public var errorUserInfo: [String : Any] {[:]}
    
    public static var errorDomain: String {"NetworkError"}
    
}

extension NetworkError {
    
    static let undefined: Int = -1
    
    public var code: Int {
        switch self {
        case .common(_):
            return NetworkError.undefined
        case .cancelled(_):
            return NSURLErrorCancelled
        case .error(let code, _, _):
            return code ?? NetworkError.undefined
        }
    }
    
}

