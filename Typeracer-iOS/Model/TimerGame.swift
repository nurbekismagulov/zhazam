//
//  TimerGame.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 06.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation

class TimerGame: Game {
    
    var text: String
    
    var textArray: [String]
    
    var atWord: Int
    
    var correctLetters: Int
    
    var wrongLetters: Int
    
    var timer: Timer
    
    var seconds: Int
    
    var wpm: Int
    
    var time = 3
    
    weak var delegate: GameDelegate?
    
    var textBeforeTyping: String
    
    init() {
        self.text = ""
        self.textArray = []
        self.atWord = 0
        self.correctLetters = 0
        self.wrongLetters = 0
        self.timer = Timer()
        self.seconds = 60
        self.wpm = 0
        self.textBeforeTyping = ""
    }
    
    func calculateWPM() {
        wpm = Int(Double(correctLetters) / 5 / 60)
        updateWPM()
        print(correctLetters)
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(calculateSeconds), userInfo: nil, repeats: true)
    }
    
    func updateWPM() {
        delegate?.gameWPMDidUpdate()
    }
    
    func finish() {
        delegate?.gameDidFinish()
    }
    
    @objc func calculateSeconds() {
        if time > 0 {
            time -= 1
            delegate?.timerDidUpdate(with: time)
        }
            
        else{
            seconds -= 1
            if seconds == 0 {
                calculateWPM()
                timer.invalidate()
                delegate?.gameDidFinish()
            }
            delegate?.gameDidStart()
        }
    }
    func updateText(with typedString: String) {
        
//        if typedString == textArray[atWord] {
//            atWord = 0
//            correctLetters = 0
//            textBeforeTyping = ""
//            delegate?.textDidUpdateRightWord()
//        }
//        else if textArray[atWord].hasPrefix(typedString) {
//            if textBeforeTyping.count > typedString.count {
//                if textArray[atWord].hasPrefix(textBeforeTyping) {
//                    correctLetters -= 1
//                }
//                else {
//                    wrongLetters -= 1
//                }
//            }
//            else if typedString.count > textBeforeTyping.count{
//                correctLetters += 1
//            }
//            delegate?.textDidUpdateLetter()
//        }
//        else if !textArray[atWord].hasPrefix(typedString) {
//            wrongLetters += 1
//            delegate?.textDidUpdateLetter()
//        }
//        textBeforeTyping = typedString
        if typedString == textArray[atWord] {
            delegate?.textDidUpdateRightWord()
            correctLetters = 0
            wrongLetters = 0
            atWord += 1
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
        textBeforeTyping = typedString
        delegate?.textDidUpdateLetter()
    }
    
}
