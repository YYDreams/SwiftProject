//
//  SPHomeViewController+Network.swift
//  SPUserCenterUI
//
//  Created by flowerflower on 2021/12/18.
//

import Foundation
import SwiftyJSON
import HandyJSON

extension SPHomeViewController{
    
    
   
    // 请求组件数据
    func requestData(){
        
        
//        self.propertys.dataArr = [SPHomeBaseViewModel]()
        self.propertys.dataArr = []
        guard let path = Bundle.main.path(forResource: "home", ofType: "json") else { return }
            let localData = NSData.init(contentsOfFile: path)! as Data
        do {
            let json =  try JSON(data: localData)
            if let model = SPHomeModel.deserialize(from: json.dictionaryObject),model.success ?? false{
                model.data?.pageModuleVOList?.forEach({ item in
                    if let vm = bindModuleViewModel(moduleModel: item){
                        self.propertys.dataArr.append(vm)
                        print("data---222--",self.propertys.dataArr.count)
                    }
                })
             
            }
            self.pagerHeader.reloadData()
            
        } catch {
            print(error)

        }


    }
    func bindModuleViewModel(moduleModel: SPPageModuleVOListModel?) -> SPHomeBaseViewModel? {
        var viewModel:SPHomeBaseViewModel? = nil
        switch moduleModel?.moduleSign {
       
        case .hotZoneModule:
        viewModel  = SPHomeHotZoneModuleViewModel()
            
        case .sliderModule:
            viewModel  = SPHomeSliderModuleViewModel()
        
        default:
            break
        }
        
      viewModel?.configData(model: moduleModel)
        
        return viewModel
        
    }
    
    
    
    
    // 请求推荐数据
    func requestReCommand(){
        
    }
    
    
    
    
    
}

//// 读取本地JSON文件
//+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
//
//    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
//
//    return [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithContentsOfFile:path] options:kNilOptions error:nil];
//}
