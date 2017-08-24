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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UIPickerView()
        picker.frame.size = CGSize(width: screenSize.width, height: 250)
        picker.backgroundColor = .white
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        fromTextField.inputView = picker
        
        toTextField.inputView = picker
        
        fromTextField.delegate = self
        toTextField.delegate = self
    }
    
    @IBAction func selectPreTime(_ sender: UIButton) {
        
        if sender.tag == 101 {
            
        }
        else if sender.tag == 102 {
            
        }
        else if sender.tag == 103 {
            
        }
        else if sender.tag == 104 {
            
        }
    }

    
    @IBAction func addScheduleButtonTapped(_ sender: Any) {
        
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
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return DateUtils.getString(from: times[row])
    }
    
}


extension AddScheduleViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == fromTextField {
            times.append(contentsOf: 1...48)
        }
        else if textField == toTextField {
            
        }
        return true
    }
}
