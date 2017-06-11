//
//  SplashViewController.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit


class SplashViewController: BaseViewController {

    @IBOutlet weak var logoImage: UIImageView!
    
    var timer = Timer()
    var angle : CGFloat = 0
    
    var maxLoading = 3
    var loading = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(rotateLogoImage), userInfo: nil, repeats: true)
        updateLocalData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLocalData() {
        //showLoadingView()
        ApiFunctions.getSkillsArray(completion: {
            message, skills in
            self.loading += 1
            if message == Constants.PROCESS_SUCCESS {
                definedSkills = skills
            }
            self.loadingCompleted()
        })
        ApiFunctions.getTagsArray(completion: {
            message, tags in
            if message == Constants.PROCESS_SUCCESS {
                definedTags = tags
            }
            self.loading += 1
            self.loadingCompleted()
        })
        
        if UserDefaults.standard.value(forKey: Constants.KEY_USER_EMAIL) != nil {
            ApiFunctions.login(email: UserDefaults.standard.value(forKey: Constants.KEY_USER_EMAIL) as! String, password: UserDefaults.standard.value(forKey: Constants.KEY_USER_PASSWORD) as! String, completion: {
                message in
                self.gotoMainScene()
            })
        }
        else {
            self.loading += 1
        }

    }
    
    func rotateLogoImage(){
        
        logoImage.transform = CGAffineTransform(rotationAngle: angle)
        if angle >= 31.4159265359 {
            timer.invalidate()
            gotoLoginPage()
        }
        else{
            angle += 0.1
        }
    }
    
    func gotoLoginPage(){
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.pushViewController(loginVC!, animated: true)
        
    }
    
    func loadingCompleted(){
        //hideLoadingView()
        if loading == maxLoading {
            //gotoLoginPage()
        }
    }

}
