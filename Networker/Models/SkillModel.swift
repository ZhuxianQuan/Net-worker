//
//  JobModel.swift
//  Networker
//
//  Created by Big Shark on 16/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class SkillModel{
    
    var skill_id : Int = 0
    //if user wants to add new job id, then he has to use server data.
    //if user wants to add new job not exists in server id has to be -1
    var skill_title = ""
    var skill_tags : [TagModel] = []
    var skill_price : Double = 0.0
    var skill_qualifications = ""
    var skill_ratings : Float = 0
    
    var tagString: String {
        get {
            var result = ""
            for tag in skill_tags{
                if result.characters.count == 0 {
                    result = "#" + tag.tag_string
                }
                else {
                    result = result + ", #" + tag.tag_string
                }
            }
            return result
        }
    }
    
    var skill_full_string : String {
        get {
            return String(format: "s:%d:p:%lf:q:%@,", skill_id, skill_price,skill_qualifications)
        }
    }
    
    /*
    func getSkillObject() -> [String: String] {
        var result : [String: String] = [:]
        result[Constants.KEY_SKILL_ID] = "\(skill_id)"
        result[Constants.KEY_SKILL_TITLE] = skill_title
        return result
    }*/
    
    
}
