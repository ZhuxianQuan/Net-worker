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
    @IBOutlet weak var reviewsTableView: UITableView!
    
    var reviews : [RatingModel] = []
    var skills: [SkillModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



extension ReviewsViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == skillsTableView {
            return skills.count
        }
        else if tableView == reviewsTableView {
            return reviews.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == skillsTableView {
            let skillCell = tableView.dequeueReusableCell(withIdentifier: "UserSkillsTableViewCell") as! UserSkillsTableViewCell
            let skill = skills[indexPath.row - 1]
            skillCell.setCell(skill)
            cell = skillCell
        }
        else if tableView == reviewsTableView {
            //return reviews.count
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    /*
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let user = matchedUsers[index]
        let cell = tableView.cellForRow(at: indexPath) as! MatchedUserTableViewCell
        let userDetailVC = storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        userDetailVC.user = user
        userDetailVC.userDataString = cell.userDataLabel.text!
        self.navigationController?.pushViewController(userDetailVC, animated: true)
        return UITableViewCell()
        
    }*/
}
