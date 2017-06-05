//
//  UIView+Extension.swift
//  Networker
//
//  Created by Big Shark on 20/03/2017.
//  Copyright © 2017 shark. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
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

extension UIImageView{
    
    
    func setImageWith(color: UIColor)
    {        
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
    
    func setImageWith(_ urlString : String, placeholderImage: UIImage) {
        
        let localUrl = CommonUtils.getSavedFileUrl(urlString)
        if localUrl == nil {
            image = placeholderImage
            ApiFunctions.downloadFile(urlString: urlString) { (message, url) in
                if message == Constants.PROCESS_SUCCESS {
                    self.sd_setImage(with: url)
                }
            }
        }
        else {
            self.sd_setImage(with: localUrl!, completed: nil)
        }
        
    }
}


