//
//  AddScheduleViewController.swift
//  Networker
//
//  Created by Big Shark on 27/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit


class AddScheduleViewController: BaseViewController {
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    //var schedule : DayScheduleModel!
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
        keyboardControl()
        days = DateUtils.getDaysArray()
    }
    
    @IBAction func addScheduleButtonTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        if startDay != 0 && endDay != 0 {
            if notesTextView.text.count > 0 {
                let events = EventSchedule.createEventsFrom(startDay: startDay, endDay: endDay, startTime: startTime, endTime: endTime, notes: notesTextView.text)
                
                self.showLoadingView()
                saveEvents(events, completion: {
                    message, schedules in
                    if message == Constants.PROCESS_SUCCESS {
                        ApiFunctions.saveChangedUserSchedule(schedules, completion: {
                            message in
                            self.hideLoadingView()
                            if message == Constants.PROCESS_SUCCESS {
                                self.dismiss(animated: true, completion: nil)
                            }
                            else {
                                self.showToastWithDuration(string: message, duration: 3.0)
                            }
                            
                        })
                    }
                    else {
                        self.hideLoadingView()
                        self.showToastWithDuration(string: message, duration: 3.0)
                    }
                })
            }
            else {
                self.showToastWithDuration(string: "Please input notes", duration: 3.0)
            }
        }
        else {
            self.showToastWithDuration(string: "Please select time", duration: 3.0)
        }
    }
    
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
        
    }
    
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddScheduleViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
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


extension AddScheduleViewController : UITextFieldDelegate {
    
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


extension AddScheduleViewController {
    
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
    
}

