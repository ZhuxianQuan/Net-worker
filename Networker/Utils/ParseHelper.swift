
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
        user.user_id = rawData[Constants.KEY_USER_ID].nonNullInt64Value
        user.user_firstname = rawData[Constants.KEY_USER_FIRSTNAME].nonNullStringValue
        user.user_lastname = rawData[Constants.KEY_USER_LASTNAME].nonNullStringValue
        user.user_email = rawData[Constants.KEY_USER_EMAIL].nonNullStringValue
        user.user_password = rawData[Constants.KEY_USER_PASSWORD].nonNullStringValue
        user.user_address1 = rawData[Constants.KEY_USER_ADDRESS1].nonNullStringValue
        user.user_address2 = rawData[Constants.KEY_USER_ADDRESS2].nonNullStringValue
        user.user_address3 = rawData[Constants.KEY_USER_ADDRESS3].nonNullStringValue
        user.user_postcode = rawData[Constants.KEY_USER_POSTCODE].nonNullStringValue
        user.user_birthday = rawData[Constants.KEY_USER_BIRTHDAY].nonNullStringValue
        user.user_aboutme = rawData[Constants.KEY_USER_ABOUTME].nonNullStringValue
        user.user_profileimageurl = rawData[Constants.KEY_USER_PROFILEIMAGEURL].nonNullStringValue
        
        user.user_skills = rawData[Constants.KEY_USER_SKILLS].nonNullStringValue
        user.user_available = rawData[Constants.KEY_USER_AVAILABLE].nonNullIntValue
        user.user_latitude = rawData[Constants.KEY_USER_LATITUDE].nonNullDoubleValue
        user.user_longitude = rawData[Constants.KEY_USER_LONGITUDE].nonNullDoubleValue
        user.user_rangedistance = rawData[Constants.KEY_USER_RANGEDISTANCE].nonNullDoubleValue
        let ratingsArray = rawData[Constants.KEY_USER_RATINGS].arrayValue
        for ratingObject in ratingsArray{
            user.user_ratings.append(parseRating(ratingObject))
        }
        return user
    }
    
    static func parseSkill(_ rawData: JSON) -> SkillModel{
        
        let skill = SkillModel()
        
        skill.skill_id = rawData[Constants.KEY_SKILL_ID].nonNullIntValue
        skill.skill_title = rawData[Constants.KEY_SKILL_TITLE].nonNullStringValue
        skill.skill_qualifications = rawData[Constants.KEY_SKILL_TAGS].nonNullStringValue
        let tagsObject = rawData[Constants.KEY_SKILL_TAGS].arrayValue
        for tagObject in tagsObject{
            skill.skill_tags.append(parseTag(tagObject))
        }
        skill.skill_price = rawData[Constants.KEY_SKILL_PRICE].nonNullDoubleValue
        return skill
        
    }
    
    static func parseTag(_ rawData: JSON) -> TagModel {
        let tag = TagModel()
        tag.tag_id = rawData[Constants.KEY_TAG_ID].nonNullIntValue
        tag.tag_string = rawData[Constants.KEY_TAG_STRING].nonNullStringValue
        return tag
    }
    
    static func parseRating(_ rawData : JSON) -> RatingModel {
        let rating = RatingModel()
        rating.rating_id = rawData[Constants.KEY_RATING_ID].nonNullInt64Value
        rating.rating_sender = rawData[Constants.KEY_RATING_SENDER].nonNullInt64Value
        rating.rating_receiver = rawData[Constants.KEY_RATING_RECEIVER].nonNullInt64Value
        rating.rating_comment = rawData[Constants.KEY_RATING_COMMENT].nonNullStringValue
        rating.rating_marks = rawData[Constants.KEY_RATING_MARKS].floatValue
        rating.rating_timestamp = rawData[Constants.KEY_RATING_TIMESTAMP].nonNullInt64Value
        rating.rating_sendername = rawData[Constants.KEY_RATING_SENDERNAME].nonNullStringValue
        return rating
    }

    
}
