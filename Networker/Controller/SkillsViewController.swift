//
//  SkillsViewController.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import M13Checkbox
import Stripe


class SkillsViewController: BaseViewController {
    
    
    @IBOutlet weak var skillsTableView: UITableView!

    @IBOutlet weak var agreementCheck: M13Checkbox!
    
    @IBOutlet weak var cardView: STPPaymentCardTextField!
    
    @IBOutlet weak var availableSwitch: UISwitch!
    @IBOutlet weak var continueButton: UIButton!
    
    
    var user = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        skillsTableView.estimatedRowHeight = 50
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        skillsTableView.reloadData()
        //skillsViewHeightConstraint.constant = skillsTableView.contentSize.height
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
        self.view.endEditing(true)
    }

    @IBAction func addSkill(_ sender: Any) {
        self.view.endEditing(true)
        let addSkillVC = storyboard?.instantiateViewController(withIdentifier: "AddSkillViewController") as! AddSkillViewController
        addSkillVC.fromWhere = addSkillVC.FROM_SKILLSVC
        addSkillVC.preDefinedSkills = user.user_skill_array
        navigationController?.pushViewController(addSkillVC, animated: true)
    }
    
    
    @IBAction func skillsTableViewTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        
        if agreementCheck.checkState == .checked {
            if availableSwitch.isOn {
                self.user.user_available = Constants.VALUE_USER_AVAILABLE
                
            }
            let params = [Constants.KEY_USER_ID : user.user_id as AnyObject,
                          Constants.KEY_USER_SKILLS : user.user_skills as AnyObject,
                          Constants.KEY_USER_AVAILABLE : user.user_available as AnyObject]
            self.showLoadingView()
            ApiFunctions.updateProfile(profile: params, completion: {
                message in
                self.hideLoadingView()
                if message == Constants.PROCESS_SUCCESS {
                    currentUser?.user_skills = self.user.user_skills
                    currentUser?.user_available = self.user.user_available
                    self.gotoMainScene()
                }
                else {
                    self.showToastWithDuration(string: message, duration: 3.0)
                }
                
            })
        }
        else
        {
            self.showToastWithDuration(string: "You should agree terms and conditions", duration: 3.0)
        }
        
    }
}

extension SkillsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            return user.user_skill_array.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillsTableViewCell") as! SkillsTableViewCell
        if indexPath.section == 0 {
            cell.contentView.backgroundColor = UIColor.black
            cell.skillTitleLabel.text = "#skills"
            cell.taggedWordsLabel.text = "Tagged words#"
            cell.priceLabel.text = "Price per Hour"
            cell.qualificationLabel.text = "Qualifications"
            cell.setCellTextColor(UIColor.white)
        }
        else{
            let index = indexPath.row
            cell.contentView.backgroundColor = UIColor.lightGray
            cell.setCellTextColor(UIColor.darkText)
            cell.setCellText(user.user_skill_array[index])
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if editingStyle == .delete {
                let selectedSkill = user.user_skill_array[indexPath.row]
                user.user_skills = user.user_skills.replacingOccurrences(of: selectedSkill.skill_full_string, with: "")
                tableView.reloadData()
            }
        }
    }    
    
}
