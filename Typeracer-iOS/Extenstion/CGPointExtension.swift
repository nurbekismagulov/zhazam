//
//  CGPointExtension.swift
//  Typeracer-iOS
//
//  Created by Adlet on 03.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit

extension CGPoint {
    func distance(_ a: CGPoint) -> CGFloat {
        let xDist = fabs(a.x - self.x)
        let yDist = fabs(a.y - self.y)
        return CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
    }
}
