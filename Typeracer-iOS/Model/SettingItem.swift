//
//  SettingItem.swift
//  Typeracer-iOS
//
//  Created by Adlet on 08.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation
import UIKit

struct SettingItem {
    var image: UIImage?
    var title: String?
    
    static var list = [
        [SettingItem(image: #imageLiteral(resourceName: "settings"), title: "Rate us"),
         SettingItem(image: #imageLiteral(resourceName: "settings"), title: "Email")],
        [SettingItem(image: #imageLiteral(resourceName: "settings"), title: "Instagram"),
         SettingItem(image: #imageLiteral(resourceName: "settings"), title: "Facebook")
        ]
    ]
}
