//
//  LoginViewController.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit
import M13Checkbox

import FacebookCore
import FacebookLogin


class LoginViewController: BaseViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var checkBox: M13Checkbox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional ssadfdsasdasdetup after loading the view.
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

    
    //MARK: - Action Processsors
    @IBAction func loginButtonTapped(_ sender: Any) {

        doLogin()
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")
        self.navigationController?.pushViewController(registerVC!, animated: true)
    }
    
    
    @IBAction func facebookLoginButtonTapped(_ sender: Any) {
        
        let loginManager = LoginManager()
        
        loginManager.logIn([.publicProfile , .email, .userFriends], viewController: self, completion: {
            loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                self.getFBUserInfo()
            }
        })
    }
    
    
    func getFBUserInfo() {
        
        showLoadingView()
        let request = GraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, picture.type(large), email"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        request.start { (response, result) in
            
            switch result {
            case .success(let value):
                let result = value.dictionaryValue
                let resultData: [String: AnyObject] = result! as [String: AnyObject]
                
                
                let user = UserModel()
                user.user_firstname = resultData["first_name"] as! String
                user.user_lastname = resultData["last_name"] as! String
                user.user_email = resultData["email"] as! String
                user.user_email = Constants.VALUE_PASSWORD_FB
                user.user_profileimageurl = (((resultData["picture"] as! [String: AnyObject])["data"] as! [String: AnyObject])["url"] as? String)!
                ApiFunctions.register(user, completion: {
                    message in
                    if message == Constants.PROCESS_SUCCESS {
                        self.gotoMainScene()
                    }
                    else {
                        self.showToastWithDuration(string: message, duration: 3.0)
                    }
                })
            case .failed(let error):
                print(error)
                self.hideLoadingView()
            }
        }
    }
    
   
    
    @IBAction func linkedInButtonTapped(_ sender: Any) {
        
    }
    @IBAction func shareButtonTapped(_ sender: Any) {
        
    }
    
    //MARK: - functions using this class
    func checkValid() -> String {
    
        var result = Constants.PROCESS_SUCCESS
        if txtEmail.text!.characters.count == 0{
            result = Constants.CHECK_EMAIL_EMPTY
        }
        else if !CommonUtils.isValidEmail(txtEmail.text!) {
            result = Constants.CHECK_EMAIL_INVALID
        }
        else if txtPassword.text?.characters.count == 0{
            result = Constants.CHECK_PASSWORD_EMPTY
        }
        return result
    }
    
    //MARK: - login funciton
    
    func doLogin(){
        self.view.endEditing(true)
        let email = txtEmail.text!
        let password = txtPassword.text!
        let message = checkValid()
        if message != Constants.PROCESS_SUCCESS{
            showToastWithDuration(string: message , duration: 3.0)
        }
        else{
            showLoadingView()
            ApiFunctions.login(email: email, password: password, completion: {
                success in
                self.hideLoadingView()
                if success == Constants.PROCESS_SUCCESS
                {
                    self.gotoMainScene()
                }
                else
                {
                    self.showToastWithDuration(string: success, duration: 3.0)
                }
            })
        }
    }
    
    
    
}

extension LoginViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        }
        else if textField == txtPassword{
            
            doLogin()
        }
        
        return true
    }
}
