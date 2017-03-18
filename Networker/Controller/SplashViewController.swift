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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(rotateLogoImage), userInfo: nil, repeats: true)
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
    
    func rotateLogoImage(){
        
        logoImage.transform = CGAffineTransform(rotationAngle: angle)
        if angle >= 31.4159265359 {
            timer.invalidate()
            gotoLoginPage()
        }
        else{
            angle += 0.01
        }
    }
    
    func gotoLoginPage(){
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.pushViewController(loginVC!, animated: true)
        
    }

}
