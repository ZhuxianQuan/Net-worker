//
//  SearchMatchedUsersViewController.swift
//  Networker
//
//  Created by Big Shark on 20/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class SearchMatchedUsersViewController: BaseViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchFilterLabel: UILabel!
    
    @IBOutlet weak var matchedUsersTableView: UITableView!
    var skill = SkillModel()
    var users : [UserModel] = []
    var currentIndex = 0
    var isLast = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.placeholder = "#" + skill.skill_title
        getSkillMatchedUsers()
    
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
    }
    
    func getSkillMatchedUsers() {
        
        ApiFunctions.getSkillMatchedUsers(skill.skill_id, filter: "name:" + searchBar.text!, day: DateUtils.getDayValue(Date()), time: 0xFFFFFF << 16, index: currentIndex, completion: {
            message, users in
            if message == Constants.PROCESS_SUCCESS {
                if users.count == 0 {
                    self.isLast = true
                }
                self.users.append(contentsOf: users)
                self.matchedUsersTableView.reloadData()
            }
        })
    }
}


extension SearchMatchedUsersViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchedUserTableViewCell") as! MatchedUserTableViewCell
        let index = indexPath.row
        cell.setCell(users[index], skill_id: skill.skill_id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let user = users[index]
        let cell = tableView.cellForRow(at: indexPath) as! MatchedUserTableViewCell
        let userDetailVC = storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        userDetailVC.user = user
        userDetailVC.hidesBottomBarWhenPushed = true
        userDetailVC.userDataString = cell.userDataLabel.text!
        self.navigationController?.pushViewController(userDetailVC, animated: true)
        
    }
}

extension SearchMatchedUsersViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getSkillMatchedUsers()
        
    }
}
