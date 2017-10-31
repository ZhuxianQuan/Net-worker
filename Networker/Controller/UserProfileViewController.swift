//
//  UserProfileViewController.swift
//  Networker
//
//  Created by Big Shark on 26/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class UserProfileViewController: BaseViewController {
    
    
    @IBOutlet weak var userDataLabel: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userSkillsTableView: UITableView!
    @IBOutlet weak var aboutMeTextView: UITextView!
    
    
    var deal : DealModel!
    var userDataString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
        userDataLabel.text = userDataString
        aboutMeTextView.text = deal.deal_worker.user_aboutme
        ratingView.rating = deal.deal_worker.user_avgmarks
        profileImageView.sd_setImage(with: URL(string: deal.deal_worker.user_profileimageurl), placeholderImage: UIImage(named: "icon_profile"))
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated : true)
        
    }
    @IBAction func availabilityButtonTapped(_ sender: Any) {
        
        self.showLoadingView()
        ApiFunctions.sendRequestToWorker(deal: deal, completion: {
            message, deal in
            self.hideLoadingView()
            if message == Constants.PROCESS_SUCCESS {
                self.deal = deal!
                self.showToastWithDuration(string: "Your request sent successfully", duration: 3.0)
                let chatVC = self.getStoryboard(id: Constants.STORYBOARD_CHATTING).instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
                chatVC.deal = deal!
                self.navigationController?.pushViewController(chatVC, animated: true)
            }
            else {
                self.showToastWithDuration(string: message, duration: 3.0)
            }
        })
        
    }
    
    @IBAction func reviewsButtonTapped(_ sender: Any) {
        self.showLoadingView()
        ApiFunctions.getWorkerReviews(deal.deal_worker.user_id, completion: {
            message, ratings, skill_marks in
            self.hideLoadingView()
            if message == Constants.PROCESS_SUCCESS {
                let reviewVC = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsViewController") as! ReviewsViewController
                reviewVC.reviews = ratings
                
                var skills = [SkillModel]()
                for skill in self.deal.deal_worker.user_skill_array {
                    if let skill_mark = skill_marks[skill.skill_id] {
                        skill.skill_ratings = skill_mark
                    }
                    skills.append(skill)
                }
                reviewVC.skills = skills
                
                self.navigationController?.pushViewController(reviewVC, animated: true)
                
            }
            else {
                self.showToastWithDuration(string: message, duration: 3.0)
            }
        })
    
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        drawerController?.setDrawerState(.opened, animated: true)
    }
   
}


extension UserProfileViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deal.deal_worker.user_skill_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillsTableViewCell")
        let index = indexPath.row
        cell?.textLabel?.text = "#" + deal.deal_worker.user_skill_array[index].skill_title
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 11)        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    
    
}



