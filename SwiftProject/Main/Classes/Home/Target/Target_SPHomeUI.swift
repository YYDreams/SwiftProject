//
//  Target_SPHomeUI.swift
//  SPHomeUI
//
//  Created by flowerflower on 2021/12/17.
//

import UIKit


@objc public class Target_SPHomeUI: NSObject {
    
    @objc public func Action_homeViewController(_ param: NSDictionary) -> UIViewController {

        let controller = SPHomeViewController()
        return controller
    }

}

