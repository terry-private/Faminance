//
//  InputCalendarViewController.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/20.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit
import BottomHalfModal
import FSCalendar

protocol InputCalendarViewControllerDelegate {
    func setDate(_ date: Date)
}

final class InputCalendarViewController: UIViewController, SheetContentHeightModifiable {
    @IBOutlet weak var inputCalendar: FSCalendar!
    var inputCalendarViewControllerDelegate: InputCalendarViewControllerDelegate?
    var currentDate = Date.current
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    let sheetContentHeightToModify: CGFloat = 420

    init() {
        super.init(nibName: nil, bundle: Bundle(for: InputCalendarViewController.self))
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        calendarHeight.constant = sheetContentHeightToModify
        inputCalendar.locale = .japan
        inputCalendar.select(currentDate, scrollToDate: true)
        inputCalendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        inputCalendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        inputCalendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        inputCalendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        inputCalendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        inputCalendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        inputCalendar.calendarWeekdayView.weekdayLabels[6].text = "土"
        
        inputCalendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor.red
        inputCalendar.calendarWeekdayView.weekdayLabels[1].textColor = UIColor.black
        inputCalendar.calendarWeekdayView.weekdayLabels[2].textColor = UIColor.black
        inputCalendar.calendarWeekdayView.weekdayLabels[3].textColor = UIColor.black
        inputCalendar.calendarWeekdayView.weekdayLabels[4].textColor = UIColor.black
        inputCalendar.calendarWeekdayView.weekdayLabels[5].textColor = UIColor.black
        inputCalendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor.blue
        
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let closeButton = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(close))
        closeButton.tintColor = .white
        
        
        navigationItem.leftBarButtonItem = closeButton
        
        inputCalendar.delegate = self
        setUp()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        setDate(date)
        dismiss(animated: true, completion: nil)
    }
    



    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adjustFrameToSheetContentHeightIfNeeded()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        adjustFrameToSheetContentHeightIfNeeded(with: coordinator)
    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    func setDate(_ date: Date){
        inputCalendarViewControllerDelegate?.setDate(date.added(hour:9))
    }
    
}

extension InputCalendarViewController: FSCalendarDelegate {
    
}
