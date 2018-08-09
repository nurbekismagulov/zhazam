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
    var correctWords = 0
    
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
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(calculateSeconds), userInfo: nil, repeats: true)
        text = Constant.text
        textArray = text.components(separatedBy: " ").shuffled()
    }
    func restart() {
        time = 4
        seconds = 60
        correctWords = 0
        wrongLetters = 0
        atWord = 0
        start()
        delegate?.gameDidRestart()
    }
    func updateWPM() {
        delegate?.gameWPMDidUpdate()
    }
    
    func finish() {
        timer.invalidate()
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
                finish()
            }
            delegate?.gameDidStart()
        }
    }
    func updateText(with typedString: String) {
        if typedString.count <= textArray[atWord].count {
        if textArray[atWord].hasPrefix(typedString){
            wrongLetters = 0
            if typedString == textArray[atWord] {
                if textArray[atWord] == typedString {
                    atWord += 1
                    correctWords += 1
                    delegate?.textDidUpdateRightWord()
                }
            }
        }
        else {
            wrongLetters = textArray[atWord].count
        }
            delegate?.textDidUpdateLetter()
        }
    }
    
}

