//
//  ClassicGame.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 01.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation

class ClassicGame: Game {
    
    // MARK: - Protocol properties
    var text: String
    
    var textArray: [String]
    
    var atWord: Int
    
    var correctWords: Int
    
    var timer: Timer
    
    var seconds: Int
    
    weak var delegate: GameDelegate?
    
    init() {
        self.text = ""
        self.textArray = []
        self.atWord = 0
        self.correctWords = 0
        self.timer = Timer()
        self.seconds = 0
        self.correctText = ""
    }
    // MARK: - Classic game properties
    
//    var icon: String = ""
    var correctText: String = ""
    
    func calculateWPM() -> String {
        let minute = Double(seconds) / 60.0
        if seconds > 0 {
            let wpm = String(Int(Double(correctWords) / 5 / minute)) + " wpm"
            print(correctWords)
            print(minute)
            return wpm
        }
        return "0 wpm"
    }
    func start() {
        delegate?.gameDidStart()
    }
    
    func finish() {
        delegate?.gameDidFinish()
    }
    
    func updateWPM() {
        delegate?.gameWPMDidUpdate()
    }
    func updateText() {
        delegate?.textDidUpdate()
    }
    
}
