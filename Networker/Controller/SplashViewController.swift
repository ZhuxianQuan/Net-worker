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
    var locationChecked = false
    
    
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
        
        if UserDefaults.standard.value(forKey: Constants.KEY_USER_EMAIL) != nil {
            ApiFunctions.login(email: UserDefaults.standard.value(forKey: Constants.KEY_USER_EMAIL) as! String, password: UserDefaults.standard.value(forKey: Constants.KEY_USER_PASSWORD) as! String, completion: {
                message in
                self.loading += 1
                self.loadingCompleted()
            })
        }
        else {
            self.loading += 1
        }
        
        ApiFunctions.getSkillsArray(completion: {
            message in
            self.loading += 1
            
            self.loadingCompleted()
        })
        

    }
    
    func rotateLogoImage(){
        
        logoImage.transform = CGAffineTransform(rotationAngle: angle)
        angle += 0.1
        if !(currentLatitude == 0.0 && currentLongitude == 0.0) && !locationChecked {
            self.loading += 1
            locationChecked = true
            loadingCompleted()
        }
    }
    
    func gotoLoginPage(){
        
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.pushViewController(loginVC!, animated: true)
        
    }
    
    func loadingCompleted(){
        if loading == maxLoading{
            timer.invalidate()
            self.hideLoadingView()
            if loading == maxLoading{
                if currentUser != nil{
                    self.gotoMainScene()
                }
                else {
                    self.gotoLoginPage()
                }
            }
        }
    }

}
