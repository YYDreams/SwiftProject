//
//  SPBaseCourseVC+Delegate.swift
//  SwiftProject
//
//  Created by flower on 2024/7/19.
//

import Foundation
import JXSegmentedView

extension SPBaseCourseDetailVC: JXSegmentedViewDelegate{
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
          
          if let tableView = self.smoothView.currentListScrollView as? UITableView{
              
              let frame = tableView.rectForHeader(inSection: index)
              
              var offsetY = (frame.origin.y) - kBaseHeaderHeight + kBaseSegmentHeight + kNavBarHeight - kStatusBarHeight
              
              let maxOffsetY = tableView.contentSize.height - tableView.frame.size.height
              
              if offsetY > maxOffsetY {
                  offsetY = maxOffsetY
              }
              let lastSection = tableView.numberOfSections - 1
              let lastHeaderRest = tableView.rectForHeader(inSection: lastSection)
              if offsetY == maxOffsetY { //点击了最后一个
      //           tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 180, right: 0)
  //                tableView.setContentOffset(CGPoint(x: 0, y: lastHeaderRest.minY-98-40), animated: true)
              }else{
  //                tableView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
              }
              tableView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
    
              print("segmentedView=====offsetY:\(offsetY) maxOffsetY:\(maxOffsetY) contentSizeHeight\(tableView.contentSize.height) height:\(tableView.frame.size.height) lastHeaderRest:\(lastHeaderRest) minY:\(lastHeaderRest.minY)")
          }
      }
    
}


extension SPBaseCourseDetailVC: SPPageSmoothViewDelegate{
  
    
}


extension SPBaseCourseDetailVC: SPPageSmoothViewDataSource{
    func segmentedView(in smoothView: SPPageSmoothView) -> UIView {
        segmentedView
    }
    
    func numberOfLists(in smoothView: SPPageSmoothView) -> Int {
        1
    }
    
    func headerView(in smoothView: SPPageSmoothView) -> UIView {
        headerView
    }
    
    func smoothView(_ smoothView: SPPageSmoothView, initListAtIndex index: Int) -> SPPageSmoothListViewDelegate {
        let listView = SPCourseDetailView()
         listView.delegate = self
         var data = [[String: String]]()
         let counts = [6, 8]
         for i in 0..<counts.count {
             var dic = [String: String]()
             dic["title"] = self.segmentedDataSource.titles[i]
             dic["count"] = String(counts[i])
             data.append(dic)
         }
         listView.datas = data;
         return listView;
    }
    
    
}

// MARK: ------------------------- SPCourseDetailViewDelegate
extension SPBaseCourseDetailVC: SPCourseDetailViewDelegate{
    func locationViewDidEndAnimation(scrollView: UIScrollView) {
        
    }
}
extension SPBaseCourseDetailVC: SPCourseViewModelProtocol{
    @objc optional  func didRefreshUI(){
        
        
    }
 
}



