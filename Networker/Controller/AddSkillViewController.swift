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
    @IBOutlet weak var skillTagText: UITextField!
    
    @IBOutlet weak var pricePerHour: UITextField!
    @IBOutlet weak var skillQualificationsText: UITextField!
    
    let STATUS_SKILL_SELECT = 1
    let STATUS_TAG_SELECT = 2
    

    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    var selectedSkill = SkillModel()
    
    var preDefinedSkills : [SkillModel] = []
    var skills : [SkillModel] = []
    var tags : [TagModel] = []
    var customTags : [TagModel] = []
    
    var fromWhere = 0
    
    let FROM_SKILLSVC = 1
    
    @IBOutlet weak var skillsTableView: UITableView!
    
    var stringArray : [String] = []
    
    override func viewDidLoad() {
        skillsTableView.isHidden = true
        
    }
    
    @IBAction func skillNameChanged(_ sender: UITextField) {
        status = STATUS_SKILL_SELECT
        let keyString = sender.text!
        tableViewTopConstraint.constant = 2
        skills = FMDBManagerGetData.getMatchedSkills(keyword: keyString, skills: preDefinedSkills)
        if skills.count == 0{
            skillsTableView.isHidden = true
        }
        else{
            skillsTableView.isHidden = false
            skillsTableView.reloadData()
        }
    }
    
    @IBAction func skillTagChanged(_ sender: UITextField) {
        status = STATUS_TAG_SELECT
        let keyString = sender.text!
        tableViewTopConstraint.constant = 44
        tags = FMDBManagerGetData.getMatchedTags(keyword: keyString, tags: definedTags)
        if tags.count == 0{
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
        if fromWhere == FROM_SKILLSVC{
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
            if skillVC != nil{
                (skillVC as! SkillsViewController).user.user_skills.append(selectedSkill)
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
        if status == STATUS_SKILL_SELECT {
            return skills.count
        }
        else if status == STATUS_TAG_SELECT {
            return tags.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillItemCell")
        if status == STATUS_SKILL_SELECT {
            if index == 0{
                cell?.backgroundColor = UIColor.lightGray
            }
            else{
                cell?.backgroundColor = UIColor.white
            }
            cell?.textLabel?.text = "#" + skills[index].skill_title
        }
        else if status == STATUS_TAG_SELECT{
            if index == 0{
                cell?.backgroundColor = UIColor.lightGray
            }
            else{
                cell?.backgroundColor = UIColor.white
            }
            cell?.textLabel?.text = "#" + tags[index].tag_string
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if status == STATUS_SKILL_SELECT{
            let skill = skills[indexPath.row]
            skillNameText.text = "#" + skill.skill_title
            skillTagText.text = skill.getTagsString()
            selectedSkill = skill
        }
        else if status == STATUS_TAG_SELECT{
            let tag = tags[indexPath.row]
            if skillTagText.text!.characters.count > 0{
                skillTagText.text = skillTagText.text! + ", #" + tag.tag_string
            }
            else {
                skillTagText.text = "#" + tag.tag_string
            }
            customTags.append(tag)
        }
        tableView.isHidden = true
    }
}
