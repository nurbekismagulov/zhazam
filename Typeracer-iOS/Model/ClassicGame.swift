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
    
    var correctLetters: Int
    
    var wrongLetters: Int
    
    var timer: Timer
    
    var seconds: Int
    
    var wpm: Int
    
    // MARK: - Classic game properties
    
    weak var delegate: GameDelegate?
    
    var carIcon: String
    var textBeforeTyping: String
    var time = 3
    
    // MARK: - Init
    init() {
        self.text = ""
        self.textArray = []
        self.atWord = 0
        self.correctLetters = 0
        self.wrongLetters = 0
        self.timer = Timer()
        self.seconds = 0
        self.carIcon = ""
        self.textBeforeTyping = ""
        self.wpm = 0
    }
    
    // MARK: - Logic
    
    func calculateWPM() {
        let minute = Double(seconds) / 60.0
        if seconds > 0 {
            wpm = Int(Double(correctLetters) / 5 / minute)
            updateWPM()
            print(correctLetters)
            print(minute)
        }
    }
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(calculateSeconds), userInfo: nil, repeats: true)
    }
    
    func finish() {
        delegate?.gameDidFinish()
    }
    
    func updateWPM() {
        delegate?.gameWPMDidUpdate()
    }
    func updateText(with typedString: String) {
        if textArray[atWord].hasPrefix(typedString) && textBeforeTyping.count < typedString.count{
            correctLetters += 1
            wrongLetters = 0
            delegate?.textDidUpdateLetter()
        }
        else if typedString.hasSuffix(" ") && textBeforeTyping == textArray[atWord]{
            atWord += 1
            correctLetters += 2
            wrongLetters = 0
            delegate?.textDidUpdateRightWord()
        }
        else if textBeforeTyping.count > typedString.count && !textBeforeTyping.hasSuffix(" "){
            if textArray[atWord].hasPrefix(textBeforeTyping) {
                correctLetters -= 1
            }
            else {
                wrongLetters -= 1
            }
            delegate?.textDidUpdateLetter()
        }
        else {
            wrongLetters += 1
            delegate?.textDidUpdateLetter()
        }
        textBeforeTyping = typedString
    }
    
    @objc func calculateSeconds() {
        if time > 0 {
            time -= 1
            delegate?.timerDidUpdate(with: time)
        }
            
        else{
            seconds += 1
            calculateWPM()
            delegate?.gameDidStart()
        }
    }
    
}
