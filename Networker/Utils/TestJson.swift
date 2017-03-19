
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
    
    static func getSkillsJson() -> [[String: AnyObject]]{
        return [[ Constants.KEY_SKILL_ID : 0 as AnyObject,
                  Constants.KEY_SKILL_TITLE : "dogwalking" as AnyObject,
                  Constants.KEY_SKILL_TAGS: [[ Constants.KEY_TAG_ID : 0 as AnyObject,
                                               Constants.KEY_TAG_STRING : "dog" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 1 as AnyObject,
                                               Constants.KEY_TAG_STRING : "help" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 2 as AnyObject,
                                               Constants.KEY_TAG_STRING : "walk" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 3 as AnyObject,
                                               Constants.KEY_TAG_STRING : "petcare" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 4 as AnyObject,
                                               Constants.KEY_TAG_STRING : "pethelp" as AnyObject]] as AnyObject,
                  Constants.KEY_SKILL_QUALIFICATIONS : "Details" as AnyObject,
                  Constants.KEY_SKILL_PRICE : 12 as AnyObject],
                [ Constants.KEY_SKILL_ID : 1 as AnyObject,
                  Constants.KEY_SKILL_TITLE : "windowcleaning" as AnyObject,
                  Constants.KEY_SKILL_TAGS: [[ Constants.KEY_TAG_ID : 5 as AnyObject,
                                               Constants.KEY_TAG_STRING : "windows" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 6 as AnyObject,
                                               Constants.KEY_TAG_STRING : "ladder" as AnyObject]] as AnyObject,
                  Constants.KEY_SKILL_QUALIFICATIONS : "Details" as AnyObject,
                  Constants.KEY_SKILL_PRICE : 20 as AnyObject],
                [ Constants.KEY_SKILL_ID : 2 as AnyObject,
                  Constants.KEY_SKILL_TITLE : "gardening" as AnyObject,
                  Constants.KEY_SKILL_TAGS: [[ Constants.KEY_TAG_ID : 7 as AnyObject,
                                               Constants.KEY_TAG_STRING : "mowing" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 8 as AnyObject,
                                               Constants.KEY_TAG_STRING : "weeding" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 9 as AnyObject,
                                               Constants.KEY_TAG_STRING : "planting" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 10 as AnyObject,
                                               Constants.KEY_TAG_STRING : "pruning" as AnyObject]] as AnyObject,
                  Constants.KEY_SKILL_QUALIFICATIONS : "Details" as AnyObject,
                  Constants.KEY_SKILL_PRICE : 15 as AnyObject],
                [ Constants.KEY_SKILL_ID : 3 as AnyObject,
                  Constants.KEY_SKILL_TITLE : "oddjobs" as AnyObject,
                  Constants.KEY_SKILL_TAGS: [[ Constants.KEY_TAG_ID : 11 as AnyObject,
                                               Constants.KEY_TAG_STRING : "flatpack" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 12 as AnyObject,
                                               Constants.KEY_TAG_STRING : "picurehand" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 13 as AnyObject,
                                               Constants.KEY_TAG_STRING : "lifting" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 14 as AnyObject,
                                               Constants.KEY_TAG_STRING : "lightbulb" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 15 as AnyObject,
                                               Constants.KEY_TAG_STRING : "plug" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 16 as AnyObject,
                                               Constants.KEY_TAG_STRING : "radiator" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 17 as AnyObject,
                                               Constants.KEY_TAG_STRING : "logs" as AnyObject],
                                             [ Constants.KEY_TAG_ID : 18 as AnyObject,
                                               Constants.KEY_TAG_STRING : "blocked" as AnyObject]] as AnyObject,
                  Constants.KEY_SKILL_QUALIFICATIONS : "Details" as AnyObject,
                  Constants.KEY_SKILL_PRICE : 15 as AnyObject]
        ]
    }
    
    
    static func getTagsJson() -> [[String: AnyObject]]{
        return [[ Constants.KEY_TAG_ID : 0 as AnyObject,
                  Constants.KEY_TAG_STRING : "dog" as AnyObject],
                [ Constants.KEY_TAG_ID : 1 as AnyObject,
                  Constants.KEY_TAG_STRING : "help" as AnyObject],
                [ Constants.KEY_TAG_ID : 2 as AnyObject,
                  Constants.KEY_TAG_STRING : "walk" as AnyObject],
                [ Constants.KEY_TAG_ID : 3 as AnyObject,
                  Constants.KEY_TAG_STRING : "petcare" as AnyObject],
                [ Constants.KEY_TAG_ID : 4 as AnyObject,
                  Constants.KEY_TAG_STRING : "pethelp" as AnyObject],
                [ Constants.KEY_TAG_ID : 5 as AnyObject,
                  Constants.KEY_TAG_STRING : "windows" as AnyObject],
                [ Constants.KEY_TAG_ID : 6 as AnyObject,
                  Constants.KEY_TAG_STRING : "ladder" as AnyObject],
                [ Constants.KEY_TAG_ID : 7 as AnyObject,
                  Constants.KEY_TAG_STRING : "mowing" as AnyObject],
                [ Constants.KEY_TAG_ID : 8 as AnyObject,
                  Constants.KEY_TAG_STRING : "weeding" as AnyObject],
                [ Constants.KEY_TAG_ID : 9 as AnyObject,
                  Constants.KEY_TAG_STRING : "planting" as AnyObject],
                [ Constants.KEY_TAG_ID : 10 as AnyObject,
                  Constants.KEY_TAG_STRING : "pruning" as AnyObject],
                [ Constants.KEY_TAG_ID : 11 as AnyObject,
                  Constants.KEY_TAG_STRING : "flatpack" as AnyObject],
                [ Constants.KEY_TAG_ID : 12 as AnyObject,
                  Constants.KEY_TAG_STRING : "picurehand" as AnyObject],
                [ Constants.KEY_TAG_ID : 13 as AnyObject,
                  Constants.KEY_TAG_STRING : "lifting" as AnyObject],
                [ Constants.KEY_TAG_ID : 14 as AnyObject,
                  Constants.KEY_TAG_STRING : "lightbulb" as AnyObject],
                [ Constants.KEY_TAG_ID : 15 as AnyObject,
                  Constants.KEY_TAG_STRING : "plug" as AnyObject],
                [ Constants.KEY_TAG_ID : 16 as AnyObject,
                  Constants.KEY_TAG_STRING : "radiator" as AnyObject],
                [ Constants.KEY_TAG_ID : 17 as AnyObject,
                  Constants.KEY_TAG_STRING : "logs" as AnyObject],
                [ Constants.KEY_TAG_ID : 18 as AnyObject,
                  Constants.KEY_TAG_STRING : "blocked" as AnyObject]
        ] as [[String: AnyObject]]
    }
    
    static func getMe() -> [String: AnyObject] {
        return [
            Constants.KEY_USER_ID : 20 as AnyObject,
            Constants.KEY_USER_FIRSTNAME : "Quan" as AnyObject,
            Constants.KEY_USER_LASTNAME : "Zhuxian" as AnyObject,
            Constants.KEY_USER_PASSWORD : "bigshark@gmail.com" as AnyObject,
            Constants.KEY_USER_ADDRESS1 : "China" as AnyObject,
            Constants.KEY_USER_ADDRESS2 : "Jilin" as AnyObject,
            Constants.KEY_USER_ADDRESS3 : "Yanji" as AnyObject,
            Constants.KEY_USER_POSTCODE : "24689" as AnyObject,
            Constants.KEY_USER_BIRTHDAY : "1989/8/10" as AnyObject,
            Constants.KEY_USER_SKILLS : getSkillsJson() as AnyObject,
            Constants.KEY_USER_AVAILABLE : 1 as AnyObject,
            Constants.KEY_USER_PROFILEIMAGEURL : "" as AnyObject,
            Constants.KEY_USER_RANGEDISTANCE : 5 as AnyObject
        ]
    }
    
    
}
