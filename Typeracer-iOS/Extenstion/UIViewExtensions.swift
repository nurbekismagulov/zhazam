//
//  UIView+Gradient.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 23.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
        
    func setGradientBackground() {
        let colorTop =  UIColor.deepSkyBlue.cgColor
        let colorBottom = UIColor.dodgerBlue.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
