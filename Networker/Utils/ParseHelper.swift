
//
//  Parsehelper.swift
//  Networker
//
//  Created by Big Shark on 16/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class ParseHelper {
    
    static func parseUser(_ rawData: [String: AnyObject]) -> UserModel {
        let user = UserModel()
        user.user_id = rawData[Constants.KEY_USER_ID] as! Int64
        user.user_firstname = rawData[Constants.KEY_USER_FIRSTNAME] as! String
        user.user_lastname = rawData[Constants.KEY_USER_LASTNAME] as! String
        user.user_email = rawData[Constants.KEY_USER_EMAIL] as! String
        user.user_address1 = rawData[Constants.KEY_USER_ADDRESS1] as! String
        user.user_postcode = rawData[Constants.KEY_USER_POSTCODE] as! String
        user.user_birthday = rawData[Constants.KEY_USER_BIRTHDAY] as! String
        var skills : [SkillModel] = []
        let skillsObject = rawData[Constants.KEY_USER_SKILLS] as! [[String: AnyObject]]
        for skillObject in skillsObject{
            skills.append(parseSkill(skillObject))
        }
        user.user_skills = skills
        user.user_available = rawData[Constants.KEY_USER_AVAILABLE] as! Bool
        user.user_latitude = rawData[Constants.KEY_USER_LATITUDE] as! Double
        user.user_longitude = rawData[Constants.KEY_USER_LONGITUDE] as! Double
        user.user_rangedistance = rawData[Constants.KEY_USER_RANGEDISTANCE] as! Double
        
        return user
    }
    
    static func parseSkill(_ rawData: [String: AnyObject]) -> SkillModel{
        
        let skill = SkillModel()
        skill.skill_id = rawData[Constants.KEY_SKILL_ID] as! Int64
        skill.skill_title = rawData[Constants.KEY_SKILL_TITLE] as! String
        skill.skill_qualifications = rawData[Constants.KEY_SKILL_TAGS] as! String
        let tagsObject = rawData[Constants.KEY_SKILL_TAGS] as! [[String: AnyObject]]
        for tagObject in tagsObject{
            skill.skill_tags.append(parseTag(tagObject))
        }
        skill.skill_price = rawData[Constants.KEY_SKILL_PRICE] as! Double
        return skill
        
    }
    
    static func parseTag(_ rawData: [String : AnyObject]) -> TagModel {
        let tag = TagModel()
        tag.tag_id = rawData[Constants.KEY_TAG_ID] as! Int64
        tag.tag_string = rawData[Constants.KEY_TAG_STRING] as! String
        return tag
    }

    
}
