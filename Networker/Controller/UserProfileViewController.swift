//
//  UserProfileViewController.swift
//  Networker
//
//  Created by Big Shark on 26/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class UserProfileViewController: BaseViewController {
    
    var user = UserModel()

    @IBOutlet weak var userDataLabel: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userSkillsTableView: UITableView!
    @IBOutlet weak var aboutMeTextView: UITextView!
    
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
        aboutMeTextView.text = user.user_aboutme
        ratingView.rating = user.user_avgmarks
        profileImageView.sd_setImage(with: URL(string: user.user_profileimageurl), placeholderImage: UIImage(named: "icon_profile"))
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated : true)
        
    }
    @IBAction func availabilityButtonTapped(_ sender: Any) {
        //let storyboard = getStoryboard(id : Constants.STORYBOARD_SCHEDULE)
        let scheduleVC = self.storyboard?.instantiateViewController(withIdentifier: "UserAvailabilityViewController") as! UserAvailabilityViewController
        scheduleVC.user = user
        self.navigationController?.pushViewController(scheduleVC, animated: true)
    }
    
    @IBAction func reviewsButtonTapped(_ sender: Any) {
        
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
        return user.user_skill_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillsTableViewCell")
        let index = indexPath.row
        cell?.textLabel?.text = "#" + user.user_skill_array[index].skill_title
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 11)        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    
    
}



