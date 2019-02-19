//
//  Random.swift
//  Typeracer-iOS
//
//  Created by Adlet on 03.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation
import UIKit

struct Random {
    
    static func generatePoint(min: CGPoint, max: CGPoint) -> CGPoint {
        return CGPoint(x: generateCGFloat(min.x, max.x), y: generateCGFloat(min.y, max.y))
    }

    static func generateCGFloat(_ lower: CGFloat, _ upper: CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
    
}
