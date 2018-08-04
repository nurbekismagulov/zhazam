//
//  UILabelExtenstions.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 23.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setTextWithTypeAnimation(typedText: String, characterInterval: TimeInterval = 0.35) {
        DispatchQueue.main.async {
            self.text = ""
        }
        
        DispatchQueue.global(qos: .userInteractive).async {

            for character in typedText {
                DispatchQueue.main.async {
                    self.text = self.text! + String(character)
                }
                Thread.sleep(forTimeInterval: characterInterval)
            }
            self.setTextWithTypeAnimation(typedText: typedText)
        }
    }
    

}


