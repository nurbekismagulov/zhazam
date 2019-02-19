//
//  UIColor+Pallete.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 23.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let catalinaBlue = "1A2D4A".hexColor
    static let dodgerBlue = "44A1FF".hexColor
    static let deepSkyBlue = "79CFFF".hexColor
    static let silverGray = "BEBEBE".hexColor
    static let candyAppleRed = "E84D3C".hexColor
    static let appleGreen = "73E0AE".hexColor
    
    static func random() -> UIColor {
        return UIColor(red:   .randomColor(),
                       green: .randomColor(),
                       blue:  .randomColor(),
                       alpha: 1.0)
    }
    
}

