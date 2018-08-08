//
//  Game.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 01.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation

protocol Game {
    
    var text: String { get set }
    var textArray: [String] { get set }
    var atWord: Int { get set }
    var correctLetters: Int { get set }
    var wrongLetters: Int {get set}
    var timer: Timer { get set }
    var seconds: Int { get set }
    var wpm: Int {get set}
    func calculateWPM()
    
    func start()
    func finish()
    func restart()
}

