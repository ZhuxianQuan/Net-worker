//
//  BaseViewController.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import Toast_Swift

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func showToastWithDuration(string: String!, duration: Double) {
        self.view.makeToast(string, duration: duration, position: .bottom)
    }
    
    func showLoadingView()
    {
        self.view.makeToastActivity(.center)
        self.view.isUserInteractionEnabled = false
    }
    
    func hideLoadingView()
    {
        self.view.hideToastActivity()
        self.view.isUserInteractionEnabled = true
    }

    func gotoMainScene(){
        let storyboard = getStoryboard(id: Constants.STORYBOARD_MAIN)

        let mainTab = storyboard.instantiateViewController(withIdentifier: "MainTab") as! UITabBarController
        let navigations = mainTab.viewControllers as! [UINavigationController]
        var index = 2
        for navigation in navigations{
            navigation.viewControllers = [getNavRootViewController(index)]
            index += 1

        }
        present(mainTab, animated: true, completion: nil)
        
    }
    
    func getStoryboard(id: Int) -> UIStoryboard{
        switch id {
        case Constants.STORYBOARD_MAIN:
            return UIStoryboard(name: "Main", bundle: nil)
        case Constants.STORYBOARD_HOME:
            return UIStoryboard(name: "Home", bundle: nil)
        case Constants.STORYBOARD_SEARCH:
            return UIStoryboard(name: "Search", bundle: nil)
        case Constants.STORYBOARD_SCHEDULE:
            return UIStoryboard(name: "Schedule", bundle: nil)
        case Constants.STORYBOARD_FAVORITE:
            return UIStoryboard(name: "Favorite", bundle: nil)
        case Constants.STORYBOARD_CHATTING:
            return UIStoryboard(name: "Chatting", bundle: nil)
        default:
            return UIStoryboard(name: "Main", bundle: nil)
        }
    }
    
    func getNavRootViewController(_ id: Int) -> UIViewController{
        var storyboard : UIStoryboard!
        switch id {
        /*case Constants.STORYBOARD_MAIN:
            storyboard = UIStoryboard(name: "Main", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: "HomeViewController")*/
        case Constants.STORYBOARD_HOME:
            storyboard = UIStoryboard(name: "Home", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        case Constants.STORYBOARD_SEARCH:
            storyboard = UIStoryboard(name: "Search", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: "SearchMenuViewController")
        case Constants.STORYBOARD_SCHEDULE:
            storyboard = UIStoryboard(name: "Schedule", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: "ScheduleViewController")
        case Constants.STORYBOARD_FAVORITE:
            storyboard = UIStoryboard(name: "Favorite", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: "FavoriteViewController")
        case Constants.STORYBOARD_CHATTING:
            storyboard = UIStoryboard(name: "Chatting", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: "ChattingViewController")
        default:
            storyboard = UIStoryboard(name: "Home", bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        }
    }

}
