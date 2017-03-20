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


class CommonUtils: AnyObject{
    
    static func isValidEmail(_ email: String) -> Bool {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
 
    
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        //let size = image.size
        
        /*let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width:size.width * widthRatio,  height: size.height * widthRatio)
        }*/
        
        // This is the rect that we've calculated out and this is what is actually used below
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
    
    
    

    
    
}



