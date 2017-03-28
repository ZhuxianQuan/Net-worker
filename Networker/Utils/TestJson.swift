
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
            Constants.KEY_USER_RANGEDISTANCE : 5 as AnyObject,
            Constants.KEY_USER_LATITUDE : currentLatitude as AnyObject,
            Constants.KEY_USER_LONGITUDE : currentLongitude as AnyObject,
            Constants.KEY_USER_RATINGS : getRatings(20) as AnyObject
        ]
    }
    
    static func nearMeUsers() -> [[String: AnyObject]]{
        var result : [[String : AnyObject]] = []
        var index: Int64 = 0
        for imageurl in getImages() {
            index += 1
            var userObject = getMe()
            userObject[Constants.KEY_USER_ID] = index as AnyObject
            userObject[Constants.KEY_USER_FIRSTNAME] = "First\(index)" as AnyObject
            userObject[Constants.KEY_USER_LASTNAME] = "Last\(index)" as AnyObject
            userObject[Constants.KEY_USER_PROFILEIMAGEURL] = imageurl as AnyObject
            userObject[Constants.KEY_USER_LATITUDE] = (currentLatitude + 0.05 * (Double(CommonUtils.getRandomNumber(1000))) / 1000.0 * pow( (-1), Double(CommonUtils.getRandomNumber(20)))) as AnyObject
            userObject[Constants.KEY_USER_LONGITUDE] = (currentLongitude + 0.05 * (Double(CommonUtils.getRandomNumber(1000))) / 1000.0 * pow( (-1), Double(CommonUtils.getRandomNumber(20)))) as AnyObject
            userObject[Constants.KEY_USER_RATINGS] = getRatings(index) as AnyObject
            var skillsObject = getSkillsJson()
            skillsObject.remove(at: Int(index) % skillsObject.count)
            userObject[Constants.KEY_USER_SKILLS] = skillsObject as AnyObject
            result.append(userObject)
        }
        return result
    }
    
    static func getImages() -> [String] {
        var result : [String] = []
        
        result.append("https://s-media-cache-ak0.pinimg.com/236x/c0/2a/2e/c02a2ed987f8a55a38be617d3d470f4f.jpg")
        result.append("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0JkZApeSa5KypkES88terHmuvFNY1zD37H7FdnSzcSsrvPZg_")
        result.append("https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcT_V_63DRJXal0jdyOTrV0ATEuY0xU4KjHXTZBiabAxsrNnU4D2")
        result.append("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3Ea3_AGfCzoNO-yPjdU44VyXq1DL9LPn6T2iQBmEglKycoWHf")
        result.append("https://www.drupal.org/files/project-images/SNP_29271A9F131A2BFDF369CD990598E1D76169_3270506_en_v0.png")
        result.append("https://s-media-cache-ak0.pinimg.com/236x/c0/2a/2e/c02a2ed987f8a55a38be617d3d470f4f.jpg")
        result.append("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0JkZApeSa5KypkES88terHmuvFNY1zD37H7FdnSzcSsrvPZg_")
        result.append("https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcT_V_63DRJXal0jdyOTrV0ATEuY0xU4KjHXTZBiabAxsrNnU4D2")
        result.append("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3Ea3_AGfCzoNO-yPjdU44VyXq1DL9LPn6T2iQBmEglKycoWHf")
        result.append("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3dctEofLbwEOG84dCwc3oydy93S05e3JANGoVJo7YlU6S5kBJ")
        result.append("https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSJB0PMJwkAc9-Uan0FARGUkx2nKlCYiAtbGoBEpB4vh6-HglBk")
        result.append("https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRlgqtBWYlEeRGA8H6F4BzZgkPqiDtOaA_npT9L6WiZtApseGwnSA")
        result.append("https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcR1Lf5aTQzCgg5PuI6WnBGv2BsTxqYd5HWhf3px_1pb-5GmmAHG")
        result.append("https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQ9z6yZfzs3g_1xH63SfVFtMdSgThVaxYIvjTp0QonzGZKvKZCC")
        result.append("https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSeCUjJGL4JJwZt9eKPj4kMqPHs_RFzuNuYvhstqNQZF1TyfVEX ")
        
        return result
    }
    
    static func getRatings(_ id: Int64) -> [[String: AnyObject]] {
        var result : [[String: AnyObject]] = []
        for senderId in 1...5{
            
            var ratingObject : [String: AnyObject] = [:]
            ratingObject[Constants.KEY_RATING_ID] = senderId as AnyObject
            ratingObject[Constants.KEY_RATING_SENDER] = id as AnyObject
            ratingObject[Constants.KEY_RATING_RECEIVER] = id as AnyObject
            ratingObject[Constants.KEY_RATING_COMMENT] = "Review model for testing \(senderId) to \(id)" as AnyObject
            ratingObject[Constants.KEY_RATING_MARKS] = 5 * Float(CommonUtils.getRandomNumber(100)) / 100.0 as AnyObject
            ratingObject[Constants.KEY_RATING_TIMESTAMP] = getGlobalTime() as AnyObject
            ratingObject[Constants.KEY_RATING_SENDERNAME] = "test sender name \(senderId)" as AnyObject
            result.append(ratingObject)
        }
        
        return result
    }
    
    
}
/**/


