//
//  DailyScheduleViewController.swift
//  Networker
//
//  Created by Big Shark on 26/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class DailyScheduleViewController: BaseViewController {
    
    //var date : Date!
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var scheduleMonthLabel: UILabel!
    
    @IBOutlet weak var dailyScheduleTableView: UITableView!
    
    @IBOutlet weak var settingsImageView: UIImageView!
    @IBOutlet weak var addImageView: UIImageView!
    var schedules : [DayScheduleModel] = []
    @IBOutlet weak var dayTableView: UITableView!
    
    
    var selectedDay = Date()

    var weekdays = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        schedules = currentUser!.user_schedules
        dailyScheduleTableView.estimatedRowHeight = 80
        weekdays = DateUtils.getWeekDays(selectedDay)
        scheduleMonthLabel.text = DateUtils.getFullDateString(selectedDay)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func getSchedule() {
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func SettingsButtonTapped(_ sender: Any) {
        /*let selector = UIStoryboard(name: "WWCalendarTimeSelector", bundle: nil).instantiateViewController(withIdentifier: "WWCalendarTimeSelector") as! WWCalendarTimeSelector
        selector.delegate = self
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        
        
        present(selector, animated: true, completion: nil)*/
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let addScheduleVC = storyboard?.instantiateViewController(withIdentifier: "AddScheduleViewController") as! AddScheduleViewController
        addScheduleVC.modalPresentationStyle = .overCurrentContext
        self.tabBarController?.present(addScheduleVC, animated: true, completion: nil)
    }
    
    @IBAction func monthViewButtonTapped(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func daysButtonTapped(_ sender: UIButton) {
    }
    
}


extension DailyScheduleViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == dayTableView {
            return weekdays.count
        }
        else {
            if let schedule = CommonUtils.getDaySchedule(day: DateUtils.getDayValue(selectedDay), schedules: schedules) {
                return schedule.schedule_events.count
            }
            else {
                return 0
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == dayTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeekdayTableViewCell") as! WeekdayTableViewCell
            cell.setCell(weekdays[indexPath.row], weekday: (7 - weekdays.count) + indexPath.row + 1)
            if DateUtils.getDate(weekdays[indexPath.row]) == selectedDay {
                cell.selectCell(true)
            }
            else {
                cell.selectCell(false)
            }
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayScheduleTableViewCell") as! DayScheduleTableViewCell
            if let schedule = CommonUtils.getDaySchedule(day: DateUtils.getDayValue(selectedDay), schedules: schedules) {
                let event = schedule.schedule_events[indexPath.row]
                cell.setCell(event)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == dayTableView {
            return 80
        }
        else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == dayTableView {
            if DateUtils.getDayValue(DateUtils.getDate(weekdays[indexPath.row])) >= DateUtils.getDayValue(Date()) {
                selectedDay = DateUtils.getDate(weekdays[indexPath.row])
                scheduleMonthLabel.text = DateUtils.getFullDateString(selectedDay)
                tableView.reloadData()
            }
        
        }
        else {
            
        }
    }
    
}

extension DailyScheduleViewController: WWCalendarTimeSelectorProtocol {
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        /*singleDate = date
        dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")*/
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, dates: [Date]) {
        print("Selected Multiple Dates \n\(dates)\n---")
        /*if let date = dates.first {
            singleDate = date
            dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
        }
        else {
            dateLabel.text = "No Date Selected"
        }
        multipleDates = dates*/
    }
}
