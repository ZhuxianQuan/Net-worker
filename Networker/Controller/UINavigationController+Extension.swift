
//

import UIKit

extension UINavigationController {
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        if let identifier = self.value(forKey: "storyboardIdentifier") {
            switch identifier as! String{
            case "HomeNav":
                self.viewControllers = [getNavRootViewController(Constants.STORYBOARD_HOME)]
                break
            case "SearchNav":
                self.viewControllers = [getNavRootViewController(Constants.STORYBOARD_SEARCH)]
                break
            case "ScheduleNav":
                self.viewControllers = [getNavRootViewController(Constants.STORYBOARD_SCHEDULE)]
                break
            case "FavoriteNav":
                self.viewControllers = [getNavRootViewController(Constants.STORYBOARD_FAVORITE)]
                break
            case "ChattingNav":
                self.viewControllers = [getNavRootViewController(Constants.STORYBOARD_CHATTING)]
                break
            default:
                return
            }
        }
        
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.popToRootViewController(animated: true)
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
            return storyboard.instantiateViewController(withIdentifier: "ChatListViewController")
        default:
            storyboard = getStoryboard(id: Constants.STORYBOARD_MAIN)
            return storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        }
    }
    

}

