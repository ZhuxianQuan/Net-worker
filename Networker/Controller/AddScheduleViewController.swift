//
//  AddScheduleViewController.swift
//  Networker
//
//  Created by Big Shark on 27/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import Koyomi
class AddScheduleViewController: BaseViewController {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeView: UIView!

    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var workingTitleTextField: UITextField!
    
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var redValue: UITextField!
    @IBOutlet weak var greenValue: UITextField!
    @IBOutlet weak var blueValue: UITextField!
    
    @IBOutlet weak var paletteView: UIView!
    
    var currentPickerStatus = 0
    
    let CURRENT_PICKER_DAY      = 1
    let CURRENT_PICKER_TIME     = 2
    
    var showsTimePicker : Int = 0
    
    let SHOW_TIME_START         = 1
    let SHOW_TIME_END           = 2
    
    var scheduleData = ScheduleData()
    var currentMonth = ScheduleMonth(year: 0, month : 1)
    var currentDay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timeView.isHidden = true
        setStartTime()
        setEndTime()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func startTimeButtonTapped(_ sender: Any) {
        timeView.isHidden = false
        pickerViewTopConstraint.constant = 0
        showsTimePicker = SHOW_TIME_START
        currentPickerStatus = CURRENT_PICKER_TIME
        pickerView.reloadAllComponents()
    }
    
    @IBAction func endTimeButtonTapped(_ sender: Any) {
        
        timeView.isHidden = false
        pickerViewTopConstraint.constant = 40
        showsTimePicker = SHOW_TIME_END
        currentPickerStatus = CURRENT_PICKER_TIME
        pickerView.reloadAllComponents()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        timeView.isHidden = true
        self.view.endEditing(true)
    }
    
    func setStartTime(){
        fromButton.setTitle("\(scheduleData.start_time.hour) : \(scheduleData.start_time.minute)", for: .normal)
    }
    
    func setEndTime() {
        toButton.setTitle("\(scheduleData.end_time.hour) : \(scheduleData.end_time.minute)", for: .normal)
    }
    
    
    func checkEndTimeValid() -> Bool{
        if scheduleData.start_time.hour * 100 + scheduleData.start_time.minute < scheduleData.end_time.hour * 100 + scheduleData.start_time.minute {
            return true
        }
        return false
    }
    @IBAction func dayButtonTapped(_ sender: Any) {
        
        currentPickerStatus = CURRENT_PICKER_DAY
        pickerViewTopConstraint.constant = -40
        timeView.isHidden = false
        pickerView.reloadAllComponents()
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        var colorString = sender.text!
        if colorString.characters.count >= 3{
        
            if Int(colorString)! > 255 {
                //sender.text = colorString
            }
        }
        self.view.endEditing(true)
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if checkEndTimeValid() && workingTitleTextField.text!.characters.count > 0{
            scheduleData.work_title = workingTitleTextField.text!
            let vcs = self.navigationController?.viewControllers
            if (vcs?[(vcs?.count)! - 2].isKind(of: DailyScheduleViewController.self))! {
                let dailyScheduleVC = vcs?[(vcs?.count)! - 2] as! DailyScheduleViewController
                let schedules = dailyScheduleVC.monthSchedule
                let currentDate = ScheduleDate(year: currentMonth.year, month: currentMonth.month, day: currentDay)
                for schedule in schedules {
                    if schedule.schedule_date == currentDate{
                        
                        schedule.schedule_dayData.append(scheduleData)
                        _ = self.navigationController?.popViewController(animated: true)
                        return
                    }
                }
                let dayScheduleModel = DayScheduleModel()
                dayScheduleModel.schedule_date = currentDate
                dayScheduleModel.schedule_user_id = currentUser.user_id
                dayScheduleModel.schedule_dayData = [scheduleData]
                dailyScheduleVC.monthSchedule.append(dayScheduleModel)
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
    }
    @IBAction func viewOutSideTapped(_ sender: Any) {
        timeView.isHidden = true
        self.view.endEditing(true)
    }
    
}

extension AddScheduleViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if currentPickerStatus == CURRENT_PICKER_TIME{
            return 3
        }
        else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        if currentPickerStatus == CURRENT_PICKER_TIME {
            var result = 0
            if component == 0{
                result = 24
            }
            else if component == 2{
                result = 60
            }
            else{
                result = 1
            }
            return result
        }
        else {
            return CommonUtils.getDaysCount(month: currentMonth.month, year: currentMonth.year)
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentPickerStatus == CURRENT_PICKER_TIME {
            var result = ""
            
            if component == 1{
                result = ":"
            }
            else{
                result = "\(row)"
            }
            return result
        }
        else {
            return "\(row + 1)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentPickerStatus == CURRENT_PICKER_TIME {
            if showsTimePicker == SHOW_TIME_START {
                if component == 0
                {
                    scheduleData.start_time.hour = row
                }
                else if component == 2 {
                    scheduleData.start_time.minute = row
                }
                setStartTime()
            }
            else if showsTimePicker == SHOW_TIME_END {
                if component == 0
                {
                    scheduleData.end_time.hour = row
                }
                else if component == 2 {
                    scheduleData.end_time.minute = row
                }
                if checkEndTimeValid(){
                    setEndTime()
                }
            }
        }
        else{
            currentDay = row + 1
            dayButton.setTitle("\(currentDay)", for: .normal)
        }
        
    }

}
