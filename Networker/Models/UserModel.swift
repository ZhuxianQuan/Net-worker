//
//  UserModel.swift
//  Networker
//
//  Created by Big Shark on 16/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class UserModel {
    
    var user_id : Int64 = 0
    var user_firstname = ""
    var user_lastname = ""
    var user_email = ""
    var user_password = ""
    var user_address1 = ""
    var user_address2 = ""
    var user_address3 = ""
    var user_postcode = ""
    var user_birthday = ""
    //var user_iscustomer = false
    var user_skills : [SkillModel] = []
    var user_available = false
    var user_profileimageurl = ""
    var user_latitude = 0.0
    var user_longitude = 0.0
    var user_rangedistance = 25.0
//    var user_payment

    static func getUserObject() -> [String: AnyObject]{
        var result : [String: AnyObject] = [:]
        
        
        return result
    }
    
    
}



