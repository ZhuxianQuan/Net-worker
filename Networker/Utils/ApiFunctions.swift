//
//  ApiFunctions.swift
//  Networker
//
//  Created by Big Shark on 13/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import Alamofire

class ApiFunctions{
    
    static func login(email: String, password: String, completion: @escaping (String) -> ()){
        currentUser = ParseHelper.parseUser(TestJson.getMe() as [String : AnyObject])
        completion(Constants.PROCESS_SUCCESS)
    }
    
    static func register(){
        
    }
    
    static func loginWithFacebook(){
        
    }
    
    static func loginWithLinkedIn(){
        
    }
    
    static func passwordChangeRequest(email: String){
        
    }
    
    static func getUsers(available: Bool) {
        
    }
    
    static func advancedSearch(){
        
    }
    
    static func getSkillsArray(completion : @escaping (String, [SkillModel]) -> ()){
        let skillsData = TestJson.getSkillsJson()
        var skills : [SkillModel] = []
        for skillData in skillsData{
            skills.append(ParseHelper.parseSkill(skillData as [String : AnyObject]))
        }
        completion(Constants.PROCESS_SUCCESS, skills)
    }
    
    static func getTagsArray(completion : @escaping (String, [TagModel]) -> ()){
        let tagsData = TestJson.getTagsJson()
        var tags : [TagModel] = []
        for tagData in tagsData{
            tags.append(ParseHelper.parseTag(tagData as [String : AnyObject]))
        }
        completion(Constants.PROCESS_SUCCESS, tags)
    }
    
    static func get
    
    
}

