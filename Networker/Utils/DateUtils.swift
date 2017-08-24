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
    
    // 1 : 0 - 0:30
    // 16 : 7:30 - 8:00
    static func getString(from : Int) -> String {
        let hour = Int((from - 1) / 2)
        let min = (from % 2) == 0 ? "30" : "00"
        return "\(hour):\(min)"
    }

}
