//
//  RegisterViewController.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet weak var tblScroll: UITableView!
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    var profileImage : UIImage!
    var picker = UIImagePickerController()
    
    @IBOutlet weak var imvProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        keyboardControl()
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
    @IBAction func backButtonTapped(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func contentViewTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func registerButtonTapped(_ sender: Any) {
        let skillVC = storyboard?.instantiateViewController(withIdentifier: "SkillsViewController") as! SkillsViewController
        navigationController?.pushViewController(skillVC, animated: true)
    }
    
    
    @IBAction func profileImageTapped(_ sender: UIButton) {
        selectImageSource()
    }

}

// MARK: - @extension SinglePostVC
extension RegisterViewController {
    
    func keyboardControl() {
        /**
         Keyboard notifications
         */
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: .UIKeyboardDidHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification)
    {
        self.keyboardControl(notification, isShowing: true)
    }
    
    func keyboardDidShow(_ notification: Notification)
    {
        
    }
    func keyboardWillHide(_ notification: Notification)
    {
        self.keyboardControl(notification, isShowing: false)
    }
    func keyboardDidHide(_ notification: Notification)
    {
        
    }
    
    func keyboardControl(_ notification: Notification, isShowing: Bool)
    {
        var userInfo = notification.userInfo!
        let keyboardRect = (userInfo[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        let curve = (userInfo[UIKeyboardAnimationCurveUserInfoKey]! as AnyObject).uint32Value
        
        let convertedFrame = self.view.convert(keyboardRect!, from: nil)
        let heightOffset = self.view.bounds.size.height - convertedFrame.origin.y
        let options = UIViewAnimationOptions(rawValue: UInt(curve!) << 16 | UIViewAnimationOptions.beginFromCurrentState.rawValue)
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey]! as AnyObject).doubleValue
        
        
        UIView.animate(
            withDuration: duration!,
            delay: 0,
            options: options,
            animations: {
                if isShowing{
                    //self.tblScroll.contentOffset.y += heightOffset
                    if self.scrollViewBottomConstraint.constant == 0 {
                        self.tblScroll.frame.size.height -= heightOffset
                    }
                    
                }
                else
                {
                    //self.tblScroll.contentOffset.y -= keyboardRect!.height
                    self.scrollViewBottomConstraint.constant = 0
                    
                }
        },
            completion: { bool in
                if isShowing{
                    self.scrollViewBottomConstraint.constant = heightOffset
                }
                else
                {
                   
                    self.scrollViewBottomConstraint.constant = 0
                }
                
                
        })
    }
    
}


extension RegisterViewController:  UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        profileImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imvProfile.image = profileImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelgeate
    // open gallery
    func openGallery() {
        
        picker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    // open camera
    func openCamera() {
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func selectImageSource()
    {
        
        self.view.endEditing(true)
        
        let alertController = UIAlertController(title: "Select Image Source", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let selectGalleryAction = UIAlertAction(title: "Gallery", style: .default, handler: { action in
            self.openGallery()
            
        })
        let selectCameraAction = UIAlertAction(title: "Camera",				 style: .default, handler: { action in
            
            self.openCamera()
            
        })
        let selectCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        })
        alertController.addAction(selectGalleryAction)
        alertController.addAction(selectCameraAction)
        alertController.addAction(selectCancel)
        
        
        self.navigationController?.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
}

