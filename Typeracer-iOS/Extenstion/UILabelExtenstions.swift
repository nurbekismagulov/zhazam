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
    
    func setStyle(){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
        self.layer.cornerRadius = 60
        self.layer.borderWidth = 3
        self.textAlignment = .center
        self.backgroundColor = .clear
        self.layer.masksToBounds = true
    }

}


