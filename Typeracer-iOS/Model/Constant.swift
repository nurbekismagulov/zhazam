//
//  Constant.swift
//  Typeracer-iOS
//
//  Created by Adlet on 08.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    
    static func multiplyToWidth(number: Int) -> CGFloat{
        return ((CGFloat(number)/375) * (UIScreen.main.bounds.width))
    }
    
    static func multiplyToHeight(number: Int) -> CGFloat{
        if UIScreen.main.bounds.height == 812 {
            return ((CGFloat(number)/(812)) * (UIScreen.main.bounds.height) )
        } else {
            return ((CGFloat(number)/667) * (UIScreen.main.bounds.height) )
        }
    }
}

