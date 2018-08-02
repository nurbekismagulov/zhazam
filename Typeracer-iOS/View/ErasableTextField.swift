//
//  ErasableTextField.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 03.08.2018.
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
    
    lazy var eraseImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "erase"))
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        createViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.backgroundColor = .clear
    }
    func createViews() {
        self.addSubview(textField)
        self.addSubview(eraseImage)
    }
    func configureConstraints() {
        constrain(textField, eraseImage, self){ tf, ei, v in
            tf.top == v.top
            tf.left == v.left + 13
            tf.height == 34
            tf.width == 300
            
            ei.top == v.top
            ei.left == tf.right + 10
            ei.height == 33
            ei.width == 33
        }
    }
    
}
