//
//  SkillsViewController.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import M13Checkbox
class SkillsViewController: BaseViewController {
    
    
    @IBOutlet weak var skillsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var skillsTableView: UITableView!

    @IBOutlet weak var agreementCheck: M13Checkbox!
    
    @IBOutlet weak var paymentName: UITextField!
    @IBOutlet weak var paymentAccountNo: UITextField!
    @IBOutlet weak var paymentSortCode: UITextField!
    
    @IBOutlet weak var availableSwitch: UISwitch!
    @IBOutlet weak var continueButton: UIButton!
    
    
    
    var skillsArray: [SkillModel] = []
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
        self.view.endEditing(true)
    }

    @IBAction func addSkill(_ sender: Any) {
        self.view.endEditing(true)
        let addSkillVC = storyboard?.instantiateViewController(withIdentifier: "AddSkillViewController") as! AddSkillViewController
        addSkillVC.fromWhere = addSkillVC.FROM_SKILLSVC
        addSkillVC.preDefinedSkills = FMDBManagerGetData.removeSkills(existing: skillsArray, defined: definedSkills)
        navigationController?.pushViewController(addSkillVC, animated: true)
    }
    
    @IBAction func connectPaypalButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func skillsTableViewTapped(_ sender: Any) {
        self.view.endEditing(true)
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
            return skillsArray.count
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
            cell.setCellText(skillsArray[index])
            
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}
