//
//  Constants.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation

class Constants {
    
    
    //error messages 
    
    static let CHECK_EMAIL_EMPTY            = "Please input your email"
    static let CHECK_PASSWORD_EMPTY         = "Please input your password"
    static let CHECK_EMAIL_INVALID          = "Please input valid email"
    
    
    //PROCESS VALUES
    
    static let PROCESS_SUCCESS              = "success"
    static let PROCESS_FAIL                 = "fail"
    //static let PROCESS_
    
    //storyboard ids
    
    static let STORYBOARD_MAIN              = 1
    static let STORYBOARD_HOME              = 2
    static let STORYBOARD_SEARCH            = 3
    static let STORYBOARD_SCHEDULE          = 4
    static let STORYBOARD_FAVORITE          = 5
    static let STORYBOARD_CHATTING          = 6
    
    //MARK: - keywords
    
    //skill model
    static let KEY_SKILL_ID                 = "skill_id"
    static let KEY_SKILL_TITLE              = "skill_title"
    static let KEY_SKILL_TAGS               = "skill_tags"
    static let KEY_SKILL_QUALIFICATIONS     = "skill_"
    
    //tag model
    static let KEY_TAG_ID                   = "tag_id"
    static let KEY_TAG_STRING               = "tag_string"
    
    //user model
    static let KEY_USER_ID                  = "user_id"
    static let KEY_USER_FIRSTNAME           = "user_firstname"
    static let KEY_USER_LASTNAME            = "user_lastname"
    static let KEY_USER_EMAIL               = "user_email"
    static let KEY_USER_PASSWORD            = "user_password"
    static let KEY_USER_ADDRESS1            = "user_address1"
    static let KEY_USER_ADDRESS2            = "user_address2"
    static let KEY_USER_ADDRESS3            = "user_address3"
    static let KEY_USER_POSTCODE            = "user_postcode"
    static let KEY_USER_BIRTHDAY            = "user_birthday"
    static let KEY_USER_ISCUSTOMER          = "user_iscustomer"
    static let KEY_USER_SKILLS              = "user_skills"
    static let KEY_USER_AVAILABLE           = "user_available"
    static let KEY_USER_LATITUDE            = "user_latitude"
    static let KEY_USER_LONGITUDE           = "user_longitude"
    
    //fmdbmanager
    
    static let DB_NAME                      = "net-worker"
    
    //firebase keys
    
    static var FIR_STORAGE_BASE_URL         = ""
    
    
    
    
    
}
