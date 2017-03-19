
//
//  TestJson.swift
//  Networker
//
//  Created by Big Shark on 18/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class TestJson{
    
    static func getUserJson() -> [String : Any]
    {
        return [Constants.KEY_USER_ID : 1,
                Constants.KEY_USER_EMAIL : "bigshark@gmail.com"
        ]
    }
    
    static func getSkillsJson() -> [[String: Any]]{
        return [[ Constants.KEY_SKILL_ID : 0,
                  Constants.KEY_SKILL_TITLE : "dogwalking",
                  Constants.KEY_SKILL_TAGS: [[ Constants.KEY_TAG_ID : 0,
                                               Constants.KEY_TAG_STRING : "dog"],
                                             [ Constants.KEY_TAG_ID : 1,
                                               Constants.KEY_TAG_STRING : "help"],
                                             [ Constants.KEY_TAG_ID : 2,
                                               Constants.KEY_TAG_STRING : "walk"],
                                             [ Constants.KEY_TAG_ID : 3,
                                               Constants.KEY_TAG_STRING : "petcare"],
                                             [ Constants.KEY_TAG_ID : 4,
                                               Constants.KEY_TAG_STRING : "pethelp"]],
                  Constants.KEY_SKILL_QUALIFICATIONS : "Details",
                  Constants.KEY_SKILL_PRICE : 12],
                [ Constants.KEY_SKILL_ID : 1,
                  Constants.KEY_SKILL_TITLE : "windowcleaning",
                  Constants.KEY_SKILL_TAGS: [[ Constants.KEY_TAG_ID : 5,
                                               Constants.KEY_TAG_STRING : "windows"],
                                             [ Constants.KEY_TAG_ID : 6,
                                               Constants.KEY_TAG_STRING : "ladder"]],
                  Constants.KEY_SKILL_QUALIFICATIONS : "Details",
                  Constants.KEY_SKILL_PRICE : 20],
                [ Constants.KEY_SKILL_ID : 2,
                  Constants.KEY_SKILL_TITLE : "gardening",
                  Constants.KEY_SKILL_TAGS: [[ Constants.KEY_TAG_ID : 7,
                                               Constants.KEY_TAG_STRING : "mowing"],
                                             [ Constants.KEY_TAG_ID : 8,
                                               Constants.KEY_TAG_STRING : "weeding"],
                                             [ Constants.KEY_TAG_ID : 9,
                                               Constants.KEY_TAG_STRING : "planting"],
                                             [ Constants.KEY_TAG_ID : 10,
                                               Constants.KEY_TAG_STRING : "pruning"]],
                  Constants.KEY_SKILL_QUALIFICATIONS : "Details",
                  Constants.KEY_SKILL_PRICE : 15],
                [ Constants.KEY_SKILL_ID : 3,
                  Constants.KEY_SKILL_TITLE : "oddjobs",
                  Constants.KEY_SKILL_TAGS: [[ Constants.KEY_TAG_ID : 11,
                                               Constants.KEY_TAG_STRING : "flatpack"],
                                             [ Constants.KEY_TAG_ID : 12,
                                               Constants.KEY_TAG_STRING : "picurehand"],
                                             [ Constants.KEY_TAG_ID : 13,
                                               Constants.KEY_TAG_STRING : "lifting"],
                                             [ Constants.KEY_TAG_ID : 14,
                                               Constants.KEY_TAG_STRING : "lightbulb"],
                                             [ Constants.KEY_TAG_ID : 15,
                                               Constants.KEY_TAG_STRING : "plug"],
                                             [ Constants.KEY_TAG_ID : 16,
                                               Constants.KEY_TAG_STRING : "radiator"],
                                             [ Constants.KEY_TAG_ID : 17,
                                               Constants.KEY_TAG_STRING : "logs"],
                                             [ Constants.KEY_TAG_ID : 18,
                                               Constants.KEY_TAG_STRING : "blocked"]],
                  Constants.KEY_SKILL_QUALIFICATIONS : "Details",
                  Constants.KEY_SKILL_PRICE : 15],
        ]
    }
    
    
    static func getTagsJson() -> [[String: Any]]{
        return [[ Constants.KEY_TAG_ID : 0,
                  Constants.KEY_TAG_STRING : "dog"],
                [ Constants.KEY_TAG_ID : 1,
                  Constants.KEY_TAG_STRING : "help"],
                [ Constants.KEY_TAG_ID : 2,
                  Constants.KEY_TAG_STRING : "walk"],
                [ Constants.KEY_TAG_ID : 3,
                  Constants.KEY_TAG_STRING : "petcare"],
                [ Constants.KEY_TAG_ID : 4,
                  Constants.KEY_TAG_STRING : "pethelp"],
                [ Constants.KEY_TAG_ID : 5,
                  Constants.KEY_TAG_STRING : "windows"],
                [ Constants.KEY_TAG_ID : 6,
                  Constants.KEY_TAG_STRING : "ladder"],
                [ Constants.KEY_TAG_ID : 7,
                  Constants.KEY_TAG_STRING : "mowing"],
                [ Constants.KEY_TAG_ID : 8,
                  Constants.KEY_TAG_STRING : "weeding"],
                [ Constants.KEY_TAG_ID : 9,
                  Constants.KEY_TAG_STRING : "planting"],
                [ Constants.KEY_TAG_ID : 10,
                  Constants.KEY_TAG_STRING : "pruning"],
                [ Constants.KEY_TAG_ID : 11,
                  Constants.KEY_TAG_STRING : "flatpack"],
                [ Constants.KEY_TAG_ID : 12,
                  Constants.KEY_TAG_STRING : "picurehand"],
                [ Constants.KEY_TAG_ID : 13,
                  Constants.KEY_TAG_STRING : "lifting"],
                [ Constants.KEY_TAG_ID : 14,
                  Constants.KEY_TAG_STRING : "lightbulb"],
                [ Constants.KEY_TAG_ID : 15,
                  Constants.KEY_TAG_STRING : "plug"],
                [ Constants.KEY_TAG_ID : 16,
                  Constants.KEY_TAG_STRING : "radiator"],
                [ Constants.KEY_TAG_ID : 17,
                  Constants.KEY_TAG_STRING : "logs"],
                [ Constants.KEY_TAG_ID : 18,
                  Constants.KEY_TAG_STRING : "blocked"]
        ]
    }
    
    static func getMe() -> [String: Any] {
        return [
            Constants.KEY_USER_ID : 20,
            Constants.KEY_USER_FIRSTNAME : "Quan",
            Constants.KEY_USER_LASTNAME : "Zhuxian",
            Constants.KEY_USER_PASSWORD : "bigshark@gmail.com",
            Constants.KEY_USER_ADDRESS1 : "China",
            Constants.KEY_USER_ADDRESS2 : "Jilin",
            Constants.KEY_USER_ADDRESS3 : "Yanji",
            Constants.KEY_USER_POSTCODE : "24689",
            Constants.KEY_USER_BIRTHDAY : "1989/8/10",
            Constants.KEY_USER_SKILLS : getSkillsJson(),
            Constants.KEY_USER_AVAILABLE : 1,
            Constants.KEY_USER_PROFILEIMAGEURL : "",
            Constants.KEY_USER_RANGEDISTANCE : 5
        ]
    }
    
    
}
