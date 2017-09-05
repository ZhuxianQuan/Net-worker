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
    var users : [UserModel] = []
    //var currentIndex = 0
    var isLast = false
    
    var deal: DealModel!
    
    
    var skillMatchedUsers = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.placeholder = "#" + deal.deal_skill.skill_title
        getSkillMatchedUsers()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func getSkillMatchedUsers() {
        self.showLoadingView()
        ApiFunctions.getSkillMatchedUsers(deal: deal, completion: {
            message, users in
            self.hideLoadingView()
            if message == Constants.PROCESS_SUCCESS {
                self.skillMatchedUsers = users
                self.users = users
                self.matchedUsersTableView.reloadData()
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
        cell.setCell(users[index], skill_id: deal.deal_skill.skill_id)
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
        users = CommonUtils.getMatchedUsers(keyword: searchText, users: skillMatchedUsers)
        self.matchedUsersTableView.reloadData()
    }
    
}
