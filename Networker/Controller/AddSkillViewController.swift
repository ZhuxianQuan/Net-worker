//
//  AddSkillViewController.swift
//  Networker
//
//  Created by Big Shark on 19/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import UIKit

class AddSkillViewController : BaseViewController {
    
    var status = 0
    @IBOutlet weak var skillNameText: UITextField!
    @IBOutlet weak var pricePerHour: UITextField!
    @IBOutlet weak var skillQualificationsText: UITextField!
    

    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    var selectedSkill = SkillModel()
    
    var preDefinedSkills : [SkillModel] = []
    var skills : [SkillModel] = []
    
    var fromWhere = 0
    
    let FROM_SKILLSVC = 1
    let FROM_MYSKILLSVC = 2
    
    @IBOutlet weak var skillsTableView: UITableView!
    
    var stringArray : [String] = []
    
    override func viewDidLoad() {
        skillsTableView.isHidden = true
        
    }
    
    @IBAction func skillNameChanged(_ sender: UITextField) {
        let keyString = sender.text!
        tableViewTopConstraint.constant = 2
        let matchedSkills = FMDBManagerGetData().getSkills(keyString)
        skills = []
        for skill in matchedSkills {
            var existing = false
            for preSkill in preDefinedSkills {
                if skill.skill_id == preSkill.skill_id {
                    existing = true
                    break
                }
            }
            if !existing {
                skills.append(skill)
            }
        }
        
        if skills.count == 0{
            skillsTableView.isHidden = true
        }
        else{
            skillsTableView.isHidden = false
            skillsTableView.reloadData()
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func addSkillButtonTapped(_ sender: Any) {
        
        if selectedSkill.skill_id > 0{
            
        }
        else{
            selectedSkill.skill_title = skillNameText.text!
        }
        if Double(pricePerHour.text!) != nil{
            selectedSkill.skill_price = Double(pricePerHour.text!)!
            selectedSkill.skill_qualifications = skillQualificationsText.text!
        }
        let vcs = navigationController?.viewControllers
        let skillVC = vcs?[(vcs?.count)! - 2]
        if fromWhere == FROM_SKILLSVC{
            if skillVC != nil{
                (skillVC as! SkillsViewController).user.user_skills.append(selectedSkill.skill_full_string)
            }
        }
        else if fromWhere == FROM_MYSKILLSVC {
            if skillVC != nil{
                (skillVC as! MySkillsViewController).user.user_skills.append(selectedSkill.skill_full_string)
            }
        }
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        skillsTableView.isHidden = true
        self.view.endEditing(true)
    }
    
    
}

extension AddSkillViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillItemCell")
        
        if index == 0{
            cell?.backgroundColor = UIColor.lightGray
        }
        else{
            cell?.backgroundColor = UIColor.white
        }
        cell?.textLabel?.text = "#" + skills[index].skill_title
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let skill = skills[indexPath.row]
        skillNameText.text = "#" + skill.skill_title
        //skillTagText.text = skill.getTagsString()
        selectedSkill = skill
        
        tableView.isHidden = true
    }
    
    
}
