//
//  UserModel.swift
//  Networker
//
//  Created by Big Shark on 16/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class UserModel {
    
    var user_id = ""
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
    var user_ratings : [RatingModel] = []
    var user_aboutme = "I am a tester"
//    var user_payment

    
    func getUserObject() -> [String: AnyObject]{
        var result : [String: AnyObject] = [:]
        result[Constants.KEY_USER_ID] = user_id as AnyObject
        result[Constants.KEY_USER_FIRSTNAME] = user_firstname as AnyObject
        result[Constants.KEY_USER_LASTNAME] = user_lastname as AnyObject
        result[Constants.KEY_USER_EMAIL] = user_email as AnyObject
        result[Constants.KEY_USER_PASSWORD] = user_password as AnyObject
        result[Constants.KEY_USER_ADDRESS2] = user_address2 as AnyObject
        result[Constants.KEY_USER_ADDRESS1] = user_address1 as AnyObject
        result[Constants.KEY_USER_ADDRESS2] = user_address2 as AnyObject
        result[Constants.KEY_USER_ADDRESS3] = user_address3 as AnyObject
        result[Constants.KEY_USER_SKILLS] = FMDBManagerGetData.getSkillsString(skills: user_skills) as AnyObject
        result[Constants.KEY_USER_AVAILABLE] = user_available as AnyObject
        result[Constants.KEY_USER_PROFILEIMAGEURL] = user_profileimageurl as AnyObject
        result[Constants.KEY_USER_LATITUDE] = user_latitude as AnyObject
        result[Constants.KEY_USER_LONGITUDE] = user_longitude as AnyObject
        result[Constants.KEY_USER_RANGEDISTANCE] = user_rangedistance as AnyObject
        //result[Constants.KEY_USER_RATINGS]
        return result
    }
    
    
}



