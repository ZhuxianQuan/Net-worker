//
//  ClientProfileViewController.swift
//  Networker
//
//  Created by Quan Zhuxian on 11/15/17.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class ClientProfileViewController: BaseViewController {
    
    @IBOutlet weak var userDataLabel: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var aboutMeTextView: UITextView!
    
    
    var deal : DealModel!
    var userDataString = ""
    
    var client: UserModel {
        get {
            return deal.deal_client
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        
        userDataLabel.text = client.user_firstname + " " + client.user_lastname
        aboutMeTextView.text = client.user_aboutme
        ratingView.rating = client.user_avgmarks
        profileImageView.sd_setImage(with: URL(string: client.user_profileimageurl), placeholderImage: UIImage(named: "icon_profile"))
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated : true)
        
    }
    
    @IBAction func reviewsButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        drawerController?.setDrawerState(.opened, animated: true)
    }
    
}
    
    
extension ClientProfileViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return client.user_ratings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as! ReviewTableViewCell
        cell.setCell(client.user_ratings[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
        
}




