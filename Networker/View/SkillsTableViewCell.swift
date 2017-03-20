//
//  SkillsTableViewCell.swift
//  Networker
//
//  Created by Big Shark on 17/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {

    @IBOutlet weak var skillTitleLabel: UILabel!
    @IBOutlet weak var taggedWordsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var qualificationLabel: UILabel!
    
    var skill : SkillModel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellTextColor(_ color : UIColor)
    {
        skillTitleLabel.textColor = color
        taggedWordsLabel.textColor = color
        priceLabel.textColor = color
        qualificationLabel.textColor = color
    }
    
    func setCellText(_ skill : SkillModel)
    {
        self.skill = skill
        skillTitleLabel.text = "#" + skill.skill_title
        taggedWordsLabel.text = skill.getTagsString()
        priceLabel.text = "£\(skill.skill_price)"
        qualificationLabel.text = skill.skill_qualifications
        
    }

}
