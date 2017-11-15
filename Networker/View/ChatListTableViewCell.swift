//
//  ChatListTableViewCell.swift
//  Networker
//
//  Created by Quan Zhuxian on 10/19/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var skillLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ deal: DealModel) {
        if deal.deal_worker.user_id == currentUser?.user_id {
            profileImageView.sd_setImage(with: URL(string: deal.deal_client.user_profileimageurl), placeholderImage: #imageLiteral(resourceName: "icon_profile"))
        }
        else {
            
            profileImageView.sd_setImage(with: URL(string: deal.deal_worker.user_profileimageurl), placeholderImage: #imageLiteral(resourceName: "icon_profile"))
        }
        if deal.deal_notes.count > 0 {
            descriptionLabel.text = deal.deal_notes
        }
        else {
            descriptionLabel.text = "No Description."
        }
        skillLabel.text = "#" + deal.deal_skill.skill_title
        timeLabel.text = CommonUtils.getTimeString(from: Int64(Date().timeIntervalSince1970) - deal.request_timestamp)
    }

}
