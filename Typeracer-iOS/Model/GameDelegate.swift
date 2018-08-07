//
//  GameDelegate.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 01.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation

protocol GameDelegate: AnyObject {
    
    func gameDidStart()
    func gameDidRestart()
    func gameWPMDidUpdate()
    func textDidUpdateLetter()
    func textDidUpdateRightWord()
    func gameDidFinish()
    func timerDidUpdate(with time: Int)
}
