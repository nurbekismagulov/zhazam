//
//  CarModel.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 28.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation

class Vehicle {
    var fullImage: String
    var iconImages: [String]
    var name: String
    
    init(fullImage: String, iconImages: [String], name: String) {
        self.fullImage = fullImage
        self.iconImages = iconImages
        self.name = name
    }
}
