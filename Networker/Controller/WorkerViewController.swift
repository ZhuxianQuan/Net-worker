//
//  WorkerViewController.swift
//  Networker
//
//  Created by Quan Zhuxian on 11/15/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class WorkerViewController: BaseViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var aboutMeTextView: UITextView!
    @IBOutlet weak var aboutUserView: UILabel!
    
    @IBOutlet weak var avgRatingView: FloatRatingView!
    @IBOutlet weak var reviewsTableView: UITableView!
    
    var deal: DealModel!
    
    var user : UserModel {
        get {
            return deal.deal_worker
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImageView.sd_setImage(with: URL(string: user.user_profileimageurl), placeholderImage: #imageLiteral(resourceName: "icon_profile"))
        aboutMeTextView.text = user.user_aboutme
        aboutUserView.text = String(format: "%@ %@, £%.1lf/hr", user.user_firstname, user.user_lastname,  user.getSkillPrice(deal.deal_skill.skill_id))
        avgRatingView.rating = user.user_avgmarks
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        drawerController?.setDrawerState(.opened, animated: true)
    }
    
}



extension WorkerViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return user.user_skill_array.count
        }
        else if section == 1 {
            return user.user_ratings.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            let skillCell = tableView.dequeueReusableCell(withIdentifier: "UserSkillsTableViewCell") as! UserSkillsTableViewCell
            let skill = user.user_skill_array[indexPath.row]
            skillCell.setCell(skill)
            cell = skillCell
        }
        else if indexPath.section == 1 {
            let reviewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as! ReviewTableViewCell
            reviewCell.setCell(user.user_ratings[indexPath.row])
            cell = reviewCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Reviews"
        }
        else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        else {
            return 40
        }
    }
    
}
