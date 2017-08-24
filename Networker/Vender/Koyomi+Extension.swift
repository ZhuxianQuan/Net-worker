//
//  Koyomi+Extension.swift
//  Networker
//
//  Created by Big Shark on 26/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation

extension Koyomi {
    func getMonthValue() -> Int {
        let monthString = currentDateString(withFormat: "MM yyyy")
        let string = monthString.components(separatedBy: " ")
        return Int(string[1])! * 100 + Int(string[0])!
        
    }
}

