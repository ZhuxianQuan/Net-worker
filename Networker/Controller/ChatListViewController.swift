//
//  ChatListViewController.swift
//  Networker
//
//  Created by Quan Zhuxian on 10/19/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class ChatListViewController: BaseViewController {
    
    var pendingDeals : [DealModel] {
        if selected {
            return pendingWorkingDeals
        }
        else {
            return pendingMyDeals
        }
    }
    @IBOutlet weak var workerButton: UIButton!
    @IBOutlet weak var clientButton: UIButton!
    
    
    @IBOutlet weak var dealsTableView: UITableView!
    var selected = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dealsTableView.reloadData()
        workerButtonTapped("")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        drawerController?.setDrawerState(.opened, animated: true)
    }
    
    @IBAction func workerButtonTapped(_ sender: Any) {
        selected = true
        workerButton.backgroundColor = UIColor.white
        workerButton.setTitleColor(UIColor.black, for: .normal)
        clientButton.backgroundColor = UIColor.black
        clientButton.setTitleColor(UIColor.white, for: .normal)
        dealsTableView.reloadData()
    }
    
    @IBAction func clientButtonTapped(_ sender: Any) {
        selected = false
        clientButton.backgroundColor = UIColor.white
        clientButton.setTitleColor(UIColor.black, for: .normal)
        workerButton.backgroundColor = UIColor.black
        workerButton.setTitleColor(UIColor.white, for: .normal)
        dealsTableView.reloadData()
    }
    
    
}

extension ChatListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingDeals.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListTableViewCell") as! ChatListTableViewCell
        cell.setCell(pendingDeals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
