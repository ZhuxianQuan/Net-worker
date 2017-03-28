//
//  FavoriteUserTableViewCell.swift
//  Networker
//
//  Created by Big Shark on 28/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteUserTableViewCell: UITableViewCell {
    

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username_label: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var connectionsLabel: UILabel!
    @IBOutlet weak var floatRatingView: FloatRatingView!
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ user: UserModel, status: Int) {
        /*profileImageView.sd_setImage(with: URL(string: user.user_profileimageurl), placeholderImage: UIImage(named: "icon_profile"))
        username_label.text = user.user_firstname + " " + user.user_lastname
        skillsLabel.text = "Top #s: dogwalking, helpshoppong, cooking"
        floatRatingView.rating = 3.5*/
        //connectionsLabel.text = "14 manual connections"
        if status == 0 {
            
            favoriteImageView.image = UIImage(named: "icon_like_filled")
        }
        else {
            favoriteImageView.image = UIImage(named: "icon_like")
        }
        
    }

}
