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
    
    func setCell(_ event: EventSchedule) {
        startTimeLabel.text = DateUtils.getString(from: event.startTime)
        endTime.text = DateUtils.getString(from: event.endTime)
        workingTitleLabel.text = event.notes
        
    }

}
