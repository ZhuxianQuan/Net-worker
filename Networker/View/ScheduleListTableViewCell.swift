//
//  ScheduleListTableViewCell.swift
//  Networker
//
//  Created by Big Shark on 28/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class ScheduleListTableViewCell: UITableViewCell {

    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ scheduleData : DealModel?) {
        if scheduleData == nil {
            jobLabel.text = "Job"
            dateLabel.text = "Date"
            startTimeLabel.text = "Start"
            endTimeLabel.text = "End"
            usernameLabel.text = "Who"
            statusLabel.text = "Status"
            jobLabel.textColor = UIColor.white
            dateLabel.textColor = UIColor.white
            endTimeLabel.textColor = UIColor.white
            startTimeLabel.textColor = UIColor.white
            usernameLabel.textColor = UIColor.white
            statusLabel.textColor = UIColor.white
            self.contentView.backgroundColor = UIColor.black
            
        }
        else{
            //jobLabel.text = scheduleDat
        }
    }

}
