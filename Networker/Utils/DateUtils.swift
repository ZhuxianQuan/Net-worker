//
//  DateUtils.swift
//  Networker
//
//  Created by Quan Zhuxian on 24/08/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation


class DateUtils {
    
    class func getDaysofMonth(year: Int, month: Int) -> Int{
        
        let dateComponents = DateComponents(year: year, month:  month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        return numDays
    }
    
    
    
    static func getMonthName(_ month: Int) -> String {
        var monthString = ""
        switch month {
        case 1:
            monthString = "January"
            break
        case 2:
            monthString = "February"
            break
        case 3:
            monthString = "March"
            break
        case 4:
            monthString = "April"
            break
        case 5:
            monthString = "May"
            break
        case 6:
            monthString = "June"
            break
        case 7:
            monthString = "July"
            break
        case 8:
            monthString = "August"
            break
        case 9:
            monthString = "September"
            break
        case 10:
            monthString = "October"
            break
        case 11:
            monthString = "November"
            break
        default:
            monthString = "December"
            break
        }
        return monthString
    }
    
    
    
    //time string functions
    
    // 1 : 0:00
    // 16 : 7:30
    //48: 23: 30
    
    static func getString(from : Int) -> String {
        let hour = Int((from - 1) / 2)
        let min = (from % 2) == 0 ? 30 : 00
        if hour < 12 {
            return String(format: "%d : %02d AM", hour, min)
        }
        else {
            return String(format: "%d : %02d PM", hour == 12 ? 12 : hour - 12, min)
        }
    }
    
    static func getWeekDays(_ date: Date) -> [Int] {
        
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        var weekdays = [Int]()
        for index in 1 ... 7 {
            let newInterval = Int64(date.timeIntervalSince1970) + 86400 * Int64(index - weekday)
            let newDate = Date(timeIntervalSince1970: TimeInterval(newInterval))
            if getDayValue(newDate) >= getDayValue(Date()){
                weekdays.append(getDayValue(newDate))
            }
        }
        return weekdays
    }
    
    static func getDaysArray() -> [Int]{
        var days = [Int]()
        let date = Date()
        for index in 0 ..< 60 {
            let newInterval = Int64(date.timeIntervalSince1970) + 86400 * Int64(index)
            let newDate = Date(timeIntervalSince1970: TimeInterval(newInterval))
            if getDayValue(newDate) >= getDayValue(Date()){
                days.append(getDayValue(newDate))
            }
        }
        return days
    }
    
    static func getDayValue(_ date: Date) -> Int{
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        return year * 10000 + month * 100 + day
    }
    
    static func getDate(_ dayValue: Int, time: Int? = nil) -> Date {
        let year = dayValue / 10000
        let month = dayValue / 100 - year * 100
        let day = dayValue % 100
        var components = DateComponents()
        if time != nil {
            let hour = Int((time! - 1) / 2)
            let min = (time! % 2) == 0 ? 30 : 00
            components = DateComponents(year: year, month: month, day: day, hour: hour, minute: min)
        }
        else {
            components = DateComponents(year: year, month: month, day: day)
        }
        let calendar = Calendar.current
        return calendar.date(from: components)!
    }
    
    static func getDateString(dayValue: Int) -> String {
        let year = dayValue / 10000
        let month = dayValue / 100 - year * 100
        let day = dayValue % 100
        let components = DateComponents(year: year, month: month, day: day)
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: calendar.date(from: components)!)
    }
    
    
    static func getShortDateString(dayValue: Int) -> String {
        let year = dayValue / 10000
        let month = dayValue / 100 - year * 100
        let day = dayValue % 100
        let components = DateComponents(year: year, month: month, day: day)
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: calendar.date(from: components)!)
    }
    static func getFullDateString(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: date)
    }
    
    static func getWeekdayString(_ value: Int) -> String{
        switch value {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return ""
        }
    }
    
    static func getDaysArray(from : Int, to : Int) -> [Int] {
        var days = [Int]()
        let availableDays = getDaysArray()
        for day in availableDays {
            if day >= from && day <= to {
                days.append(day)
            }
        }
        
        return days
        
    }
    


}
