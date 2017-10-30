//
//  ChatListViewController.swift
//  Networker
//
//  Created by Quan Zhuxian on 10/19/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class ChatListViewController: BaseViewController {
    
    var pendingDeals = [DealModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
    }
    
    @IBAction func workerButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func clientButtonTapped(_ sender: Any) {
        
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
}
