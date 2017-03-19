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
    
    let STATUS_SKILL_SELECT = 1
    let STATUS_TAG_SELECT = 2
    
    var skill = SkillModel()
    var skillTags : [TagModel] = []
    var preDefinedSkills : [SkillModel] = []
    
    @IBOutlet weak var skillsTableView: UITableView!
    
    var stringArray : [String] = []
    
    override func viewDidLoad() {
        skillsTableView.isHidden = true
    }
    
    @IBAction func skillNameChanged(_ sender: UITextField) {
        status = STATUS_SKILL_SELECT
        let keyString = sender.text
        
        skillsTableView.isHidden = false
        
        
    }
    
    @IBAction func skillTagChanged(_ sender: UITextField) {
        status = STATUS_TAG_SELECT
        skillsTableView.isHidden = false
    }
   
    @IBAction func backButtonTapped(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    
}

extension AddSkillViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkillItemCell")
        cell?.detailTextLabel?.text = stringArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if status == STATUS_SKILL_SELECT {
            
        }
        else if status == STATUS_TAG_SELECT {
            
        }
    }
}
