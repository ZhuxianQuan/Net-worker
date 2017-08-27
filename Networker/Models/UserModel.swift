//
//  UserModel.swift
//  Networker
//
//  Created by Big Shark on 16/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserModel {
    
    var user_id: Int64 = 0
    var user_firstname = ""
    var user_lastname = ""
    var user_email = ""
    var user_password = ""
    var user_address1 = ""
    var user_address2 = ""
    var user_address3 = ""
    var user_postcode = ""
    var user_birthday = ""
    var user_skills = ""
    var user_skill_array : [SkillModel] {
        get {
            var skills = [SkillModel]()
            if user_skills.characters.count == 0 {
                return []
            }
            else {
                let skillStrings = user_skills.components(separatedBy: ",")
                for skillString in skillStrings {
                    if skillString.characters.count > 0 {
                        let skill = getSkillFrom(skillString)
                        if skill != nil {
                            skills.append(skill!)
                        }
                    }
                }
            }
            return skills
        }
        
    }
    var user_available = Constants.VALUE_USER_AVAILABLE
    var user_profileimageurl = ""
    var user_latitude = 0.0
    var user_longitude = 0.0
    var user_rangedistance = 5.0
    var user_ratings : [RatingModel] = []
    var user_aboutme = ""
    var user_avgmarks : Float = 0.0
    var user_token: String {
        get {
            if let token = UserDefaults.standard.value(forKey: Constants.KEY_USER_TOKEN) {
                return token as! String
            }
            return ""
        }
    }
    
    var user_schedules = [DayScheduleModel]()
    
    func getUserObject() -> [String: AnyObject]{
        var result : [String : AnyObject] = [:]
        result[Constants.KEY_USER_ID] = user_id as AnyObject
        result[Constants.KEY_USER_FIRSTNAME] = user_firstname as AnyObject
        result[Constants.KEY_USER_LASTNAME] = user_lastname as AnyObject
        result[Constants.KEY_USER_EMAIL] = user_email.lowercased() as AnyObject
        result[Constants.KEY_USER_PASSWORD] = user_password as AnyObject
        result[Constants.KEY_USER_ADDRESS2] = user_address2 as AnyObject
        result[Constants.KEY_USER_ADDRESS1] = user_address1 as AnyObject
        result[Constants.KEY_USER_ADDRESS2] = user_address2 as AnyObject
        result[Constants.KEY_USER_ADDRESS3] = user_address3 as AnyObject
        result[Constants.KEY_USER_SKILLS] = user_skills as AnyObject
        result[Constants.KEY_USER_AVAILABLE] = user_available as AnyObject
        result[Constants.KEY_USER_PROFILEIMAGEURL] = user_profileimageurl as AnyObject
        result[Constants.KEY_USER_LATITUDE] = currentLatitude as AnyObject
        result[Constants.KEY_USER_LONGITUDE] = currentLongitude as AnyObject
        result[Constants.KEY_USER_RANGEDISTANCE] = user_rangedistance as AnyObject
        result[Constants.KEY_USER_POSTCODE] = user_postcode as AnyObject
        result[Constants.KEY_USER_BIRTHDAY] = user_birthday as AnyObject
        result[Constants.KEY_USER_AVAILABLE] = user_available as AnyObject
        result[Constants.KEY_USER_TOKEN] = user_token as AnyObject
        result[Constants.KEY_USER_ABOUTME] = user_aboutme as AnyObject
        //result[Constants.KEY_USER_RATINGS]
        return result
    }
    
    internal func getSkillFrom(_ skillString: String) -> SkillModel?{
        let skillObjects = skillString.components(separatedBy: ":")
        let skill = FMDBManagerGetData().getSkill(skillObjects[1])
        if skill != nil {
            skill?.skill_price = Double(skillObjects[3])!
            skill?.skill_qualifications = skillObjects[5]
            return skill
        }
        else {
            return nil
        }
    }
    
    func getSkillPrice(_ skill_id : Int) -> Double {
        for skill in user_skill_array {
            if skill.skill_id == skill_id {
                return skill.skill_price
            }
        }
        return 0
    }
    
    
}



