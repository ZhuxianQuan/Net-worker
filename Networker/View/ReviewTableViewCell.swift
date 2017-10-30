//
//  ReviewTableViewCell.swift
//  Networker
//
//  Created by Big Shark on 26/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ review: RatingModel) {
        nameLabel.text = String(format: "From %@, %@:", review.rating_sendername, DateUtils.getDateString(timestamp: review.rating_timestamp))
        reviewLabel.text = review.rating_comment
        ratingView.rating = review.rating_marks
    }

}
