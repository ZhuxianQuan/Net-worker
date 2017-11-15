//
//  ConfrimJobViewController.swift
//  Networker
//
//  Created by Quan Zhuxian on 11/15/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class ConfrimJobViewController: BaseViewController {

    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    
    
    
    
    
    var deal: DealModel!
    var times = [Int]()
    var days = [Int]()
    let picker = UIPickerView()
    
    var startDay = 0
    var endDay = 0
    var startTime = 0
    var endTime = 0
    
    
    var selectedDay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        startDay = deal.deal_startday
        endDay = deal.deal_endday
        startTime = deal.deal_starttime
        endTime = deal.deal_endtime
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func confirmJobButtonTapped(_ sender: Any) {
        
        deal.deal_startday = startDay
        deal.deal_endday = endDay
        deal.deal_starttime = startTime
        deal.deal_endtime = endTime
        let message = checkTimeValid(deal)
        
        if message == Constants.PROCESS_SUCCESS {
            /*ApiFunctions.updateDeal() {
                
            }*/
        }
        else {
            self.showToastWithDuration(string: message, duration: 3.0)
        }
    }
    
    @IBAction func cancelJobButtonTapped(_ sender: Any) {
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
    }
    
    
    
    func checkTimeValid(_ deal: DealModel) -> String {
        let days = DateUtils.getDaysArray(from: deal.deal_startday, to: deal.deal_endday)
        for daySchedule in currentUser!.user_schedules {
            if daySchedule.day < days[0] {
                continue
            }
            else if daySchedule.day > days.last! {
                break
            }
            else {
                for day in days {
                    if day == daySchedule.day && (daySchedule.day_schedule & Int64(1 << (deal.deal_endtime - deal.deal_starttime) - 1) << Int64(deal.deal_starttime - 1)) > 0 {
                        
                        return "Please check your schedule again."
                    }
                }
            }
        }
        
        return Constants.PROCESS_SUCCESS
    }
    
}





extension ConfrimJobViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return times.count
        }
        else {
            return days.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if fromTextField.isEditing {
            startDay = days[picker.selectedRow(inComponent: 0)]
            startTime = times[picker.selectedRow(inComponent: 1)]
            fromTextField.text = DateUtils.getShortDateString(dayValue: startDay) + ", " + DateUtils.getString(from: startTime)
            if endTime <= startTime || startDay > endDay{
                endTime = 0
                endDay = 0
                toTextField.text = ""
            }
        }
        else if toTextField.isEditing {
            endDay = days[picker.selectedRow(inComponent: 0)]
            endTime = times[picker.selectedRow(inComponent: 1)]
            toTextField.text = DateUtils.getShortDateString(dayValue: endDay) + ", " + DateUtils.getString(from: endTime)
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return DateUtils.getShortDateString(dayValue: days[row])
        }
        else if component == 1 {
            return DateUtils.getString(from: times[row])
        }
        return nil
    }
    
}


extension ConfrimJobViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        times = []
        days = []
        if textField == fromTextField {
            times.append(contentsOf: 17 ... 40)
            days = DateUtils.getDaysArray()
        }
        else if textField == toTextField {
            times.append(contentsOf: startTime + 1 ... 41)
            days = DateUtils.getDaysArray(from: startDay, to: 99999999)
        }
        self.picker.reloadAllComponents()
        return true
    }
}
