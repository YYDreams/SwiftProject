//
//  SPCourseDetailView.swift
//  SwiftProject
//
//  Created by flower on 2024/7/19.
//

import Foundation
// MARK: ------------------------- SPCourseDetailViewDelegate
protocol SPCourseDetailViewDelegate: NSObjectProtocol {
    func locationViewDidEndAnimation(scrollView: UIScrollView)
}

class SPCourseDetailView: UIView{
    
    weak var delegate: SPCourseDetailViewDelegate?
    
    var dataArr : [SPCourseDetailType:[SPBaseCourseModel]]?
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView;
    }()
    var datas = [[String: String]]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    func refreshUI(_: [SPCourseDetailType:[SPBaseCourseModel]]?){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension SPCourseDetailView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic = self.datas[section]
        let count = dic["count"]!
        return Int(count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dic = self.datas[indexPath.section]
        cell.textLabel?.text = dic["title"]! + "--" + "\(indexPath.row + 1)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.orange
        let titleLabel = UILabel()
        header.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(header).offset(15)
            make.centerY.equalTo(header)
        }
        let dic = self.datas[section]
        titleLabel.text = dic["title"]!
        return header
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.delegate?.locationViewDidEndAnimation(scrollView: scrollView)
    }
}

extension SPCourseDetailView: SPPageSmoothListViewDelegate {
    func listView() -> UIView {
        return self
    }
    
    func listScrollView() -> UIScrollView {
        return self.tableView
    }
}

