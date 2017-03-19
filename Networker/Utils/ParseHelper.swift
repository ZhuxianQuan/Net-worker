
//
//  Parsehelper.swift
//  Networker
//
//  Created by Big Shark on 16/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParseHelper {
    
    static func parseUser(_ rawData: JSON) -> UserModel {
        let user = UserModel()
        user.user_id = rawData[Constants.KEY_USER_ID].int64Value
        user.user_firstname = rawData[Constants.KEY_USER_FIRSTNAME].stringValue
        user.user_lastname = rawData[Constants.KEY_USER_LASTNAME].stringValue
        user.user_email = rawData[Constants.KEY_USER_EMAIL].stringValue
        user.user_address1 = rawData[Constants.KEY_USER_ADDRESS1].stringValue
        user.user_postcode = rawData[Constants.KEY_USER_POSTCODE].stringValue
        user.user_birthday = rawData[Constants.KEY_USER_BIRTHDAY].stringValue
        var skills : [SkillModel] = []
        let skillsObject = rawData[Constants.KEY_USER_SKILLS].arrayValue
        for skillObject in skillsObject{
            skills.append(parseSkill(skillObject))
        }
        user.user_skills = skills
        user.user_available = rawData[Constants.KEY_USER_AVAILABLE].boolValue
        user.user_latitude = rawData[Constants.KEY_USER_LATITUDE].doubleValue
        user.user_longitude = rawData[Constants.KEY_USER_LONGITUDE].doubleValue
        user.user_rangedistance = rawData[Constants.KEY_USER_RANGEDISTANCE].doubleValue
        
        return user
    }
    
    static func parseSkill(_ rawData: JSON) -> SkillModel{
        
        let skill = SkillModel()
        
        skill.skill_id = rawData[Constants.KEY_SKILL_ID].int64Value
        skill.skill_title = rawData[Constants.KEY_SKILL_TITLE].stringValue
        skill.skill_qualifications = rawData[Constants.KEY_SKILL_TAGS].stringValue
        let tagsObject = rawData[Constants.KEY_SKILL_TAGS].arrayValue
        for tagObject in tagsObject{
            skill.skill_tags.append(parseTag(tagObject))
        }
        skill.skill_price = rawData[Constants.KEY_SKILL_PRICE].doubleValue
        return skill
        
    }
    
    static func parseTag(_ rawData: JSON) -> TagModel {
        let tag = TagModel()
        tag.tag_id = rawData[Constants.KEY_TAG_ID].int64Value
        tag.tag_string = rawData[Constants.KEY_TAG_STRING].stringValue
        return tag
    }

    
}
