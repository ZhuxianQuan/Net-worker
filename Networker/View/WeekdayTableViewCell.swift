//
//  WeekdayTableViewCell.swift
//  Networker
//
//  Created by Quan Zhuxian on 24/08/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class WeekdayTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    let deSelectedColor = UIColor(hex: 0x383F4A)
    let selectedColor = UIColor(hex: 0x23AC9A)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func setCell(_ day: Int, weekday: Int) {
        
        dayLabel.layer.cornerRadius = 15
        /*
        dayLabel.text = "\(day % 100)"
        weekDayLabel.text = DateUtils.getWeekdayString(weekday)*/
        if day >= DateUtils.getDayValue(Date()) {
            dayLabel.textColor = .white
            weekDayLabel.textColor = .white
            monthLabel.textColor = .white
            dayLabel.layer.borderColor = UIColor.white.cgColor
            dayLabel.text = "\(day % 100)"
            let month = (day / 100) % 100
            let monthstr = DateUtils.getMonthName(month)
            let index = monthstr.index(monthstr.startIndex, offsetBy: 3)
            monthLabel.text = monthstr.substring(to: index)
            weekDayLabel.text = DateUtils.getWeekdayString(weekday)
        }
        else {
            dayLabel.textColor = .clear
            weekDayLabel.textColor = .clear
            monthLabel.textColor = .clear
            dayLabel.layer.borderColor = UIColor.clear.cgColor
        }
        
    }
    
    func selectCell(_ selected: Bool){
        if selected == true {
            self.contentView.backgroundColor = selectedColor
            dayLabel.layer.masksToBounds = true
            dayLabel.layer.borderWidth = 1
        }
        else {
            self.contentView.backgroundColor = deSelectedColor
            dayLabel.layer.masksToBounds = false
            dayLabel.layer.borderWidth = 0
        }
    }
    

}
