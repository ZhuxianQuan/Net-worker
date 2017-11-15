//
//  SelectTimeViewController.swift
//  Networker
//
//  Created by Quan Zhuxian on 05/09/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class SelectTimeViewController: BaseViewController {

    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    
    var navController : UINavigationController?
    
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
        picker.frame.size = CGSize(width: screenSize.width, height: 200)
        picker.backgroundColor = .white
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        fromTextField.inputView = picker
        toTextField.inputView = picker
        fromTextField.delegate = self
        toTextField.delegate = self
        //keyboardControl()
        days = DateUtils.getDaysArray()
    }
    
    @IBAction func addScheduleButtonTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        if startDay != 0 && endDay != 0 {
            if notesTextView.text.count > 0 {
                deal.deal_startday = startDay
                deal.deal_endday = endDay
                deal.deal_starttime = startTime
                deal.deal_endtime = endTime
                deal.deal_distance = distanceSlider.value
                deal.deal_notes = notesTextView.text
                
                let message = checkTimeValid(deal)
                if message == Constants.PROCESS_SUCCESS {
                    let selectedUserVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchMatchedUsersViewController") as! SearchMatchedUsersViewController
                    selectedUserVC.deal = self.deal
                    self.dismiss(animated: true, completion: {
                        self.navController?.pushViewController(selectedUserVC, animated: true)
                    })
                }
                else {
                    self.showToastWithDuration(string: message, duration: 3.0)
                }
                
            }
            else {
                self.showToastWithDuration(string: "Please input notes", duration: 3.0)
            }
        }
        else {
            self.showToastWithDuration(string: "Please select time", duration: 3.0)
        }
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        
        //set default value : time today 0:00 ~ 23:59
        deal.deal_startday = DateUtils.getDayValue(Date())
        deal.deal_endday = DateUtils.getDayValue(Date())
        deal.deal_starttime = 1
        deal.deal_endtime = 48
        deal.deal_distance = distanceSlider.value
        let message = checkTimeValid(deal)
        if message == Constants.PROCESS_SUCCESS {
        
            let selectedUserVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchMatchedUsersViewController") as! SearchMatchedUsersViewController
            selectedUserVC.deal = self.deal
            self.dismiss(animated: true, completion: {
                self.navController?.pushViewController(selectedUserVC, animated: true)
            })
        }
        else {
            self.showToastWithDuration(string: message, duration: 3.0)
        }
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
    /*
    func saveEvents(_ events: [EventSchedule], completion: @escaping (String, [DayScheduleModel]) -> ()) {
        var leftEvents = events
        var changedScheules = [DayScheduleModel]()
        let schedules = currentUser!.user_schedules
        
        for schedule in schedules {
            if schedule.day <= endDay{
                if schedule.day >= startDay {
                    for event in leftEvents {
                        if schedule.day > event.day {
                            let schedule = DayScheduleModel()
                            schedule.user_id = currentUser!.user_id
                            schedule.day = event.day
                            schedule.day_schedule = event.eventTimeValue
                            schedule.addEvent(event, completion: {
                                message in
                                changedScheules.append(schedule)
                                if changedScheules.count == events.count {
                                    completion(Constants.PROCESS_SUCCESS, changedScheules)
                                }
                            })
                            leftEvents.remove(at: 0)
                            continue
                        }
                        else if schedule.day == event.day {
                            schedule.addEvent(event, completion: {
                                message in
                                changedScheules.append(schedule)
                                if changedScheules.count == events.count {
                                    completion(Constants.PROCESS_SUCCESS, changedScheules)
                                }
                            })
                            leftEvents.remove(at: 0)
                            break
                        }
                        
                    }
                }
            }
            else {
                break
            }
            
        }
        
        for event in leftEvents {
            let schedule = DayScheduleModel()
            schedule.user_id = currentUser!.user_id
            schedule.day = event.day
            schedule.day_schedule = event.eventTimeValue
            schedule.addEvent(event, completion: {
                message in
                changedScheules.append(schedule)
                if changedScheules.count == events.count {
                    completion(Constants.PROCESS_SUCCESS, changedScheules)
                }
            })
            leftEvents.remove(at: 0)
        }
        
    }*/
    
    
    @IBAction func distanceChanged(_ sender: UISlider) {
        distanceLabel.text = String(format: "%.1lfmile", sender.value)
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}

extension SelectTimeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
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


extension SelectTimeViewController : UITextFieldDelegate {
    
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
/*

extension SelectTimeViewController {
    
    func keyboardControl() {
        /**
         Keyboard notifications
         */
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: .UIKeyboardDidHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification)
    {
        //if !fromTextField.isEditing && !toTextField.isEditing {
        self.keyboardControl(notification, isShowing: true)
        //}
    }
    
    func keyboardDidShow(_ notification: Notification)
    {
        
    }
    func keyboardWillHide(_ notification: Notification)
    {
        self.keyboardControl(notification, isShowing: false)
    }
    func keyboardDidHide(_ notification: Notification)
    {
        
    }
    
    func keyboardControl(_ notification: Notification, isShowing: Bool)
    {
        
        var userInfo = notification.userInfo!
        let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        let curve = (userInfo[UIKeyboardAnimationCurveUserInfoKey]! as AnyObject).uint32Value
        
        let convertedFrame = self.view.convert(keyboardRect!, from: nil)
        let heightOffset = self.view.bounds.size.height - convertedFrame.origin.y
        let options = UIViewAnimationOptions(rawValue: UInt(curve!) << 16 | UIViewAnimationOptions.beginFromCurrentState.rawValue)
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey]! as AnyObject).doubleValue
        
        
        UIView.animate(
            withDuration: duration!,
            delay: 0,
            options: options,
            animations: {
                
        },
            completion: {
                _ in
                if isShowing{
                    self.view.frame.origin.y = 0
                    self.viewTopConstraint.constant = -heightOffset + 120
                }
                else
                {
                    //self.tblScroll.contentOffset.y -= keyboardRect!.height
                    self.view.frame.origin.y = 0
                    self.viewTopConstraint.constant = 60
                    
                }
        })
    }
    
}*/

