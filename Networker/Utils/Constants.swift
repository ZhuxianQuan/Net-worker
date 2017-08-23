//
//  Constants.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import UIKit

class Constants {    
    
    //error messages 
    
    static let CHECK_EMAIL_EMPTY            = "Please input your email"
    static let CHECK_PASSWORD_EMPTY         = "Please input your password"
    static let CHECK_EMAIL_INVALID          = "Please input valid email"
    static let CHECK_FIRSTNAME_EMPTY        = "Please input your firstname"
    static let CHECK_LASTNAME_EMPTY         = "Please input your lastname"
    static let CHECK_NETWORK_ERROR          = "Network Error! Please check your network connection"
    static let CHECK_ENCODING_ERROR         = "Encoding Error occurred!"
    static let CHECK_PROFILE_IMAGE_UPLOAD   = "You can upload image after you finish registeration"
    static let CHECK_BIRTHDAY_EMPTY         = "Please input your birthday"
    
    
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
    
    //skill category 
    static let KEY_CATEGORYS                = "categories"
    static let KEY_CATEGORY_ID              = "category_id"
    static let KEY_CATEGORY_NAME            = "category_name"
    static let KEY_CATEGORY_SKILLS          = "skills"
    
    //skill model
    static let KEY_SKILL_ID                 = "skill_id"
    static let KEY_SKILL_TITLE              = "skill_title"
    static let KEY_SKILL_TAGS               = "skill_tags"
    static let KEY_SKILL_QUALIFICATIONS     = "skill_qualifications"
    static let KEY_SKILL_PRICE              = "skill_price"
    
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
    //static let KEY_USER_ISCUSTOMER          = "user_iscustomer"
    static let KEY_USER_SKILLS              = "user_skills"
    static let KEY_USER_AVAILABLE           = "user_available"
    static let KEY_USER_PROFILEIMAGEURL     = "user_profileimageurl"
    static let KEY_USER_LATITUDE            = "user_latitude"
    static let KEY_USER_LONGITUDE           = "user_longitude"
    static let KEY_USER_RANGEDISTANCE       = "user_rangedistance"
    static let KEY_USER_RATINGS             = "user_ratings"    
    static let KEY_USER_ABOUTME             = "user_aboutme"
    static let KEY_USER_TOKEN               = "user_token"
    
    //rating model
    
    static let KEY_RATING_ID                = "rating_id"
    static let KEY_RATING_SENDER            = "rating_sender"
    static let KEY_RATING_RECEIVER          = "rating_receiver"
    static let KEY_RATING_COMMENT           = "rating_comment"
    static let KEY_RATING_MARKS             = "rating_marks"
    static let KEY_RATING_TIMESTAMP         = "rating_timestamp"
    static let KEY_RATING_SENDERNAME        = "rating_sendername"
    
    //fmdbmanager
    
    static let DB_NAME                      = "net-worker"
    
    //firebase keys
    
    static var FIR_STORAGE_BASE_URL         = ""
    
    //user defined colors 
    
    static let GREEN_SCHEDULE_COLOR         = UIColor(red: 35.0/255.0, green: 172.0/255.0, blue: 154.0/255.0, alpha: 1)
    static let BLUE_DAILY_SCHEDULE_COLOR    = UIColor(red: 90.0/255.0, green: 190.0/255.0, blue: 226.0/255.0, alpha: 1)
    static let Dark_SCHEDULE_COLOR          = UIColor(red: 46.0/255.0, green: 51.0/255.0, blue: 62.0/255.0, alpha: 1)
    
    //side menu items
    
    static let SIDE_MENU_PERSONAL_DETAILS   = "Personal details"
    static let SIDE_MENU_SKILLS             = "Skills"
    static let SIDE_MENU_AVAILABILITY       = "Availability"
    static let SIDE_MENU_JOBS_PENDING       = "Jobs Pending"
    static let SIDE_MENU_JOBS_COMPLETED     = "Jobs Completed"
    static let SIDE_MENU_ABOUT_NETWORKER    = "About Net-Worker"
    static let SIDE_MENU_CONTACT_US         = "Contact Us"
    static let SIDE_MENU_RATE_OUR_APP       = "Rate Our App"
    static let SIDE_MENU_TERMSANDCONDITIONS = "Terms & Conditions"
    static let SIDE_MENU_SIGN_OUT           = "Sign Out"
    
    //keys for backend parse
    
    static let RES_MESSAGE                  = "message"
    
    
    //keys for image
    static let KEY_IMAGEURL                 = "image_url"
    
    static let RES_USER_INFO                = "user_info"
    
    //values
    
    static let VALUE_USER_AVAILABLE         = 1
    static let VALUE_USER_BUSY              = 2
    
    static let VALUE_PASSWORD_FB            = "FBPASSWORD_NETWORKER"
    static let VALUE_PASSWORD_LI            = "LIPASSWORD_NETWORKER"
    
}
