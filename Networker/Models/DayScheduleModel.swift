//
//  DayScheduleModel.swift
//  Networker
//
//  Created by Big Shark on 27/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import UIKit



class DayScheduleModel {
    
    let MORNING = 50
    let AFTERNOON = 51
    let EVENING = 52
    
    var user_id : Int64 = 0
    var schedule_id : Int = 0
    var day : Int = 0
    var day_schedule : Int64 = 0
    var notes = ""
    
    func setBusy(time : Int) {
        if time == MORNING{
            day_schedule = day_schedule - (day_schedule & Int64(255 << 16))
        }
        else if time == AFTERNOON {
            day_schedule = day_schedule - (day_schedule & Int64(255 << 24))
        }
        else if time == EVENING {
            day_schedule = day_schedule - (day_schedule & Int64(255 << 32))
        }
        else {
            day_schedule = day_schedule - (day_schedule & Int64(1 << time))
        }
    }
    
    func setAvailable(time : Int) {
        if time == MORNING{
            day_schedule = day_schedule | Int64(255 << 16)
        }
        else if time == AFTERNOON {
            day_schedule = day_schedule | Int64(255 << 24)
        }
        else if time == EVENING {
            day_schedule = day_schedule | Int64(255 << 32)
        }
        else {
            day_schedule = day_schedule | Int64(1 << time)
        }
    }
    
    func setAvailableAllDay() {
        day_schedule = Int64(1 << 48) - 1
    }
    
    func setBusyAllDay() {
        day_schedule = 0
    }
    
    func getScheduleArray() -> [EventSchedule] {
        var events = [EventSchedule]()
        
        return events
    }
}

class EventSchedule {
    //var day :
}

