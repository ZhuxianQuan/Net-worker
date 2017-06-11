//
//  SwiftyJSON+Extension.swift
//  PubPress
//
//  Created by Zhuxian on 4/18/17.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import SwiftyJSON


extension JSON
{
    public var nonNullInt64Value: Int64{
        get {
            if self.string != nil{
                if Int64(self.string!)! > 0{
                    return Int64(self.string!)!
                }
            }
            if self.number?.int64Value == nil{
                return 0
            }
            else{
                return (self.number?.int64Value)!
            }
        }
    }
    
    public var nonNullIntValue: Int{
        get {
            if self.string != nil{
                if Int(self.string!)!>0{
                    return Int(self.string!)!
                }
            }
            if self.number?.intValue == nil{
                return 0
            }
            else{
                return (self.number?.intValue)!
            }
        }
    }
    
    public var nonNullDoubleValue: Double{
        get {
            if self.string != nil{
                if Double(self.string!)!>0{
                    return Double(self.string!)!
                }
            }
            if self.number?.doubleValue == nil{
                return 0.0
            }
            else{
                return (self.number?.doubleValue)!
            }
        }
    }
    
    
    public var nonNullStringValue: String{
        get {
            
            if self.string == nil{
                return ""
            }
            else{
                return (self.string)!
            }
        }
    }
    
    public var nonNullBoolValue: Bool{
        get {
            
            if self.bool == nil{
                return false
            }
            else{
                return self.bool!
            }
        }
    }
    
}
