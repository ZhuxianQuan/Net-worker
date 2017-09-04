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
    
    var schedule_events:[EventSchedule] {
        get {
            var events = [EventSchedule]()
            let eventItems = notes.components(separatedBy: EVENT_DELIMITER)
            for item in eventItems {
                if item.characters.count > 2 {
                    events.append(EventSchedule(notes: item, day: day))
                }
            }
            return events
        }
    }
    
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
    
    
    func addEvent(_ event: EventSchedule, completion: @escaping (String) -> ()) {
        day_schedule = day_schedule | event.eventTimeValue
        var events = [EventSchedule]()
        let arrays = getEventArrays(event)
        mergeEvent(event, events: arrays.1, completion: {
            newMiddleEvents in
            events.append(contentsOf: arrays.0)
            events.append(contentsOf: newMiddleEvents)
            events.append(contentsOf: arrays.2)
            self.setNotesString(events)
            completion(Constants.PROCESS_SUCCESS)
        })
        
    }
    
    func mergeEvent(_ event: EventSchedule, events :[EventSchedule], completion: @escaping([EventSchedule]) -> ()) {
        if events.count == 0 {
            event.addEventToCalendar(completion: {
                message in
                completion([event])
            })
        }
        else {
            var result = [EventSchedule]()
            if events[0].startTime < event.startTime {
                let firstEvent = events[0]
                firstEvent.endTime = event.startTime
                result.append(firstEvent)
            }
            result.append(event)
            if events[events.count - 1].endTime > event.endTime {
                let lastEvent = events[events.count - 1]
                lastEvent.startTime = event.endTime
                result.append(lastEvent)
            }
            
            var loaded = 0
            var maxLoaded = events.count
            for event in events {
                event.removeEventFromCalendar(completion: {
                    _ in
                    loaded += 1
                    if loaded == maxLoaded {
                        loaded = 0
                        maxLoaded = result.count
                        for event in result {
                            event.addEventToCalendar(completion: {
                                _ in
                                loaded += 1
                                if loaded == maxLoaded {
                                    completion(result)
                                }
                            })
                        }
                    }
                })
            }
        }
    }
    
    func getEventArrays(_ event: EventSchedule) -> ([EventSchedule], [EventSchedule], [EventSchedule]){
        var prevEvents = [EventSchedule]()
        var middleEvents = [EventSchedule]()
        var nextEvents = [EventSchedule]()
        for item in schedule_events {
            if item.endTime <= event.startTime {
                prevEvents.append(item)
            }
            else if item.eventTimeValue & event.eventTimeValue > 0{
                middleEvents.append(item)
            }
            else {
                nextEvents.append(item)
            }
        }
        return (prevEvents, middleEvents, nextEvents)
    }
    
    func setNotesString(_ events: [EventSchedule]) {
        var notesString = ""
        for event in events {
            if notesString.characters.count == 0 {
                notesString = event.total_notes
            }
            else {
                notesString.append(EVENT_DELIMITER + event.total_notes)
            }
        }
        self.notes = notesString
    }
    
    func getObject() -> [String: AnyObject]{
        var result = [String: AnyObject]()
        result[Constants.KEY_SCHEDULE_ID] = schedule_id as AnyObject
        result[Constants.KEY_SCHEDULE_DAY] = day as AnyObject
        result[Constants.KEY_SCHEDULE_DAYVALUE] = day_schedule as AnyObject
        result[Constants.KEY_SCHEDULE_NOTES] = notes as AnyObject
        result[Constants.KEY_USER_ID] = user_id as AnyObject
        return result
    }
}

class EventSchedule {
    
    var day = 0
    var startTime: Int = 0
    var endTime : Int = 0
    var notes : String = ""
    var color : Int = 0
    var saveEventId = ""
    var alarmBefore: Int = 3
    
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
    
    func addEventToCalendar(completion: @escaping (String) -> ()) {
        let store = EKEventStore()        
        store.requestAccess(to: .event, completion: {
            granted, error in
            if !granted {
                completion(Constants.PROCESS_FAIL)
                return
            }
            let event = EKEvent(eventStore: store)
            event.title = self.notes
            event.startDate = DateUtils.getDate(self.day, time: self.startTime)
            event.endDate = DateUtils.getDate(self.day, time: self.endTime)
            event.calendar = store.defaultCalendarForNewEvents
            let alarm = EKAlarm(relativeOffset: TimeInterval(self.alarmBefore))
            event.addAlarm(alarm)
            do {
                try store.save(event, span: .thisEvent, commit: true)
                self.saveEventId = event.eventIdentifier
                completion(Constants.PROCESS_SUCCESS)
            }
            catch {
                completion(Constants.PROCESS_FAIL)
            }
            
        })
    }
    
    func removeEventFromCalendar(completion: @escaping (String) -> ()) {
        let store = EKEventStore()
        store.requestAccess(to: .event, completion: {
            granted, error in
            if !granted {
                completion(Constants.PROCESS_FAIL)
                return
            }
            let eventToRemove = store.event(withIdentifier: self.saveEventId)
            if eventToRemove != nil {
                do {
                    try store.remove(eventToRemove!, span: .thisEvent)
                    completion(Constants.PROCESS_SUCCESS)
                }
                catch {
                    completion(Constants.PROCESS_FAIL)
                }
            }
        })
        
    }
    
    static func createEventsFrom(startDay: Int, endDay: Int, startTime: Int, endTime: Int, notes: String) -> [EventSchedule] {
        
        var events = [EventSchedule]()
        let days = DateUtils.getDaysArray(from: startDay, to: endDay)
        for day in days {
            let event = EventSchedule()
            event.day = day
            event.startTime = startTime
            event.endTime = endTime
            event.notes = notes
            events.append(event)
        }
        return events
        
    }
    
}


