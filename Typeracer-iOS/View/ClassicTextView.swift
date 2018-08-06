//
//  ClassicTextView.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 02.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class ClassicTextView: UIView {
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 12
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.darkGray.cgColor
        tv.font = .systemFont(ofSize: 17)
        tv.isEditable = false
        return tv
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
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isUserInteractionEnabled = false
        return tf
    }()
    lazy var eraseImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "erase"))
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        createViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {
        [textView, textField, eraseImage].forEach { self.addSubview($0) }
    }
    func configureConstraints() {
        constrain(textView, textField, eraseImage, self) { tv, tf, ei, v in
            
            tv.top == v.top
            tv.centerX == v.centerX
            tv.height == 216 / 667 * UIScreen.main.bounds.height
            tv.width == 352 / 375 * UIScreen.main.bounds.width
            
            tf.top == tv.bottom + (24 / 667 * UIScreen.main.bounds.height)
            tf.left == v.left + (13 / 375 * UIScreen.main.bounds.width)
            tf.height == 34 / 667 * UIScreen.main.bounds.height
            tf.width == 300 / 375 * UIScreen.main.bounds.width
            
            ei.top == tv.bottom + (24 / 667 * UIScreen.main.bounds.height)
            ei.left == tf.right + (10 / 375 * UIScreen.main.bounds.width)
            ei.height == 33 / 667 * UIScreen.main.bounds.height
            ei.width == 33 / 375 * UIScreen.main.bounds.width
        }
    }
    
    func paint(with numberOfCorrectLetters: Int, and numberOfWrongLetters: Int, with text: String) {
        let correctLettersRange = NSRange(location: 0, length: numberOfCorrectLetters)
        if numberOfWrongLetters > 0 {
            textField.backgroundColor = .candyAppleRed
            textField.textColor = .white
        }
        else {
            textField.backgroundColor = .white
            textField.textColor = .deepSkyBlue
        }
        let wrongLettersRange = NSRange(location: numberOfCorrectLetters, length: numberOfWrongLetters)
        let attribute = NSMutableAttributedString.init(string: text)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: wrongLettersRange)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.deepSkyBlue , range: correctLettersRange)
        let rangeOfText = NSRange(location: 0, length: text.count)
        attribute.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 17), range: rangeOfText)
        textView.attributedText = attribute
    }
    
}
