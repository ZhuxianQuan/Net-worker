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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lasttimeLabel: UILabel!
    
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
            titleLabel.text = deal.deal_client.user_firstname + " " + deal.deal_client.user_lastname
            profileImageView.setImageWith(deal.deal_client.user_profileimageurl, placeholderImage: #imageLiteral(resourceName: "icon_profile"))
        }
        else {
            profileImageView.setImageWith(deal.deal_worker.user_profileimageurl, placeholderImage: #imageLiteral(resourceName: "icon_profile"))
        }
        
        descriptionLabel.text = deal.deal_notes
    }

}
