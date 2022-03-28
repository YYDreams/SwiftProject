//
//  SPModel.swift
//  SwiftProject
//
//  Created by flowerflower on 2022/3/26.
//

import Foundation
import HandyJSON
struct XMResponseData<T: HandyJSON> : HandyJSON{
    
    var msg: String?
    var ret: Int = 0
}
