//
//  ClassicModeViewController.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 30.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography
import RealmSwift
import AudioToolbox

class ClassicModeViewController: UIViewController {
    
    var game = ClassicGame()
    

    // MARK: - properties
    var wrongText = ""
    var movePerWord: CGFloat = 0
    var realm: Realm!
    
    // MARK: - Views
    lazy var carIcon: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 15 / 667 * UIScreen.main.bounds.height, y: 22 / 375 * UIScreen.main.bounds.width, width: 60 / 375 * UIScreen.main.bounds.width, height: 20 / 667 * UIScreen.main.bounds.height))
        image.image = UIImage(named: game.carIcon)
        return image
    }()
    
    lazy var roadImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "road"))
        return image
    }()
    lazy var speedLabel: UILabel = {
        let label = UILabel()
        label.text = "0 wpm"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: Constant.multiplyToWidth(number: 18))
        return label
    }()

    lazy var classicTextView: ClassicTextView = {
        let tv = ClassicTextView()
        tv.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        tv.eraseButton.addTarget(self, action: #selector(eraseButtonPressed), for: .touchUpInside)
        tv.textView.text = game.text
        return tv
    }()
    
    lazy var countDownLabel: UILabel = {
        let timer = UILabel()
        timer.text = "3"
        timer.textColor = .white
        timer.font = .boldSystemFont(ofSize: Constant.multiplyToWidth(number: 50))
        return timer
    }()
    
    lazy var resultView: ResultView = {
        let view = ResultView()
        view.homeButton.addTarget(self, action: #selector(homeButtonPressed), for: .touchUpInside)
        view.replayButton.addTarget(self, action: #selector(replayButtonPressed), for: .touchUpInside)
        view.shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        view.alpha = 0
        return view
    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createViews()
        configureConstraints()
        game.delegate = self
        game.start()
        realm = try? Realm()
        movePerWord = (roadImage.frame.width - carIcon.frame.width) / CGFloat(game.textArray.count)
    }
    override func viewWillDisappear(_ animated: Bool) {
        game.timer.invalidate()
        Music.share.backgroundMusicPlayer.volume = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Music.share.backgroundMusicPlayer.volume = 0
    }
    
    func configureView() {
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    func createViews() {
        [carIcon, roadImage, speedLabel, classicTextView, countDownLabel, resultView].forEach { view.addSubview($0) }
    }
    
    @objc func textFieldDidChange() {
        game.updateText(with: classicTextView.textField.text!)
    }
    @objc func eraseButtonPressed() {
        classicTextView.textField.text = ""
        game.updateText(with: classicTextView.textField.text!)
    }
    func moveVehicle() {
        UIView.animate(withDuration: 0.1) {
            self.carIcon.frame.origin.x = self.carIcon.frame.origin.x + self.movePerWord
        }
    }
    
    @objc func homeButtonPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func replayButtonPressed() {
        game.restart()
    }
    
    @objc func shareButtonPressed(){
        ShareManager.share.instagramShare(at: self, image: ShareManager.share.takeScreenshot()!)
    }
    
    func configureConstraints() {
        constrain(carIcon, roadImage, speedLabel, classicTextView, countDownLabel, view) { ci, ri, sl, ctv, cdl, v in
            ri.top == ci.bottom
            ri.left == v.left + (13 / 375 * UIScreen.main.bounds.width)
            ri.height == 3 / 667 * UIScreen.main.bounds.height
            ri.width == 272 / 375 * UIScreen.main.bounds.width
            
            sl.top == v.top + (30 / 667 * UIScreen.main.bounds.height)
            sl.right == v.right - (10 / 375 * UIScreen.main.bounds.width)
          
            ctv.left == v.left
            ctv.right == v.right
            ctv.height == Constant.multiplyToHeight(number: 274)

            cdl.centerX == v.centerX
            
            if UIScreen.main.bounds.height == 812 {
                cdl.top == ctv.bottom + 150
                ctv.top == ri.bottom + 30
            } else {
                cdl.top == ctv.bottom + Constant.multiplyToHeight(number: 100)
                ctv.top == ri.bottom + Constant.multiplyToHeight(number: 20)
            }
        }
        constrain(resultView, view) { rv, v in
            rv.edges == v.edges
        }
    }
}

extension ClassicModeViewController: GameDelegate {
    
    func timerDidUpdate(with time: Int) {
        if time >= 0 {
            countDownLabel.text = String(time)
            if time == 0{
                classicTextView.textField.isUserInteractionEnabled = true
                classicTextView.textField.becomeFirstResponder()
            }
        }
    }
    func gameDidStart() {
        print("game Started")
    }
    func gameDidRestart() {
        print("Game RESTARTED")
        carIcon.frame = CGRect(x: 15 / 667 * UIScreen.main.bounds.height, y: 22 / 375 * UIScreen.main.bounds.width, width: 60 / 375 * UIScreen.main.bounds.width, height: 20 / 667 * UIScreen.main.bounds.height)
        speedLabel.text = "\(game.wpm) wpm"
        classicTextView.textField.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5) {
            self.resultView.alpha = 0
        }
        movePerWord = (roadImage.frame.width - carIcon.frame.width) / CGFloat(game.textArray.count)
    }
    func gameWPMDidUpdate(){
        speedLabel.text = "\(game.wpm) wpm"
    }
    
    func textDidUpdateLetter() {
        classicTextView.paint(with: game.correctLetters, and: game.wrongLetters, with: game.text, at: game.textToHighlight)
    }
    
    func textDidUpdateRightWord() {
        moveVehicle()
        classicTextView.textField.text = ""
    }
    
    func gameDidFinish() {
        print("Game finished")
        resultView.scoreLabel.text = speedLabel.text
        classicTextView.textField.isUserInteractionEnabled = false
        store()
        UIView.animate(withDuration: 0.5) {
            self.resultView.alpha = 1
        }
    }
    
    func store(){
        let item = ClassicResult()
        item.result = game.wpm
        try? self.realm.write {
            self.realm.add(item)
        }
    }
    
}
