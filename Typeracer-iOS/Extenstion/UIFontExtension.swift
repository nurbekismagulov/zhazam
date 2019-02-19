//
//  UIFontExtension.swift
//  Typeracer-iOS
//
//  Created by Adlet on 06.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func setCabinSketch(ofSize size: CGFloat) -> UIFont{
        if let font = UIFont(name: "CabinSketch-Bold", size: size){
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
}
