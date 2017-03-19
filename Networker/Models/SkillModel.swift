//
//  JobModel.swift
//  Networker
//
//  Created by Big Shark on 16/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class SkillModel{
    
    var skill_id : Int64 = 0
    //if user wants to add new job id, then he has to use server data.
    //if user wants to add new job not exists in server id has to be -1
    var skill_title = ""
    var skill_tags : [TagModel] = []
    var skill_price : Double!
    var skill_qualifications = ""
    
    static let localTableName = "skills"
    static let localTableString = [
        Constants.KEY_SKILL_ID : "BIGINT",
        Constants.KEY_SKILL_TITLE : "TEXT"
    ]
    
    
    func getSkillObject() -> [String: String] {
        var result : [String: String] = [:]
        result[Constants.KEY_SKILL_ID] = "\(skill_id)"
        result[Constants.KEY_SKILL_TITLE] = skill_title
        result[Constants.KEY_SKILL_TAGS] = getTagsString()
        return result
    }
    
    func getTagsString() -> String {
        
        var result = ""
        for tag in skill_tags{
            result = result + tag.tag_string + ", "
        }
        result = result + "__**"
        return result.replacingOccurrences(of: ", __**", with: "")
        
    }
    
}
