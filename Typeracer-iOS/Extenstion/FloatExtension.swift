//
//  FloatExtension.swift
//  Typeracer-iOS
//
//  Created by Adlet on 04.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation
import UIKit


extension Float {
    
    static var random: Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
    
    static func random(min: Float, max: Float) -> Float {
        return Float.random * (max - min) + min
    }
}

