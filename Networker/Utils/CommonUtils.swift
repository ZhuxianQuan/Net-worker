//
//  CommonUtils.swift
//  FelineFitness
//
//  Created by Huijing on 08/12/2016.
//  Copyright © 2016 Huijing. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreLocation

class CommonUtils: AnyObject{
    
    static func isValidEmail(_ email: String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
 
    
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        
        let rect = CGRect(x:0, y: 0, width : targetSize.width, height : targetSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static func getTimeString(from timeStamp: Int64) -> String{
        if (timeStamp < 60){
            return "less than a minute"
        }
        else if(timeStamp < 3600)
        {
            let value = Int(timeStamp/60)
            
            if value > 1 {
                return "\(value) minutes ago"
            }
            else {
                return "a minute ago"
            }
        }
        else if(timeStamp < 86400)
        {
            let value = Int(timeStamp/3600)
            
            if value > 1 {
                return "\(value) hours ago"
            }
            else {
                return "an hour ago"
            }
        }
        else if(timeStamp < 604800)
        {
            let value = Int(timeStamp/86400)
            
            if value > 1 {
                return "\(value) days ago"
            }
            else {
                return "a day ago"
            }
        }
        else if(timeStamp < 2592000){
            let value = Int(timeStamp/604800)
            
            if value > 1 {
                return "\(value) weeks ago"
            }
            else {
                return "a week ago"
            }
        }
        else{
            let value = Int(timeStamp/2592000)
            if value > 1 {
                return "\(value) months ago"
            }
            else {
                return "a month ago"
            }
        }
    }
    
    static func getSortedString(_ strings: [String]) -> [String]{
        let sortedArray = strings.sorted {
            $0 < $1
        }
        return sortedArray
    }
    
    static func getStringForTags(){
        
    }
    
    static func getRandomNumber(_ maxValue : Int) -> Int{
        return Int(arc4random_uniform(UInt32(maxValue)))
    }
    
    static func getDistance(location1 : (Double, Double) , location2 : (Double, Double)) -> Double{
        var distance : Double = 0
        return distance
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
    
    static func getDaysCount(month: Int, year : Int) -> Int {
        switch month {
        case 1:
            return 31
            
        case 2:
            if year % 4 == 0{
                if year % 400 == 0 {
                    return 29
                }
                else if year % 100 == 0{
                    return 28
                }
                else{
                    return 29
                }
            }
            else {
                return 28
            }
            
        case 3:
            return 31
            
        case 4:
            return 30
            
        case 5:
            return 31
            
        case 6:
            return 30
            
        case 7:
            return 31
            
        case 8:
            return 31
            
        case 9:
            return 30
            
        case 10:
            return 31
            
        case 11:
            return 30
            
        default:
            return 31
            
        }
    }
    
    static func getScheduleMonth(_ monthString : String) -> ScheduleMonth{
        var month = 0
        var year = 0
        let monthArray = monthString.components(separatedBy: " ")
        month = Int(monthArray[0])!
        year = Int(monthArray[1])!
        return ScheduleMonth(year: year, month: month)
    }
    
    
    static func getDistanceFromMe(_ user: UserModel) -> Double{
        let mylocation = CLLocation(latitude: currentLatitude, longitude: currentLongitude)
        let userlocaiton = CLLocation(latitude: user.user_latitude, longitude: user.user_longitude)
        return mylocation.distance(from: userlocaiton) / 1609.344
    }
    
    

    
    
}



