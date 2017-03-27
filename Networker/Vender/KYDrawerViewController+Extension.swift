//
//  KYDrawerViewController+Extension.swift
//  Networker
//
//  Created by Big Shark on 27/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import KYDrawerController

extension KYDrawerController {
    
    //override func prepare(

    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "main"){
            
            let storyboardId = self.value(forKey: "storyboardIdentifier") as! String
            switch  storyboardId{
            case "HomeDrawer":
                let nav = segue.destination as! UINavigationController
                nav.viewControllers = [getNavRootViewController(Constants.STORYBOARD_HOME)]
                break
            case "SearchDrawer":
                let nav = segue.destination as! UINavigationController
                nav.viewControllers = [getNavRootViewController(Constants.STORYBOARD_SEARCH)]
                break
            case "ScheduleDrawer":
                let nav = segue.destination as! UINavigationController
                nav.viewControllers = [getNavRootViewController(Constants.STORYBOARD_SCHEDULE)]
                break
            case "FavoriteDrawer":
                let nav = segue.destination as! UINavigationController
                nav.viewControllers = [getNavRootViewController(Constants.STORYBOARD_FAVORITE)]
                break
            case "ChattingDrawer":
                let nav = segue.destination as! UINavigationController
                nav.viewControllers = [getNavRootViewController(Constants.STORYBOARD_CHATTING)]
                break
            default:
                break
            }
        }
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
        case Constants.STORYBOARD_HOME:
            storyboard = getStoryboard(id: Constants.STORYBOARD_HOME)
            return storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        case Constants.STORYBOARD_SEARCH:
            storyboard = getStoryboard(id: Constants.STORYBOARD_SEARCH)
            return storyboard.instantiateViewController(withIdentifier: "SearchMenuViewController")
        case Constants.STORYBOARD_SCHEDULE:
            storyboard = getStoryboard(id: Constants.STORYBOARD_SCHEDULE)
            return storyboard.instantiateViewController(withIdentifier: "ScheduleViewController")
        case Constants.STORYBOARD_FAVORITE:
            storyboard = getStoryboard(id: Constants.STORYBOARD_FAVORITE)
            return storyboard.instantiateViewController(withIdentifier: "FavoriteViewController")
        case Constants.STORYBOARD_CHATTING:
            storyboard = getStoryboard(id: Constants.STORYBOARD_CHATTING)
            return storyboard.instantiateViewController(withIdentifier: "ChattingViewController")
        default:
            storyboard = getStoryboard(id: Constants.STORYBOARD_MAIN)
            return storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        }
    }

}
