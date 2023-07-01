//
//  DDMonthCalendarView.swift
//  SwiftProject
//
//  Created by flower on 2023/6/23.
//

import Foundation
import UIKit
import JTAppleCalendar

class DDMonthCalendarView: UIView {
    
    var selectDateBlock:((Date)->Void)?
    
    private var getNext3YearDate: Date = {
        Date(timeIntervalSinceNow: 3 * 365 * 24 * 60 * 60)
    }()

    private var getPrevious3YearDate: Date = {
        Date(timeIntervalSinceNow: -(3 * 365 * 24 * 60 * 60))
    }()

    // 日历header
    private var headerView: UIView = {
        let headerContainerView = UIView()
        headerContainerView.backgroundColor = .clear
        return headerContainerView
    }()

    // 月份header
    private var headerTitleView: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor("#333333")
        titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        titleLabel.backgroundColor = .clear
        titleLabel.text = " "
        return titleLabel
    }()

    // 日历
    private var calendarView: JTACMonthView = {
        let jtCalendarView = JTACMonthView()
        jtCalendarView.backgroundColor = UIColor.white
        jtCalendarView.register(DDMonthCalendarCell.self, forCellWithReuseIdentifier: DDMonthCalendarCell.description())
        jtCalendarView.scrollingMode = .stopAtEachCalendarFrame
        jtCalendarView.scrollDirection = .horizontal
        jtCalendarView.allowsMultipleSelection = false
        jtCalendarView.showsHorizontalScrollIndicator = false
        jtCalendarView.minimumLineSpacing = 0
        jtCalendarView.minimumInteritemSpacing = 0
    
        return jtCalendarView
    }()


    private var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "今天"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor("#333333")
        label.isHidden = true
        label.setCornerRadius(12)
        label.layer.borderColor = UIColor("#CCCCCC").cgColor
        label.layer.borderWidth = 1
        label.isUserInteractionEnabled = true
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        setupData()
    }
    func setupData(){
        setSelectedDate(date: Date())
        updateScrollToDate(date: Date(), animateScroll: false)
    }
    // 设置选中的时间
    func setSelectedDate(date: Date) {
        if calendarView.selectedDates.contains(date) { return }
        calendarView.selectDates([date])
    }
    // 设置默认配置
    func updateScrollToDate(date: Date, animateScroll: Bool = false) {
        calendarView.scrollToDate(date, animateScroll: animateScroll) {[weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    private func setupSubViews() {
        backgroundColor = UIColor(hex: "#000000", alpha: 0.3)
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        
        let contentView = UIButton()
        contentView.addTarget(self, action: #selector(remove), for: .touchUpInside)
        addSubview(contentView)
        contentView.backgroundColor = UIColor.white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.snp.makeConstraints{
            $0.left.equalTo(22)
            $0.height.equalTo(350)
            $0.center.equalToSuperview()
        }
        
        headerView.addSubview(headerTitleView)
        headerView.addSubview(todayLabel)
        contentView.addSubview(headerView)
        contentView.addSubview(calendarView)

        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(9.5)
            make.right.equalToSuperview().offset(-9.5)
            make.height.equalTo(76)
        }

        headerTitleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        todayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(headerTitleView)
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(48)
            make.height.equalTo(24)
        }

        calendarView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.equalToSuperview().offset(9.5)
            make.right.equalToSuperview().offset(-9.5)
            make.height.equalTo(264)
        }



        // 配置header视图
        fillHeaderView()
        
        todayLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickTodayLabel)))
    }
    @objc func remove(){
        self.removeFromSuperview()
    }
    @objc func clickTodayLabel(){
        scrollToDate(targetDate: Date(),isSelected: true)
    }
    /// 将日历翻到指定日期
    /// - Parameters:
    ///   - targetDate: 需要翻页的指定日期
    ///   - isSelected: 是否需要选中该日期。默认为false不选中
    func scrollToDate(targetDate: Date, isSelected: Bool = false) {
        calendarView.scrollToDate(targetDate, animateScroll: false)
        if isSelected {
            calendarView.selectDates(from: targetDate, to: targetDate)
        }
    }

    /// 配置日历header视图内容
    private func fillHeaderView() {
        // 配置翻页按钮视图
        // 上一个月
        let preMonthBtnView = UIButton()
        headerView.addSubview(preMonthBtnView)
        preMonthBtnView.snp.makeConstraints {
            $0.centerY.equalTo(headerTitleView.snp.centerY)
            $0.right.equalTo(headerTitleView.snp.left).offset(-12)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        }
        preMonthBtnView.setImage(UIImage(named: "icon_type_selected"), for: .normal)
        preMonthBtnView.addTarget(self, action: #selector(scrollToPreviousMonth), for: .touchUpInside)

        // 下一个月
        let nextMonthBtnView = UIButton()
        headerView.addSubview(nextMonthBtnView)
        nextMonthBtnView.snp.makeConstraints {
            $0.centerY.equalTo(headerTitleView.snp.centerY)
            $0.left.equalTo(headerTitleView.snp.right).offset(12)
            $0.width.height.equalTo(preMonthBtnView)
        }
        nextMonthBtnView.setImage(UIImage(named: "icon_type_selected"), for: .normal)
        nextMonthBtnView.addTarget(self, action: #selector(scrollToNextMonth), for: .touchUpInside)

        // 配置“星期x”视图
        let weekDataSource = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        let weekView = UIView()
        weekView.backgroundColor = UIColor(hex: "#EAEAEA")
        headerView.addSubview(weekView)
        weekView.layer.cornerRadius = 15
        weekView.layer.masksToBounds = true
        weekView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.height.equalTo(30)
            $0.bottom.equalToSuperview().offset(-4)

        }
        var preLabel: UILabel?
        for index in 0 ... 6 {
            let label = UILabel(frame: .zero)
            label.textColor = UIColor("#999999")
            label.font = .systemFont(ofSize: 12)
            label.text = weekDataSource[index]
            label.textAlignment = .center
            weekView.addSubview(label)
            if let p = preLabel {
                label.snp.makeConstraints { make in
                    make.width.bottom.height.equalTo(p)
                    make.left.equalTo(p.snp.right)
                    if index == 6 { make.right.equalToSuperview() }
                }
            } else {
                label.snp.makeConstraints{
                    $0.left.height.bottom.equalToSuperview()
                }
            }
            preLabel = label
        }
    }

    /// 翻到下一个月
    @objc private func scrollToNextMonth() {
//        print("翻至下一个月")
        if let _ = calendarView.visibleDates().monthDates.last?.date {
//            calendarView.scrollToDate(d.tomorrow)
            calendarView.scrollToSegment(.next)
        }
    }

    /// 翻到上一个月
    @objc private func scrollToPreviousMonth() {
//        print("翻至上一个月")
        if let _ = calendarView.visibleDates().monthDates.first?.date {
//            calendarView.scrollToDate(d.yesterday)
            calendarView.scrollToSegment(.previous)
        }
    }

    func reloadByRezising(visibleDates: DateSegmentInfo) {
        calendarView.reloadData(withAnchor: visibleDates.monthDates.first?.date, completionHandler: nil)
        calendarView.setNeedsLayout()
        calendarView.layoutIfNeeded()
    }

    func getCurrentMounthStart() {
        let start = calendarView.visibleDates().monthDates[0].date
        let tempDateFormatter = DateFormatter()
        tempDateFormatter.dateFormat = "yyyy-MM-dd"
//        tempDateFormatter.timeZone = TimeZone.current
        tempDateFormatter.locale = Locale.current
        let startStr = tempDateFormatter.string(from: start)
        print("start --- \(startStr)")
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//extension DDMonthCalendarView: EXCalendarProtocol {
//    func updateCourseCount(datas: [String: Int]) {
//        courseCountDatas = datas
//        calendarView.reloadData()
//    }
//
//    func getMonthStartAndEnd(result: @escaping (Date, Date) -> Void) {
//        calendarView.visibleDates { dateSegmentInfo in
//            result(dateSegmentInfo.monthDates[0].date, dateSegmentInfo.monthDates[dateSegmentInfo.monthDates.count - 1].date)
//        }
//    }
//
//    /// 将日历翻到指定日期
//    /// - Parameters:
//    ///   - targetDate: 需要翻页的指定日期
//    ///   - isSelected: 是否需要选中该日期。默认为false不选中
//    func scrollToDate(targetDate: Date, isSelected: Bool = false) {
//        calendarView.scrollToDate(targetDate, animateScroll: false)
//        if isSelected {
//            calendarView.selectDates(from: targetDate, to: targetDate)
//        }
//    }
//}


// MARK: -JTACMonthViewDataSource
extension DDMonthCalendarView: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        return ConfigurationParameters(startDate: getPrevious3YearDate,
                                       endDate: getNext3YearDate,
                                       numberOfRows: 6,
                                       generateInDates: .forAllMonths,
                                       generateOutDates: .tillEndOfRow,
                                       firstDayOfWeek: .sunday,
                                       hasStrictBoundaries: true)
        
    }
}

// MARK: -JTACMonthViewDelegate
extension DDMonthCalendarView: JTACMonthViewDelegate {
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: DDMonthCalendarCell.description(), for: indexPath) as? DDMonthCalendarCell else { return JTACDayCell() }
        cell.refreshUI(cellState: cellState, pointStatus:.started, isThisMonth: cellState.dateBelongsTo == .thisMonth, isToday: isToday(date: cellState.date))

        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
     
    }
    
    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
        todayLabel.isHidden = isThisMonth(date: visibleDates.monthDates[0].date) &&  isToday(date: calendarView.selectedDates[0])
        headerTitleView.text = visibleDates.monthDates[0].date.getCNYearAndMonth()
        
    }
    
    func calendar(_ calendar: JTACMonthView, willScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
    }
    
    
    // 取消选中
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        if let calendarCell = cell as? DDMonthCalendarCell {
            calendarCell.refreshUI(cellState: cellState, pointStatus: .started, isThisMonth: cellState.dateBelongsTo == .thisMonth, isToday: isToday(date: cellState.date))
            
        }
    }
    
    // 选中
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        let isThisMonth = cellState.dateBelongsTo == .thisMonth
        if let calendarCell = cell as? DDMonthCalendarCell {
            calendarCell.refreshUI(cellState: cellState, pointStatus: .started, isThisMonth: isThisMonth, isToday: isToday(date: cellState.date))
        }
    
        if !isThisMonth { calendar.scrollToDate(date) }
        selectDateBlock?(date)
        todayLabel.isHidden = isToday(date: cellState.date)
        
    }
    /// 判断是否为今天
    /// - Parameter date 待判断的时间
    /// - Returns: 是否为今天
     func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        let unit: Set<Calendar.Component> = [.day, .month, .year]
        let nowComps = calendar.dateComponents(unit, from: Date())
        let selfCmps = calendar.dateComponents(unit, from: date)

        return (selfCmps.year == nowComps.year) &&
            (selfCmps.month == nowComps.month) && (selfCmps.day == nowComps.day)
    }

     func isThisMonth(date: Date) -> Bool {
        let calendar = Calendar.current
        let unit: Set<Calendar.Component> = [.day, .month, .year]
        let nowComps = calendar.dateComponents(unit, from: Date())
        let selfCmps = calendar.dateComponents(unit, from: date)
        return (selfCmps.year == nowComps.year) &&
            (selfCmps.month == nowComps.month)
    }
    
}
 
extension Date {
    
    /// 返回当前date组成的 “xx年xx月”
    /// - Returns:xx年xx月
    func getCNYearAndMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY年M月"
        return dateFormatter.string(from: self)
    }
}

