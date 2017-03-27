//
//  UIView+Extension.swift
//  Networker
//
//  Created by Big Shark on 20/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import UIKit
/*
class UnderlinedLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}
*/
extension UILabel {
    func underlineText(){
        guard let text = text else { return }
        let textRange = NSMakeRange(0, text.characters.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
        // Add other attributes if needed
        self.attributedText = attributedText
    }
}

