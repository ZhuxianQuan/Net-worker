//
//  FMDBManager+Data.swift
//  Networker
//
//  Created by Big Shark on 19/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import SwiftyJSON

class LocalDataModels {
    
    let TBL_CATEGORY        = "tbl_category"
    let TBL_SKILL           = "tbl_skill"
    let TBL_SKILL_TAG       = "tbl_skill_tag"
    let TBL_TAG             = "tbl_tag"
    
    func getPrimaryKey(_ tablename: String) -> String{
        switch tablename {
        case TBL_CATEGORY:
            return "category_id"
        case TBL_SKILL:
            return Constants.KEY_SKILL_ID
        case TBL_SKILL_TAG:
            return "id"
        case TBL_SKILL:
            return "skill_id"
        case TBL_TAG:
            return "tag_id"
        default:
            return ""
        }
    }
    
    func getKeys(_ tablename: String) -> [String: String] {
        var result = [String: String]()
        
        switch tablename {
        case TBL_CATEGORY:
            result = [
                "category_id" : "INT",
                "category_name" : "TEXT"
            ]
            break
        case TBL_SKILL:
            result = [
                "skill_id" : "INT",
                "skill_title" : "TEXT",
                "category_id" : "INT"
            ]
            break
        case TBL_SKILL_TAG:
            result = [
                "id" : "INT",
                "skill_id" : "INT",
                "tag_id" : "INT"
            ]
            break
        case TBL_TAG:
            result = [
                "tag_id" : "INT",
                "tag_string" : "TEXT"
            ]
            break
        default:
            break
        }
        return result
    }
}

class FMDBManagerSetData{
    
    func saveCategories(_ rawData: [JSON]) {
        for categoryObject in rawData {
            let localDataModels = LocalDataModels()
            fmdbManager.insertRecord(tableObject: localDataModels.getKeys(localDataModels.TBL_CATEGORY), tableName: localDataModels.TBL_CATEGORY, tableData: categoryObject, primaryKey: localDataModels.getPrimaryKey(localDataModels.TBL_CATEGORY))
            
        }
    }
    func saveSkills(_ rawData: [JSON]) {
        for skillObject in rawData {
            let localDataModels = LocalDataModels()
            fmdbManager.insertRecord(tableObject: localDataModels.getKeys(localDataModels.TBL_SKILL), tableName: localDataModels.TBL_SKILL, tableData: skillObject, primaryKey: localDataModels.getPrimaryKey(localDataModels.TBL_SKILL))
            
        }
    }
    func saveTags(_ rawData: [JSON]) {
        for tagObject in rawData {
            let localDataModels = LocalDataModels()
            fmdbManager.insertRecord(tableObject: localDataModels.getKeys(localDataModels.TBL_TAG), tableName: localDataModels.TBL_TAG, tableData: tagObject, primaryKey: localDataModels.getPrimaryKey(localDataModels.TBL_TAG))
            
        }
    }
    func saveSkill_Tags(_ rawData: [JSON]) {
        for skilltagObject in rawData {
            let localDataModels = LocalDataModels()
            fmdbManager.insertRecord(tableObject: localDataModels.getKeys(localDataModels.TBL_SKILL_TAG), tableName: localDataModels.TBL_SKILL_TAG, tableData: skilltagObject, primaryKey: localDataModels.getPrimaryKey(localDataModels.TBL_SKILL_TAG))
            
        }
    }
}

class FMDBManagerGetData{
    
    
    func getSkill(_ id: Int) -> SkillModel?{
        let query = "select * from tbl_skill where skill_id = \(id)"
        let localModels = LocalDataModels()
        let results = fmdbManager.getDataFromFMDB(with: query, tableObject: localModels.getKeys(localModels.TBL_SKILL))
        if results.count > 0 {
            let object = results[0]
            let skill = SkillModel()
            skill.skill_id = object["skill_id"] as! Int
            skill.skill_title = object["skill_title"] as! String
            skill.skill_tags = getTagsInSkill(skill.skill_id)
            return skill
        }
        else {
            return nil
        }
        
    }
    
    func getSkills(_ keywords: String? = nil) -> [SkillModel]{
        var result = [SkillModel]()
        if keywords == nil || keywords?.characters.count == 0{
            let query = "select * from tbl_skill"
            let localModels = LocalDataModels()
            let results = fmdbManager.getDataFromFMDB(with: query, tableObject: localModels.getKeys(localModels.TBL_SKILL))
            for object in results {
                let skill = SkillModel()
                skill.skill_id = object["skill_id"] as! Int
                skill.skill_title = object["skill_title"] as! String
                skill.skill_tags = getTagsInSkill(skill.skill_id)
                result.append(skill)
            }
        }
        else {
            
            let keywordString = keywords?.replacingOccurrences(of: ",", with: " ").replacingOccurrences(of: ":", with: " ")
            let keywordArray = keywordString?.components(separatedBy: " ")
            var skilltitleString = ""
            var categoryString = ""
            var tagString = ""
            
            for keyword in keywordArray! {
                if keyword.characters.count > 0 {
                    if skilltitleString.characters.count == 0 {
                        skilltitleString.append(" skill_title like '%\(keywords!)%' ")
                        categoryString.append(" category_name like '%\(keywords!)%' ")
                        tagString.append(" tag_string like '%\(keywords!)%' ")
                    }
                    else {
                        skilltitleString.append(" OR skill_title like '%\(keywords!)%' ")
                        categoryString.append(" OR  category_name like '%\(keywords!)%' ")
                        tagString.append(" OR tag_string like '%\(keywords!)%' ")
                    }
                }
            }
            
            let query = "select skill_id, skill_title,category_id from tbl_skill where \(skilltitleString) union select a.skill_id, a.skill_title,a.category_id from tbl_skill a inner join  tbl_category b on a.category_id = b.category_id where \(categoryString)  union select a.skill_id, a.skill_title,a.category_id from tbl_skill a inner join  tbl_skill_tag b on a.skill_id = b.skill_id inner join tbl_tag c on b.tag_id = c.tag_id where \(tagString)  order by skill_title"
            
            let localModels = LocalDataModels()
            let results = fmdbManager.getDataFromFMDB(with: query, tableObject: localModels.getKeys(localModels.TBL_SKILL))
            for object in results {
                let skill = SkillModel()
                skill.skill_id = object["skill_id"] as! Int
                skill.skill_title = object["skill_title"] as! String
                skill.skill_tags = getTagsInSkill(skill.skill_id)
                result.append(skill)
            }

        }
        
        return result
    }
    
    func getMatchedTags(_ keyword: String) -> [TagModel]{
        var result = [TagModel]()
        let query = "select * from tbl_tag where tag_string like '%\(keyword)%'"
        let localModels = LocalDataModels()
        let results = fmdbManager.getDataFromFMDB(with: query, tableObject: localModels.getKeys(localModels.TBL_TAG))
        for object in results {
            let tag = TagModel()
            tag.tag_id = object["tag_id"] as! Int
            tag.tag_string = object["tag_string"] as! String
            result.append(tag)
        }
        return result
    }
    
    func getTagsInSkill(_ id: Int) -> [TagModel]{
        var result = [TagModel]()
        let query = "select * from tbl_skill_tag a inner join tbl_tag b on a.tag_id = b.tag_id where a.skill_id = \(id)"
        let localModels = LocalDataModels()
        let results = fmdbManager.getDataFromFMDB(with: query, tableObject: localModels.getKeys(localModels.TBL_TAG))
        for object in results {
            let tag = TagModel()
            tag.tag_id = object["tag_id"] as! Int
            tag.tag_string = object["tag_string"] as! String
            result.append(tag)
        }
        return result
    }
    
}
