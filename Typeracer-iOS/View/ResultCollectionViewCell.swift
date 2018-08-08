//
//  ResultCollectionViewCell.swift
//  Typeracer-iOS
//
//  Created by Adlet on 08.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class ResultCollectionViewCell: UICollectionViewCell {
    
    //MARK: UI init
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "500"
        label.textColor = "#16aafc".hexColor
        label.setStyle()
        label.font = .systemFont(ofSize: 20)
        label.layer.borderColor = "#16aafc".hexColor.cgColor
        return label
    }()
    
    lazy var classicLabel: UILabel = {
        let label = UILabel()
        label.text = "500"
        label.textColor = .red
        label.font = .systemFont(ofSize: 20)
        label.setStyle()
        label.layer.borderColor = UIColor.red.cgColor
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        return label
    }()
 
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Set views
    func configureViews(){
        [timerLabel, classicLabel, titleLabel].forEach({contentView.addSubview($0)})
    }
    
    func configureConstraints(){
        constrain(timerLabel, classicLabel, titleLabel, contentView){f, s, t, cv in
            f.top == cv.top + 10
            f.left == cv.left + 2
            f.height == 120
            f.width == 120
            
            s.top == cv.top + 10
            s.right == cv.right - 2
            s.height == 120
            s.width == 120
            
            t.top == s.bottom + 20
            t.centerX == cv.centerX
            t.height == 100

        }
    }
    
    
    
}
