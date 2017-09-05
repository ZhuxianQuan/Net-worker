//
//  UserAvailabilityViewController.swift
//  Networker
//
//  Created by Big Shark on 27/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class UserAvailabilityViewController: BaseViewController {

    var user : UserModel!
    
    @IBOutlet weak var backButton: UIButton!
    var selectedDate : Date!
    
    @IBOutlet weak var calendarView: FSCalendar! {
        didSet {
            
            calendarView.delegate = self
            calendarView.dataSource = self
        }
    }
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.navigationController?.viewControllers.count == 1 {
            backButton.isHidden = true
        }
        else{
            backButton.isHidden = false
        }
        selectedDate = Date()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calendarView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated : true)
    }
    
    
    @IBAction func scheduleDayButtonTapped(_ sender: UIView) {
        if selectedDate != nil {
            let dailyScheduleVC = self.storyboard?.instantiateViewController(withIdentifier: "DailyScheduleViewController") as! DailyScheduleViewController
            dailyScheduleVC.selectedDay = selectedDate
            self.navigationController?.pushViewController(dailyScheduleVC, animated: true)
        }
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        drawerController?.setDrawerState(.opened, animated: true)
    }
}


extension UserAvailabilityViewController : FSCalendarDelegate , FSCalendarDataSource {
    
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date().addingTimeInterval(86400 * 62)
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
        selectedDate = date
    }
    
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let day = Int(formatter.string(from: date))!
        for schedule in user.user_schedules {
            if schedule.day == day {
                return 1
            }
            else if schedule.day > day {
                break
            }
        }
        return 0
    }
    
}

