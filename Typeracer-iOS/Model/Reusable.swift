//
//  Reusable.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 30.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation

protocol Reusable {
    
    var identifier: String { get }
}

extension Reusable {
    
    var identifier: String {
        return String(describing: self)
    }
}
