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

    // MARK: - properties
    var text = String()
    var textArray: [String] = []
    var icon = String()
    
    // MARK: - Views
    lazy var carIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: icon))
        return image
    }()
    
    lazy var roadImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "road"))
        return image
    }()
    lazy var speedLabel: UILabel = {
        let label = UILabel()
        label.text = "26 wpm"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 12
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.darkGray.cgColor
        tv.font = .systemFont(ofSize: 17)
        let string_to_color = "messag"
        let range = (text as NSString).range(of: string_to_color)
        let attribute = NSMutableAttributedString.init(string: text)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red , range: range)
        tv.isEditable = false
        tv.attributedText = attribute
        //tv.text = text
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
        return tf
    }()
    lazy var eraseImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "erase"))
        return image
    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createViews()
        configureConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    func createViews() {
        [carIcon, roadImage, speedLabel, textView, textField, eraseImage].forEach { view.addSubview($0) }
    }
    
    func configureConstraints() {
        constrain(carIcon, roadImage, speedLabel, textView, textField, eraseImage, view) { ci, ri, sl, tv, tf, ei, v in
            ci.top == v.top + 22
            ci.left == v.left + 15
            ci.width == 60
            ci.height == 20
            
            ri.top == ci.bottom
            ri.left == v.left + 13
            ri.height == 3
            ri.width == 272
            
            sl.top == v.top + 30
            sl.right == v.right - 10
            
            tv.top == ri.bottom + 20
            tv.centerX == v.centerX
            tv.height == 216
            tv.width == 352
            
            tf.top == tv.bottom + 24
            tf.left == v.left + 13
            tf.height == 34
            tf.width == 300
            
            ei.top == tv.bottom + 24
            ei.left == tf.right + 10
            ei.height == 33
            ei.width == 33
        }
    }
}
