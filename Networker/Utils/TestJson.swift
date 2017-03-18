
//
//  TestJson.swift
//  Networker
//
//  Created by Big Shark on 18/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class TestJson{
    
    func getUserJson() -> [String : Any]
    {
        return [Constants.KEY_USER_ID : 1,
                Constants.KEY_USER_EMAIL : "bigshark@gmail.com"
        ]
    }
    
    func getSkillsJson() -> [[String: Any]]{
        var result: [[String: Any]] = []
        var skillObject : [String: Any] = [:]
                
        result.append(skillObject)
        return []
    }
}
