//
//  DealModel.swift
//  Networker
//
//  Created by Quan Zhuxian on 24/08/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class DealModel {
    
    var deal_client = UserModel()
    var deal_worker = UserModel()
    var deal_starttime = 0
    var deal_endtime = 0
    var deal_startday = 0
    var deal_endday = 0
    var deal_status = 0
    var deal_skill = SkillModel()
    var deal_distance: Float = 0.0
}
