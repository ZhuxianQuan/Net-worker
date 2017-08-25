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
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
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
    /*
    static func getStringForTags(){
        
    }*/
    
    static func getRandomNumber(_ maxValue : Int) -> Int{
        return Int(arc4random_uniform(UInt32(maxValue)))
    }
    /*
    static func getDistance(location1 : (Double, Double) , location2 : (Double, Double)) -> Double{
        var distance : Double = 0
        return distance
    }*/
    
    static func getDistanceFromMe(_ user: UserModel) -> Double{
        let mylocation = CLLocation(latitude: currentLatitude, longitude: currentLongitude)
        let userlocaiton = CLLocation(latitude: user.user_latitude, longitude: user.user_longitude)
        return mylocation.distance(from: userlocaiton) / 1609.344
    }
    
    static func logout() {
        currentUser = UserModel()
        UserDefaults.standard.removeObject(forKey: Constants.KEY_USER_PASSWORD)
        UserDefaults.standard.removeObject(forKey: Constants.KEY_USER_EMAIL)
    }
    
    
    static func getSavedFileUrl(_ urlString: String) -> URL?{
        
        let filenames = urlString.components(separatedBy: "/")
        let filename = filenames[filenames.count - 1]
        var savedFilePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])"  + "/" + filename
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: savedFilePath) {
            savedFilePath = "file:" + savedFilePath
            let localURL = URL(string: savedFilePath)!
            return localURL
        }
        else {
            return nil
        }
    }
    
    static func saveImageToLocal(_ filename: String, data: Data) {
        var savedFilePath = "\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])"  + "/" + filename
        
        do {
            savedFilePath = "file:" + savedFilePath
            try data.write(to: URL(string: savedFilePath)!)
        }
        catch {
            print(error)
        }
    }    
    
    //MARK: - Schedule related functions
    
    //get total value for month
    static func getTotalValueofMonth(days: Int) -> Int64 {
        return Int64(1 << (days - 1)) - 1
    }
    
    ///***Get the number of days in given month and year
    
        
    static func getDaySchedule(day : Int, schedules: [DayScheduleModel]) -> DayScheduleModel?{
        for schedule in schedules {
            if day == schedule.day {
                return schedule
            }
        }
        return nil
    }

}



