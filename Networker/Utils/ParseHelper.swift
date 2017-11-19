
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
        user.user_password = rawData[Constants.KEY_USER_PASSWORD].stringValue
        user.user_address = rawData[Constants.KEY_USER_ADDRESS].stringValue
        user.user_postcode = rawData[Constants.KEY_USER_POSTCODE].stringValue
        user.user_birthday = rawData[Constants.KEY_USER_BIRTHDAY].stringValue
        user.user_aboutme = rawData[Constants.KEY_USER_ABOUTME].stringValue
        user.user_profileimageurl = rawData[Constants.KEY_USER_PROFILEIMAGEURL].stringValue
        user.user_skills = rawData[Constants.KEY_USER_SKILLS].stringValue
        user.user_available = rawData[Constants.KEY_USER_AVAILABLE].intValue
        user.user_latitude = rawData[Constants.KEY_USER_LATITUDE].doubleValue
        user.user_longitude = rawData[Constants.KEY_USER_LONGITUDE].doubleValue
        //user.user_rangedistance = rawData[Constants.KEY_USER_RANGEDISTANCE].doubleValue
        user.user_avgmarks = rawData[Constants.KEY_USER_AVGRATING].floatValue
        return user
    }
    
    static func parseSkill(_ rawData: JSON) -> SkillModel{
        
        let skill = SkillModel()
        
        skill.skill_id = rawData[Constants.KEY_SKILL_ID].intValue
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
        tag.tag_id = rawData[Constants.KEY_TAG_ID].intValue
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
    
    static func parseSchedule(_ rawData: JSON) -> DayScheduleModel {
        
        let schedule = DayScheduleModel()
        schedule.user_id = rawData[Constants.KEY_USER_ID].int64Value
        schedule.schedule_id = rawData[Constants.KEY_SCHEDULE_ID].intValue
        schedule.day_schedule = rawData[Constants.KEY_SCHEDULE_DAYVALUE].int64Value
        schedule.day = rawData[Constants.KEY_SCHEDULE_DAY].intValue
        schedule.notes = rawData[Constants.KEY_SCHEDULE_NOTES].stringValue
        schedule.day_schedule = rawData[Constants.KEY_SCHEDULE_DAYVALUE].int64Value
        return schedule
        
    }
    
    static func parseDeal(_ rawData: JSON) -> DealModel{
        
        let deal = DealModel()
        deal.deal_id = rawData[Constants.KEY_DEAL_ID].int64Value
        if rawData["isclient"].intValue == 1{
            deal.deal_client = currentUser!
            deal.deal_worker = parseUser(rawData)
        }
        else {
            deal.deal_worker = currentUser!
            deal.deal_client = parseUser(rawData)
        }
        deal.deal_starttime = rawData[Constants.KEY_DEAL_STARTTIME].intValue
        deal.deal_endtime = rawData[Constants.KEY_DEAL_ENDTIME].intValue
        deal.deal_startday = rawData[Constants.KEY_DEAL_STARTDAY].intValue
        deal.deal_endday = rawData[Constants.KEY_DEAL_ENDDAY].intValue
        deal.deal_status = rawData[Constants.KEY_REQUEST_STATUS].intValue
        let skill_id = rawData[Constants.KEY_DEAL_SKILL].intValue
        deal.deal_skill = FMDBManagerGetData().getSkill(skill_id)!
        deal.deal_notes = rawData[Constants.KEY_DEAL_NOTES].stringValue
        deal.request_id = rawData[Constants.KEY_REQUEST_ID].int64Value
        deal.request_status = rawData[Constants.KEY_REQUEST_STATUS].intValue
        deal.request_timestamp = rawData[Constants.KEY_REQUEST_TIMESTAMP].int64Value
        
        return deal
    }

    
}
