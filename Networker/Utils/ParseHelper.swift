
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
        
        return user
    }
    
    static func parseSkill(_ rawData: [String: AnyObject]) -> SkillModel{
        let skill = SkillModel()
        skill.skill_id = rawData[Constants.KEY_SKILL_ID] as! Int64
        skill.skill_title = rawData[Constants.KEY_SKILL_TITLE] as! String
        skill.skill_qualifications = rawData[Constants.KEY_SKILL_TAGS] as! String
        let tagsObject = rawData[Constants.KEY_SKILL_TAGS] as! [[String: AnyObject]]
        for tagObject in tagsObject{
            skill.skill_tags.append(parseTags(tagObject))
        }
        return skill
    }
    
    static func parseTags(_ rawData: [String : AnyObject]) -> TagModel {
        let tag = TagModel()
        tag.tag_id = rawData[Constants.KEY_TAG_ID] as! Int64
        tag.tag_string = rawData[Constants.KEY_TAG_STRING] as! String
        return tag
    }

    
}
