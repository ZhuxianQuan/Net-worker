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
        btnback = backButton
        loadMenu()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func itemTapped(_ sender: UIButton) {
        let index = (sender.tag - 10) / 10
        let skill = skills[index]
        let selectTimeVC = storyboard?.instantiateViewController(withIdentifier: "SelectTimeViewController") as! SelectTimeViewController
        let deal = DealModel()
        deal.deal_client = currentUser!
        deal.deal_status = Constants.VALUE_DEAL_PENDING
        deal.deal_skill = skill
        selectTimeVC.deal = deal
        self.view.isUserInteractionEnabled = false
        selectTimeVC.navController = self.navigationController
        self.view.endEditing(true)
        self.present(selectTimeVC, animated: true, completion: {
            self.view.isUserInteractionEnabled = true})

        
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
        skills = FMDBManagerGetData().getSkills()
        self.menuItemTableView.reloadData()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        drawerController?.setDrawerState(.opened, animated: true)
    }
}

extension SearchMenuViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skills.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMenuTableViewCell") as! SearchMenuTableViewCell
        
        let index = indexPath.row
        cell.setCell(skill: skills[index])
        cell.button.tag = index * 10 + 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension SearchMenuViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let keyword = searchText
        skills = FMDBManagerGetData().getSkills(keyword)
        menuItemTableView.reloadData()
    }
    
}
