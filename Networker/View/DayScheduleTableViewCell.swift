//
//  DayScheduleTableViewCell.swift
//  Networker
//
//  Created by Big Shark on 28/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class DayScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var workingTitleLabel: UILabel!
    @IBOutlet weak var scheduleTagColorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ dayScheduleData: ScheduleData) {
        startTimeLabel.text = "\(dayScheduleData.start_time.hour):\(dayScheduleData.start_time.minute)"
        endTime.text = "\(dayScheduleData.end_time.hour):\(dayScheduleData.end_time.minute)"
        workingTitleLabel.text = dayScheduleData.work_title
        scheduleTagColorView.backgroundColor = UIColor(red: dayScheduleData.tag_color.red, green: dayScheduleData.tag_color.green, blue: dayScheduleData.tag_color.blue, alpha: dayScheduleData.tag_color.alpha)
    }

}
