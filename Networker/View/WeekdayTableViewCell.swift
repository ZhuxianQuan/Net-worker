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
    
    let selectedColor = UIColor(red: 24.0 / 255.0, green: 25.0 / 255.0, blue: 27.0 / 255.0, alpha: 1 )
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            
        }
        else {
            
        }
    }
    
    func setCell(_ schedule: Int) {
        
    }

}
