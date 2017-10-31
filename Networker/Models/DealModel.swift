//
//  DealModel.swift
//  Networker
//
//  Created by Quan Zhuxian on 24/08/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class DealModel {
    
    var deal_id: Int64 = 0
    var deal_client = UserModel()
    var deal_worker = UserModel()
    var deal_starttime = 0
    var deal_endtime = 0
    var deal_startday = 0
    var deal_endday = 0
    var deal_status = 0
    var deal_skill = SkillModel()
    var deal_distance: Float = 0.0
    var deal_notes = ""
    var request_id = Int64(0)
    var request_timestamp = Int64(0)
    var request_status = 0
    
    
    var deal_string : String {
        get {
            return String(format: "%@\n\n %@\n%@\n%@",deal_notes, DateUtils.getDateString(dayValue: deal_startday), DateUtils.getDateString(dayValue: deal_endday))
        }
    }

    
    func getObject() -> [String: AnyObject] {
        var result = [String: AnyObject]()
        
        result[Constants.KEY_DEAL_ID] = deal_id as AnyObject
        result[Constants.KEY_DEAL_CLIENT] = deal_client.user_id as AnyObject
        result[Constants.KEY_DEAL_WORKER] = deal_worker.user_id as AnyObject
        result[Constants.KEY_DEAL_STARTDAY] = deal_startday as AnyObject
        result[Constants.KEY_DEAL_ENDDAY] = deal_endday as AnyObject
        result[Constants.KEY_DEAL_STARTTIME] = deal_starttime as AnyObject
        result[Constants.KEY_DEAL_ENDTIME] = deal_endtime as AnyObject
        result[Constants.KEY_DEAL_SKILL] = deal_skill.skill_id as AnyObject
        result[Constants.KEY_DEAL_NOTES] = deal_notes as AnyObject
        return result
    }
}
