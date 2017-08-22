//
//  Singleton.swift
//  Networker
//
//  Created by Big Shark on 19/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


//This file is local public variables
var currentLatitude = 0.0
var currentLongitude = 0.0
var currentUser : UserModel? {
    didSet {
        if (currentUser?.user_id)! > 0 {
            UserDefaults.standard.set(currentUser?.user_email, forKey: Constants.KEY_USER_EMAIL)
            UserDefaults.standard.set(currentUser?.user_password, forKey: Constants.KEY_USER_PASSWORD)
        }
    }
}

class Singleton {
    
}

