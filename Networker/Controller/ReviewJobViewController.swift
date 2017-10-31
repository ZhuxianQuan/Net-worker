//
//  ReviewJobViewController.swift
//  Networker
//
//  Created by Quan Zhuxian on 10/31/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class ReviewJobViewController: BaseViewController {
    
    
    var deal : DealModel!

    @IBOutlet weak var descriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    

    
    @IBAction func rejectButtonTapped(_ sender: Any) {
        ApiFunctions.rejectRequest(deal.request_id) { (message) in
            if message == Constants.PROCESS_SUCCESS {
                
            }
            else {
                self.showToastWithDuration(string: message, duration: 3.0)
            }
        }
    }
    
    
    @IBAction func chatButtonTapped(_ sender: Any) {
        self.deal = deal!
        self.showToastWithDuration(string: "Your request sent successfully", duration: 3.0)
        let chatVC = self.getStoryboard(id: Constants.STORYBOARD_CHATTING).instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        chatVC.deal = deal
        self.navigationController?.pushViewController(chatVC, animated: true)
    }

}
