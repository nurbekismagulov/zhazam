//
//  ClassicModeViewController.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 30.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class ClassicModeViewController: UIViewController {
    
    var game = ClassicGame()
    

    // MARK: - properties
    var wrongText = ""
    var movePerWord: CGFloat = 0
    
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
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    lazy var classicTextView: ClassicTextView = {
        let tv = ClassicTextView()
        tv.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        tv.textView.text = game.text
        return tv
    }()
    
    lazy var countDownLabel: UILabel = {
        let timer = UILabel()
        timer.text = "3"
        timer.textColor = .white
        timer.font = .boldSystemFont(ofSize: 50)
        return timer
    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createViews()
        configureConstraints()
        movePerWord = (roadImage.frame.width - carIcon.frame.width) / CGFloat(game.textArray.count)
        game.delegate = self
        game.start()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        game.timer.invalidate()
    }
    func configureView() {
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    func createViews() {
        [carIcon, roadImage, speedLabel, classicTextView, countDownLabel].forEach { view.addSubview($0) }
    }
    
    @objc func textFieldDidChange() {
        game.updateText(with: classicTextView.textField.text!)
    }
    
    func moveVehicle() {
        UIView.animate(withDuration: 0.1) {
            self.carIcon.frame.origin.x = self.carIcon.frame.origin.x + self.movePerWord
        }
    }
    
    func configureConstraints() {
        constrain(carIcon, roadImage, speedLabel, classicTextView, countDownLabel, view) { ci, ri, sl, ctv, cdl, v in
            ri.top == ci.bottom
            ri.left == v.left + (13 / 375 * UIScreen.main.bounds.width)
            ri.height == 3 / 667 * UIScreen.main.bounds.height
            ri.width == 272 / 375 * UIScreen.main.bounds.width
            
            sl.top == v.top + (30 / 667 * UIScreen.main.bounds.height)
            sl.right == v.right - (10 / 375 * UIScreen.main.bounds.width)
            
            ctv.top == ri.bottom + (20 / 667 * UIScreen.main.bounds.height)
            ctv.left == v.left
            ctv.right == v.right
            ctv.height == 274

            cdl.top == ctv.bottom + 100
            cdl.centerX == v.centerX
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
    
    func gameWPMDidUpdate(){
        speedLabel.text = "\(game.wpm) wpm"
    }
    
    func textDidUpdateLetter() {
        classicTextView.paint(with: game.correctLetters, and: game.wrongLetters, with: game.text)
    }
    
    func textDidUpdateRightWord() {
        moveVehicle()
        classicTextView.textField.text = ""
    }
    
    func gameDidFinish() {
        print("Game finished")
    }
    
}
