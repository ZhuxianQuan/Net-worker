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
    
    var schedule : DayScheduleModel!
    var times = [Int]()
    
    
    var event = EventSchedule()
    
    
    let picker = UIPickerView()
    
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
        event.day = schedule.day
        dayLabel.text = DateUtils.getDateString(dayValue: event.day)
    }
    
    @IBAction func selectPreTime(_ sender: UIButton) {
        selectButton(sender.tag)
    }
    
    func deselectButtons() {
        for tag in 101...104 {
            (self.view.viewWithTag(tag) as! UIButton).setTitleColor(.black, for: .normal)
        }
    }
    
    func selectButton(_ tag : Int) {
        
    }

    
    @IBAction func addScheduleButtonTapped(_ sender: Any) {
        if event.endTime > 0 && event.startTime > 0 {
            event.notes = notesTextView.text
            schedule.addEvent(event)
        }
    }
    
    @IBAction func outSideTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddScheduleViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if fromTextField.isEditing {
            event.startTime = times[row]
            fromTextField.text = DateUtils.getString(from: times[row])
            
            if event.endTime <= event.startTime {
                event.endTime = 0
                toTextField.text = ""
            }
        }
        else if toTextField.isEditing {
            event.endTime = times[row]
            toTextField.text = DateUtils.getString(from: times[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DateUtils.getString(from: times[row])
    }
    
}


extension AddScheduleViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        times = []
        if textField == fromTextField {
            times.append(contentsOf: 17 ... 40)
        }
        else if textField == toTextField {            
            times.append(contentsOf: event.startTime + 1 ... 41)
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
        if !fromTextField.isEditing && !toTextField.isEditing {
            self.keyboardControl(notification, isShowing: true)
        }
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
                if isShowing{
                    
                    self.view.frame.origin.y = -heightOffset + 60
                    
                }
                else
                {
                    //self.tblScroll.contentOffset.y -= keyboardRect!.height
                    self.view.frame.origin.y = 0
                    
                }
        },
            completion: {
                _ in
                if isShowing{
                    self.view.frame.origin.y = -heightOffset + 60
                    
                }
                else
                {
                    //self.tblScroll.contentOffset.y -= keyboardRect!.height
                    self.view.frame.origin.y = 0
                    
                }
        })
    }
    
}

