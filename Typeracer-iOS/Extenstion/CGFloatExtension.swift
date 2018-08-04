//
//  CGFloatExtension.swift
//  Typeracer-iOS
//
//  Created by Adlet on 04.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random * (max - min) + min
    }
    
    static var random: CGFloat {
        return CGFloat(Float.random)
    }
    
    static var randomSign: CGFloat {
        return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
    }
    
    static func randomColor() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
