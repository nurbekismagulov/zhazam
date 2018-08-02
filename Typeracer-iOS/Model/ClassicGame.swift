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
    
    var wrongLetters: Int
    
    var timer: Timer
    
    var seconds: Int
    
    var wpm: Int
    
    // MARK: - Classic game properties
    
    weak var delegate: GameDelegate?
    
    var carIcon: String
    var correctText: String
    
    var time = 3
    
    // MARK: - Init
    init() {
        self.text = ""
        self.textArray = []
        self.atWord = 0
        self.correctWords = 0
        self.wrongLetters = 0
        self.timer = Timer()
        self.seconds = 0
        self.correctText = ""
        self.carIcon = ""
        self.wpm = 0
    }
    
    // MARK: - Logic
    
    func calculateWPM() {
        let minute = Double(seconds) / 60.0
        if seconds > 0 {
            wpm = Int(Double(correctWords) / 5 / minute)
            updateWPM()
            print(correctWords)
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
        if textArray[atWord].hasPrefix(typedString) {
            delegate?.textDidUpdateRightLetter()
            wrongLetters = 0
        }
        else if typedString.count - 1 == textArray[atWord].count && typedString.hasSuffix(" ") && typedString.hasPrefix(textArray[atWord]) {
            correctText += typedString
            correctWords += textArray[atWord].count
            atWord += 1
            delegate?.textDidUpdateRightWord()
        }
        else {
            delegate?.textDidUpdateWrongLetter()
            wrongLetters += 1
        }
        print(wrongLetters)
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
