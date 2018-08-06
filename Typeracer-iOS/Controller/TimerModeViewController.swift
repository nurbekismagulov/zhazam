//
//  TimerModeViewController.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 03.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class TimerModeViewController: UIViewController, Reusable, UICollectionViewDelegateFlowLayout {
    
    var game = TimerGame()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0:58"
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
    
    lazy var erasableTextField: ErasableTextField = {
        let tf = ErasableTextField()
        tf.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return tf
    }()
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 450, width: 200, height: 60))
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(testButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createViews()
        configureConstraints()
        game.delegate = self
        game.start()
    }
    
    @objc func textFieldDidChange() {
        game.updateText(with: erasableTextField.textField.text!)
    }
    
    func configureView() {
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func createViews() {
        [timeLabel, tableView, erasableTextField, countDownLabel, button].forEach { view.addSubview($0) }
    }
    func configureConstraints() {
        constrain(timeLabel, tableView, erasableTextField, countDownLabel, view) { tl, tv, et, cdl, v in
            tl.top == v.top + 20
            tl.centerX == v.centerX
            
            tv.top == tl.bottom + 15
            tv.left == v.left
            tv.right == v.right
            tv.height == 135
            
            et.top == tv.bottom + 65
            et.left == v.left
            et.right == v.right
            
            cdl.top == et.bottom + 100
            cdl.centerX == v.centerX
        }
    }
    
    @objc func testButtonPressed() {
        UIView.animate(withDuration: 0.5) {
            let cell = self.tableView.cellForRow(at: IndexPath(row: self.game.atWord, section: 0)) as! TimerModeTableViewCell
            self.tableView.scrollToRow(at: IndexPath(row: self.game.atWord, section: 0), at: .top, animated: true)
            cell.label.font = UIFont.systemFont(ofSize: 40)
            cell.label.alpha = 1
            let cell2 = self.tableView.cellForRow(at: IndexPath(row: self.game.atWord+1, section: 0)) as! TimerModeTableViewCell
            cell2.label.font = UIFont.systemFont(ofSize: 30)
            cell2.label.alpha = 0.7
            let cell3 = self.tableView.cellForRow(at: IndexPath(row: self.game.atWord+2, section: 0)) as! TimerModeTableViewCell
            cell3.label.font = UIFont.systemFont(ofSize: 25)
            cell3.label.alpha = 0.5
            self.game.atWord += 1
        }
    }
    func paint(with numberOfCorrectLetters: Int, and numberOfWrongLetters: Int, with text: String) {
        let correctLettersRange = NSRange(location: 0, length: numberOfCorrectLetters)
        let wrongLettersRange = NSRange(location: numberOfCorrectLetters, length: numberOfWrongLetters)
        let attribute = NSMutableAttributedString.init(string: text)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: wrongLettersRange)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.deepSkyBlue , range: correctLettersRange)
//        let rangeOfText = NSRange(location: 0, length: text.count)
//        attribute.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 17), range: rangeOfText)
//        erasableTextField.textField.attributedText = attribute
        let cell = tableView.cellForRow(at: IndexPath(row: game.atWord, section: 0)) as! TimerModeTableViewCell
        cell.label.attributedText = attribute
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
        }
        else if indexPath.row == game.atWord + 1 {
            cell.label.font = UIFont.systemFont(ofSize: 30)
            cell.label.alpha = 0.7
        }
        else if indexPath.row == game.atWord + 2 {
            cell.label.font = UIFont.systemFont(ofSize: 25)
            cell.label.alpha = 0.5
        }
        cell.label.text = game.textArray[indexPath.row]
        return cell
    }
}

extension TimerModeViewController: GameDelegate {
    
    func gameDidStart() {
//        print("Game Started")
        timeLabel.text = String(game.seconds)
        erasableTextField.textField.isUserInteractionEnabled = true
        erasableTextField.textField.becomeFirstResponder()
    }
    
    func gameWPMDidUpdate() {
        
    }
    
    func textDidUpdateLetter() {
       // paint(with: game.correctLetters, and: game.wrongLetters, with: game.textArray[game.atWord])
        print(game.textArray[game.atWord])
//        print(erasableTextField.textField.text )
        paint(with: game.correctLetters, and: game.wrongLetters, with: game.textArray[game.atWord])
    }
    
    func textDidUpdateRightWord() {
        erasableTextField.textField.text = ""
        //game.textArray.remove(at: 0)
        //collectionView.reloadData()
        UIView.animate(withDuration: 0.5) {
            let cell = self.tableView.cellForRow(at: IndexPath(row: self.game.atWord, section: 0)) as! TimerModeTableViewCell
            self.tableView.scrollToRow(at: IndexPath(row: self.game.atWord, section: 0), at: .top, animated: true)
            cell.label.font = UIFont.systemFont(ofSize: 40)
            cell.label.alpha = 1
            let cell2 = self.tableView.cellForRow(at: IndexPath(row: self.game.atWord+1, section: 0)) as! TimerModeTableViewCell
            cell2.label.font = UIFont.systemFont(ofSize: 30)
            cell2.label.alpha = 0.7
            let cell3 = self.tableView.cellForRow(at: IndexPath(row: self.game.atWord+2, section: 0)) as! TimerModeTableViewCell
            cell3.label.font = UIFont.systemFont(ofSize: 25)
            cell3.label.alpha = 0.5
//            self.game.atWord += 1
        }
    }
    
    func gameDidFinish() {
        print("Game Finished")
    }
    
    func timerDidUpdate(with time: Int) {
        countDownLabel.text = String(time)
    }
}
