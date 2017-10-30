//
//  UserSkillsTableViewCell.swift
//  Networker
//
//  Created by Big Shark on 26/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class UserSkillsTableViewCell: UITableViewCell {

    @IBOutlet weak var skillTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ skill : SkillModel){
        skillTitleLabel.text = "#\(skill.skill_title)"
        priceLabel.text = "£\(skill.skill_price)"
        ratingView.rating = skill.skill_ratings
        
    }

}
