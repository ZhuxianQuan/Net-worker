//
//  DayScheduleModel.swift
//  Networker
//
//  Created by Big Shark on 27/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import UIKit


typealias ScheduleTime = (hour: Int , minute : Int)
typealias ScheduleDataTagColor = (red: CGFloat, green: CGFloat , blue: CGFloat, alpha: CGFloat)
typealias ScheduleDate = (year: Int, month: Int, day: Int)
typealias ScheduleMonth = (year: Int, month: Int)

class DayScheduleModel {
    var schedule_user_id: Int64 = 0
    var schedule_date = ScheduleDate(year: 0, month: 0, day: 0)
    var schedule_dayData : [ScheduleData] = []
    
    func getDateString() -> String {
        return "\(schedule_date.day)/\(CommonUtils.getMonthName(schedule_date.month)) \(schedule_date.year)"
    }
    
    func getMonthString() -> String {
        return "\(CommonUtils.getMonthName(schedule_date.month)) \(schedule_date.year)"
    }
}

class ScheduleData {
    
    var start_time = ScheduleTime(hour: 0 , minute: 0)
    var end_time = ScheduleTime(hour: 0 , minute: 0)
    var work_title = ""
    var job = SkillModel()
    var tag_color = ScheduleDataTagColor(red: 90.0/255.0, green: 190.0/255.0, blue: 226.0/255.0, alpha: 1)
    
}
