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
    
    
    var selectedDay = 0

    var weekdays = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        schedules = currentUser!.user_schedules
        
        
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
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let addScheduleVC = storyboard?.instantiateViewController(withIdentifier: "AddScheduleViewController") as! AddScheduleViewController
        //addScheduleVC.currentMonth = currentMonth
        self.navigationController?.pushViewController(addScheduleVC, animated: true)
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
            return 7
        }
        else {
            if let schedule = CommonUtils.getDaySchedule(day: selectedDay, schedules: schedules) {
                return schedule.getScheduleArray().count
            }
            else {
                return 0
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == dayTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeekdayTableViewCell") as! WeekdayTableViewCell
            cell.setCell(weekdays[indexPath.row])
            return cell
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayScheduleTableViewCell") as! DayScheduleTableViewCell
            if let schedule = CommonUtils.getDaySchedule(day: selectedDay, schedules: schedules) {
                let event = schedule.getScheduleArray()[indexPath.row]
                cell.setCell(event)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    /*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return monthSchedule[section].getDateString()
    }*/
}
