//
//  SearchMenuViewController.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class SearchMenuViewController: BaseViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var menuItemTableView: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var skills : [SkillModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func itemTapped(_ sender: UIButton) {
        let index = (sender.tag - 10) / 10
        if index == 0 {
            let storyboard = getStoryboard(id: Constants.STORYBOARD_HOME)
            let homevc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController?.pushViewController(homevc, animated: true)
        }
        else {
            let skill = skills[index - 1]
            let skilledUserVC = storyboard?.instantiateViewController(withIdentifier: "SearchMatchedUsersViewController") as! SearchMatchedUsersViewController
            skilledUserVC.skill = skill
            navigationController?.pushViewController(skilledUserVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if navigationController!.viewControllers.count > 1{
            backButton.isHidden = false
        }
        else {
            backButton.isHidden = true
        }
    }
    func loadMenu(){
        skills = definedSkills
        
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

extension SearchMenuViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMenuTableViewCell") as! SearchMenuTableViewCell
        
        let index = indexPath.row
        if index == 0 {
            cell.setCell(skill: nil)
        }
        else {
            cell.setCell(skill: skills[index - 1])
            
        }
        
        cell.button.tag = index * 10 + 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension SearchMenuViewController : UISearchBarDelegate {
    
}
