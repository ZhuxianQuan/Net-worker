//
//  DayScheduleModel.swift
//  Networker
//
//  Created by Big Shark on 27/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import UIKit
import EventKit


class DayScheduleModel {
    
    let MORNING = 50
    let AFTERNOON = 51
    let EVENING = 52
    
    
    let EVENT_DELIMITER = "eevvee"
    
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
        let eventItems = notes.components(separatedBy: EVENT_DELIMITER)
        for item in eventItems {
            if item.characters.count > 2 {
                events.append(EventSchedule(notes: item, day: day))
            }
        }
        return events
    }
    
    func addEvent(_ event: EventSchedule) {
        day_schedule = day_schedule & event.eventTimeValue
        
    }
    
    func isNewTime(_ event: EventSchedule) -> Bool {
        if self.day_schedule & event.eventTimeValue > 0 {
            return false
        }
        return true
    }
}

class EventSchedule {
    
    var day = 0
    var startTime: Int = 0
    var endTime : Int = 0
    var notes : String = ""
    var color : Int = 0
    var saveEventId = ""
    
    let EVENT_ITEM_DELIMITER = "*-*-*"
    
    var eventTimeValue : Int64 {
        get {
            if endTime > 0 && startTime > 0 {
                
                return Int64(1 << (endTime - startTime) - 1) << Int64(startTime - 1)
            }
            else {
                return 0
            }
        }
    }
    
    var total_notes : String {
        get {
            return String(format: "%d%@%d%@%@%@%@", startTime, EVENT_ITEM_DELIMITER, endTime, EVENT_ITEM_DELIMITER, notes, EVENT_ITEM_DELIMITER, saveEventId)
        }
    }
    
    init() {
        
    }
    
    init(notes : String, day: Int) {
        self.day = day
        let items = notes.components(separatedBy: EVENT_ITEM_DELIMITER)
        self.startTime = Int(items[0])!
        self.endTime = Int(items[1])!
        self.notes = items[2]
        self.saveEventId = items[3]
        //self.color = Int(items[4])!
        
    }
    
    func addEventToCalendar() {
        let store = EKEventStore()
        
        store.requestAccess(to: .event, completion: {
            granted, error in
            if !granted {
                return
            }
            let event = EKEvent(eventStore: store)
            event.title = self.notes
            event.startDate = DateUtils.getDate(self.day, time: self.startTime)
            event.endDate = DateUtils.getDate(self.day, time: self.endTime)
            event.calendar = store.defaultCalendarForNewEvents
            do {
                try store.save(event, span: .thisEvent, commit: true)
                self.saveEventId = event.eventIdentifier
            }
            catch {
                
            }
            
        })
    }
    
    func removeEventFromCalendar() {
        let store = EKEventStore()
        store.requestAccess(to: .event, completion: {
            granted, error in
            if !granted {
                return
            }
            let eventToRemove = store.event(withIdentifier: self.saveEventId)
            if eventToRemove != nil {
                do {
                    try store.remove(eventToRemove!, span: .thisEvent)
                }
                catch {
                    
                }
            }
        })
        
    }
    
}

