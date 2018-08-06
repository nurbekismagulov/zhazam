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
        if correctLetters == text.count {
            timer.invalidate()
            delegate?.gameDidFinish()
        }
        if typedString.hasSuffix(" ") && textBeforeTyping == textArray[atWord] { //space
            atWord += 1
            correctLetters += 1
            delegate?.textDidUpdateRightWord()
            textBeforeTyping = ""
        }
        else if textArray[atWord].hasPrefix(typedString){ //right letter
            wrongLetters = 0
            if textBeforeTyping.count > typedString.count { //backspace
                if textArray[atWord].hasPrefix(textBeforeTyping) {
                    correctLetters -= 1
                }
                else {
                    wrongLetters = 0
                }
            }
            else {
                
                correctLetters += 1 // typ_
            }
            delegate?.textDidUpdateLetter()
        }
        else if !textArray[atWord].hasPrefix(typedString){
            if textBeforeTyping.count > typedString.count {
                wrongLetters -= 1
            }
            else{
                wrongLetters += 1
            }
            delegate?.textDidUpdateLetter()
        }
        if !typedString.hasSuffix(" ") && textBeforeTyping != textArray[atWord] {
            textBeforeTyping = typedString
        }
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
