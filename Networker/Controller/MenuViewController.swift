//
//  MainViewController.swift
//  Networker
//
//  Created by Big Shark on 27/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var menuItemTable: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var floatRatingView: FloatRatingView!
    
    let menuStringArray = [Constants.SIDE_MENU_PERSONAL_DETAILS, Constants.SIDE_MENU_SKILLS, Constants.SIDE_MENU_AVAILABILITY, Constants.SIDE_MENU_JOBS_PENDING, Constants.SIDE_MENU_JOBS_COMPLETED, Constants.SIDE_MENU_ABOUT_NETWORKER, Constants.SIDE_MENU_CONTACT_US, Constants.SIDE_MENU_RATE_OUR_APP, Constants.SIDE_MENU_TERMSANDCONDITIONS, Constants.SIDE_MENU_SIGN_OUT]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUserInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUserInfo() {
        nameLabel.text = currentUser.user_firstname
        profileImageView.setImageWith(currentUser.user_profileimageurl, placeholderImage: UIImage(named: "icon_profile")!)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showView(_ index: Int) {
        let title = menuStringArray[index]
        
        switch  title {
        case Constants.SIDE_MENU_SIGN_OUT:
            CommonUtils.logout()
            self.gotoLoginScence()
            break
        case "Personal details":
            break
        case "Availability":
            break
        default:
            break
        }
    }

}

extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuStringArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell")
        cell?.textLabel?.text = menuStringArray[index]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //func didselect
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        showView(index)
        
    }
}
