//
//  SPCourseViewModel.swift
//  SwiftProject
//
//  Created by flower on 2024/7/19.
//

import Foundation
import PromiseKit

enum SPCourseDetailType: String{
    case introduce  = "介绍"
    case courseware = "资料"
    case interaction = "课堂互动"
    case comment = "评论"
}

@objc protocol SPCourseViewModelProtocol {
    
    /// 刷新列表
    @objc optional  func didRefreshUI()
    @objc optional  func didRefreshCategoryUI()
}


class SPCourseViewModel: NSObject{
    
    weak  var delegate: SPCourseViewModelProtocol?
    
    public var categoryTitles = [String]()
    
    var dataArr : [SPCourseDetailType:[SPBaseCourseModel]]?
    
    var params: Params = Params()
    
    public convenience init(params:Params , delegate: SPCourseViewModelProtocol?) {
        self.init()
        self.params = params
        self.delegate = delegate
        self.requestData()
    }
    func requestData() {
//        firstly{ () -> Promise<EXLearnModel?>in
//            return self.requestLearnData()
//        }.then { learnModel -> Promise<XETLastStudyModel?> in
//            self.learnData = learnModel
//            return self.requestLastStudyData()
//        }.then { lastStudyModel -> Promise<[EXHomeLiveModel]?> in
//            self.lastStudyData = lastStudyModel
//            return self.requestLiveData()
//        }.then { liveModels -> Promise<[EXMyCourseListModel]?> in
//            self.liveData  = liveModels
//            return self.requestCourseData()
//        }.done { courseModels in
//            self.isReqesting = false
//            self.courseData = courseModels
//            self.handlerCells()
//        }.ensure {
//           // EXHud.forceDismiss()
//        }.recover {_ in
//            self.handlerCells()
//        }
    }
    
//    private func requestLiveData() -> Promise<[EXHomeLiveModel]?> {
//        return EXHomeApiRequest.networkAliveAllLists()
//    }


    
}
