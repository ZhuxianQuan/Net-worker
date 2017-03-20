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
    
    func setCell(_ user: UserModel) {
        
    }

}
