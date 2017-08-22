//
//  SearchMenuTableViewCell.swift
//  Networker
//
//  Created by Big Shark on 20/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class SearchMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var menuItemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(skill : SkillModel?) {
        if skill != nil{
            menuItemLabel.text = "#" + skill!.skill_title
            menuItemLabel.font = UIFont.systemFont(ofSize: 20)//(systemFont(ofSize fontSize: CGFloat))
        }
        else{
            menuItemLabel.text = "Search Near me"
            menuItemLabel.underlineText()
            
        }
    }

}
