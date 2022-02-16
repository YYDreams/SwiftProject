//
//  NetworkPublicApi.swift
//  SPNetwork
//
//  Created by flowerflower on 2021/12/3.
//

import Foundation
import HandyJSON
import Moya
protocol NetworkPublicApi: TargetType {

    var originParams: [String: Any]? {get}
    var downloadDestination: DownloadDestination? {get}
    var uploadMultipartFormData: [MultipartFormData]? {get}
    func propertyName(_ targetId: Int?) -> String
}

extension NetworkPublicApi{
    
    
    var baseURL: URL{NetworkHelp.shared.baseURL()}
    
    var path: String{""}
    
    var method: Moya.Method{.post}
    
    var sampleData: Data {Data(base64Encoded: "test data")!}
    
    var task: Task {
        let params = NetworkHelp.shared.formatNetworkParams(self.originParams)
        if let downloadDestination = self.downloadDestination {
            return .downloadParameters(parameters: params, encoding: JSONEncoding.default, destination: downloadDestination)
        }
        
        if var uploadMultipartFormData = self.uploadMultipartFormData {
            params.forEach {
                let object = $0.value
                
                if JSONSerialization.isValidJSONObject(object) {
                    if let data = try? JSONSerialization.data(withJSONObject: object, options: []) {
                        uploadMultipartFormData.append(MultipartFormData(provider: .data(data), name: $0.key))
                    }
                } else {
                    if let value = "\($0.value)".data(using: .utf8) {
                        uploadMultipartFormData.append(MultipartFormData(provider: .data(value), name: $0.key))
                    }
                }
            }
            return .uploadMultipart(uploadMultipartFormData)
        }
        
        switch self.method {
        case .get:
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {nil}
    
    
}

extension NetworkPublicApi {
    
    var originParams: [String: Any]? {nil}
    var downloadDestination: DownloadDestination? {nil}
    var uploadMultipartFormData: [MultipartFormData]? {nil}
    
    func propertyName(_ targetId: Int? = nil) -> String {
        let targetSign: String = String(targetId ?? 0)
        return self.path + targetSign
    }
    
}

