//
//  FMDBManager+Data.swift
//  Networker
//
//  Created by Big Shark on 19/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class FMDBManagerSetData{
    
    
}

class FMDBManagerGetData{
    
    static func getMatchedSkills(keyword: String, skills : [SkillModel]) -> [SkillModel] {
        var result : [SkillModel] = []
        for skill in skills {
            if skill.skill_title.lowercased().contains(keyword.lowercased()){
                result.append(skill)
            }
        }
        return getSortedSkills(skills: result, keyword: keyword)
    }
    
    static func getMatchedTags(keyword: String, tags : [TagModel]) -> [TagModel] {
        var result : [TagModel] = []
        for tag in tags {
            if tag.tag_string.lowercased().contains(keyword.lowercased()){
                result.append(tag)
            }
        }
        return getSortedTags(tags: result, keyword: keyword)
    }
    
    
    static func getSortedSkills(skills : [SkillModel], keyword: String) -> [SkillModel]{
        let sortedArray = skills.sorted {
            ($0.skill_title.localizedStandardRange(of: keyword.lowercased())?.lowerBound)! < ($1.skill_title.localizedStandardRange(of: keyword.lowercased())?.lowerBound)!
        }
        return sortedArray
    }
    
    static func getSortedTags(tags: [TagModel], keyword: String) -> [TagModel] {
        let sortedArray = tags.sorted {
            ($0.tag_string.localizedStandardRange(of: keyword.lowercased())?.lowerBound)! < ($1.tag_string.localizedStandardRange(of: keyword.lowercased())?.lowerBound)!
        }
        return sortedArray
    }
    
    static func removeSkills(existing : [SkillModel], defined preDefinedSkills: [SkillModel]) -> [SkillModel] {
        var existingSkills = existing
        var result : [SkillModel] = []
        var index = 0
        
        for skill in preDefinedSkills {
            var existIndex = 0
            var isExists = false
            for existingSkill in existingSkills {
                if skill.skill_id == existingSkill.skill_id && skill.skill_title == existingSkill.skill_title {
                    existingSkills.remove(at: existIndex)
                    isExists = true
                    break
                }
                else{
                    
                }
                existIndex += 1
            }
            if !isExists {
                result.append(skill)
            }
            /*if existingSkills.count == 0{
                break
            }*/
        
            index += 1
        }
        return result
    }
}
