//
//  MatchedUserTableViewCell.swift
//  Networker
//
//  Created by Big Shark on 20/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class MatchedUserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userDataLabel: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ user: UserModel, skill_id : Int) {
        //userDataLabel.text = "\(user.user_firstname) : \(getDistance)m"
        userDataLabel.text = String(format: "%@ : %.2lfm dist, £%.1lf/hr", user.user_firstname, CommonUtils.getDistanceFromMe(user), user.getSkillPrice(skill_id))
        ratingView.rating = user.user_avgmarks
    }
    

}
