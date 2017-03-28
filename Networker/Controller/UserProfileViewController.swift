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
    }
    
    @IBAction func availabilityButtonTapped(_ sender: Any) {
    }
    
    @IBAction func reviewsButtonTapped(_ sender: Any) {
    }
   
}


extension UserProfileViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.user_skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillsTableViewCell")
        let index = indexPath.row
        cell?.textLabel?.text = "#" + user.user_skills[index].skill_title
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 11)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    
    
}



