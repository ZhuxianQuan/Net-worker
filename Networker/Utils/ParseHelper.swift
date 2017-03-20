
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
        NSLog("user data === \(rawData)")
        let user = UserModel()
        user.user_id = rawData[Constants.KEY_USER_ID].int64Value
        user.user_firstname = rawData[Constants.KEY_USER_FIRSTNAME].stringValue
        user.user_lastname = rawData[Constants.KEY_USER_LASTNAME].stringValue
        user.user_email = rawData[Constants.KEY_USER_EMAIL].stringValue
        user.user_address1 = rawData[Constants.KEY_USER_ADDRESS1].stringValue
        user.user_postcode = rawData[Constants.KEY_USER_POSTCODE].stringValue
        user.user_birthday = rawData[Constants.KEY_USER_BIRTHDAY].stringValue
        user.user_profileimageurl = rawData[Constants.KEY_USER_PROFILEIMAGEURL].stringValue
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
        let ratingsArray = rawData[Constants.KEY_USER_RATINGS].arrayValue
        for ratingObject in ratingsArray{
            user.user_ratings.append(parseRating(ratingObject))
        }
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
    
    static func parseRating(_ rawData : JSON) -> RatingModel {
        let rating = RatingModel()
        rating.rating_id = rawData[Constants.KEY_RATING_ID].int64Value
        rating.rating_sender = rawData[Constants.KEY_RATING_SENDER].int64Value
        rating.rating_receiver = rawData[Constants.KEY_RATING_RECEIVER].int64Value
        rating.rating_comment = rawData[Constants.KEY_RATING_COMMENT].stringValue
        rating.rating_marks = rawData[Constants.KEY_RATING_MARKS].floatValue
        rating.rating_timestamp = rawData[Constants.KEY_RATING_TIMESTAMP].int64Value
        rating.rating_sendername = rawData[Constants.KEY_RATING_SENDERNAME].stringValue
        return rating
    }

    
}
