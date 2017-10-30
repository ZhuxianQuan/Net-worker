//
//  ReviewsViewController.swift
//  Networker
//
//  Created by Big Shark on 26/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class ReviewsViewController: BaseViewController {

    @IBOutlet weak var skillsTableView: UITableView!
    
    var reviews : [RatingModel] = []
    var skills: [SkillModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        skillsTableView.estimatedRowHeight = 100
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func menuButtonTapped(_ sender: Any) {
        drawerController?.setDrawerState(.opened, animated: true)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}



extension ReviewsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return skills.count
        }
        else if section == 1 {
            return reviews.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
            let skillCell = tableView.dequeueReusableCell(withIdentifier: "UserSkillsTableViewCell") as! UserSkillsTableViewCell
            let skill = skills[indexPath.row]
            skillCell.setCell(skill)
            cell = skillCell
        }
        else if indexPath.section == 1 {
            let reviewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as! ReviewTableViewCell
            reviewCell.setCell(reviews[indexPath.row])
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
