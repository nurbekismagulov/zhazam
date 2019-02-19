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
    var correctWords: Int
    
    // MARK: - Classic game properties
    weak var delegate: GameDelegate?
    
    var carIcon: String
    var textBeforeTyping: String
    var time = 3
    var textToHighlight = 0
    
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
        self.correctWords = 0
    }
    
    // MARK: - Logic
    func calculateWPM() {
        let minute = Double(seconds) / 60.0
        if seconds > 0 {
            wpm = Int(Double(correctLetters) / 5 / minute)
            updateWPM()
        }
    }
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(calculateSeconds), userInfo: nil, repeats: true)
        text = Database.database.fetchRealmData().text
        textArray = text.components(separatedBy: " ")
        textToHighlight = textArray[0].count
        delegate?.textDidUpdateLetter()
    }
    
    func restart() {
        time = 4
        seconds = 0
        correctLetters = 0
        wrongLetters = 0
        correctWords = 0
        wpm = 0
        delegate?.textDidUpdateLetter()
        delegate?.textDidUpdateRightWord()
        atWord = 0
        textBeforeTyping = ""
        start()
        delegate?.gameDidRestart()
    }
    
    func finish() {
        delegate?.gameDidFinish()
    }
    
    func updateWPM() {
        delegate?.gameWPMDidUpdate()
    }
    
    func updateText(with typedString: String) {
        if textArray[atWord].hasPrefix(typedString) || (textBeforeTyping == textArray[atWord] && typedString.hasSuffix(" ")){
            wrongLetters = 0
            if typedString == textArray.last! && typedString.count + correctLetters == text.count {
                timer.invalidate()
                correctLetters = text.count
                delegate?.textDidUpdateLetter()
                delegate?.gameDidFinish()
            }
            else if textBeforeTyping == textArray[atWord] && typedString.hasSuffix(" ") {
                correctLetters += typedString.count
                atWord += 1
                if textArray[atWord] != textArray.last! {
                    textToHighlight = textArray[atWord].count
                }
                else {
                    textToHighlight = 0
                }
                delegate?.textDidUpdateRightWord()
            }
            delegate?.textDidUpdateLetter()
        }
        else {
            wrongLetters = textArray[atWord].count
            delegate?.textDidUpdateLetter()
        }
        textBeforeTyping = typedString
    }
    
    @objc func calculateSeconds() {
        if time > 0 {
            time -= 1
            delegate?.timerDidUpdate(with: time)
        } else{
            seconds += 1
            calculateWPM()
            delegate?.gameDidStart()
        }
    }
}
