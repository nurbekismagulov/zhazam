//
//  ErasableTextField.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 08.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class ErasableTextField: UIView {
    
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
    lazy var eraseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "erase"), for: .normal)
        button.addTarget(self, action: #selector(eraseButtonPressed), for: .touchUpInside)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(textField)
        self.addSubview(eraseButton)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func eraseButtonPressed() {
        textField.text = ""
    }
    func setupConstraints() {
        constrain(textField, eraseButton, self) { tf, eb, v in
            tf.top == v.top
            tf.left == v.left
            tf.bottom == v.bottom
            tf.width == 300
            
            eb.top == v.top
            eb.bottom == v.bottom
            eb.left == tf.right + 10
            eb.right == v.right
            
        }
    }

}
