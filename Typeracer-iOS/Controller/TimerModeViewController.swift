//
//  TimerModeViewController.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 03.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography
import RealmSwift

class TimerModeViewController: UIViewController, Reusable, UICollectionViewDelegateFlowLayout {
    
    var game = TimerGame()
    var realm: Realm!
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "1:00"
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        return layout
    }()
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.isUserInteractionEnabled = false
        tv.separatorStyle = .none
        tv.register(TimerModeTableViewCell.self, forCellReuseIdentifier: identifier)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    lazy var countDownLabel: UILabel = {
        let timer = UILabel()
        timer.text = "3"
        timer.textColor = .white
        timer.font = .boldSystemFont(ofSize: 50)
        return timer
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 6
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.font = .systemFont(ofSize: 17)
        tf.setLeftPaddingPoints(10)
        tf.setRightPaddingPoints(10)
        //        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isUserInteractionEnabled = false
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return tf
    }()
    
    lazy var eraseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "erase"), for: .normal)
        button.addTarget(self, action: #selector(eraseButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var resultView: ResultView = {
        let view = ResultView()
        view.homeButton.addTarget(self, action: #selector(homeButtonPressed), for: .touchUpInside)
        view.replayButton.addTarget(self, action: #selector(replayButtonPressed), for: .touchUpInside)
        view.shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        view.alpha = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createViews()
        configureConstraints()
        game.delegate = self
        game.start()
        realm = try? Realm()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        game.timer.invalidate()
    }
    
    @objc func textFieldDidChange() {
        game.updateText(with: textField.text!)
        
    }
    @objc func eraseButtonPressed() {
        textField.text = ""
        game.updateText(with: textField.text!)
    }
    
    @objc func shareButtonPressed(){
        ShareManager.share.instagramShare(at: self, image: ShareManager.share.takeScreenshot()!)
    }
    
    func configureView() {
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func createViews() {
        [timeLabel, tableView, textField, eraseButton, countDownLabel, resultView].forEach { view.addSubview($0) }
    }
    func configureConstraints() {
        constrain(timeLabel, tableView, textField, eraseButton, countDownLabel, view) { tl, tv, et, eb, cdl, v in
            tl.top == v.top + 20
            tl.centerX == v.centerX
            
            tv.top == tl.bottom + 15
            tv.left == v.left
            tv.right == v.right
            tv.height == 135
            
            et.top == tv.bottom + 65
            et.height == 34
            et.left == v.left + 13
            et.width == 300
            
            eb.top == tv.bottom + 65
            eb.left == et.right + 10
            eb.height == 33
            eb.width == 33
            
            cdl.top == et.bottom + 100
            cdl.centerX == v.centerX
        }
        constrain(resultView, view) { rv, v in
            rv.edges == v.edges
        }
    }
    
    func paint(with numberOfCorrectLetters: Int, and numberOfWrongLetters: Int, with text: String) {
        let correctLettersRange = NSRange(location: 0, length: numberOfCorrectLetters)
        let wrongLettersRange = NSRange(location: numberOfCorrectLetters, length: numberOfWrongLetters)
        let attribute = NSMutableAttributedString.init(string: text)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.candyAppleRed , range: wrongLettersRange)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.deepSkyBlue , range: correctLettersRange)
        let cell = tableView.cellForRow(at: IndexPath(row: game.atWord, section: 0)) as! TimerModeTableViewCell
        cell.label.attributedText = attribute
    }
    @objc func homeButtonPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func replayButtonPressed() {
        game.restart()
    }
    
}

extension TimerModeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TimerModeTableViewCell
        if indexPath.row == game.atWord {
            cell.label.font = UIFont.systemFont(ofSize: 40)
            cell.label.textColor = .deepSkyBlue
        }
        else if indexPath.row == game.atWord + 1 {
            cell.label.font = UIFont.systemFont(ofSize: 30)
            cell.label.textColor = .white
            cell.label.alpha = 0.85
        }
        else if indexPath.row == game.atWord + 2 {
            cell.label.font = UIFont.systemFont(ofSize: 25)
            cell.label.textColor = .white
            cell.label.alpha = 0.65
        }
        cell.label.text = game.textArray[indexPath.row]
        return cell
    }
}

extension TimerModeViewController: GameDelegate {
    
    func gameDidStart() {
//        print("Game Started")
        let minutes = Int(game.seconds) / 60 % 60
        let seconds = Int(game.seconds) % 60
        let time = String(format:"%2i:%02i", minutes, seconds)
        timeLabel.text = time
        textField.isUserInteractionEnabled = true
        textField.becomeFirstResponder()
    }
    
    func gameDidRestart() {
        timeLabel.text = "1:00"
        UIView.animate(withDuration: 0.5) {
            self.resultView.alpha = 0
            self.textField.isEnabled = true
        }
        textField.text = ""
        tableView.reloadData()
        self.tableView.scrollToRow(at: IndexPath(row: self.game.atWord, section: 0), at: .top, animated: true)
    }
    
    func gameWPMDidUpdate() {
        
    }
    
    func textDidUpdateLetter() {
        print(game.textArray[game.atWord])
        paint(with: game.correctLetters, and: game.wrongLetters, with: game.textArray[game.atWord])
    }
    
    func textDidUpdateRightWord() {
        textField.text = ""
        UIView.animate(withDuration: 0.5) {
            self.tableView.scrollToRow(at: IndexPath(row: self.game.atWord, section: 0), at: .top, animated: true)
            let cell = self.tableView.cellForRow(at: IndexPath(row: self.game.atWord, section: 0)) as! TimerModeTableViewCell
            cell.label.font = UIFont.systemFont(ofSize: 40)
            cell.label.textColor = .deepSkyBlue
            cell.label.alpha = 1
            let cell2 = self.tableView.cellForRow(at: IndexPath(row: self.game.atWord + 1, section: 0)) as! TimerModeTableViewCell
            cell2.label.font = UIFont.systemFont(ofSize: 30)
            cell2.label.textColor = .white
            cell2.label.alpha = 0.85
            let cell3 = self.tableView.cellForRow(at: IndexPath(row: self.game.atWord + 2, section: 0)) as! TimerModeTableViewCell
            cell3.label.font = UIFont.systemFont(ofSize: 25)
            cell3.label.textColor = .white
            cell3.label.alpha = 0.65
        }
    }
    
    func gameDidFinish() {
        print("Game Finished")
        resultView.scoreLabel.text = "\(game.correctWords) words"
        textField.isUserInteractionEnabled = false
        textField.isEnabled = false
        store()
        UIView.animate(withDuration: 0.5) {
            self.resultView.alpha = 1
        }
    }
    
    func timerDidUpdate(with time: Int) {
        countDownLabel.text = String(time)
    }
    
    func store(){
        let item = TimerResult()
        item.result = game.correctWords
        try? self.realm.write {
            self.realm.add(item)
        }
        
    }
}
