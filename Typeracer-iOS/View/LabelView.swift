//
//  LabelView.swift
//  Typeracer-iOS
//
//  Created by Adlet on 03.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit

class LabelView: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        let randomSize = Int(arc4random_uniform(UInt32(15)) + 30)
        self.frame.size = CGSize(width: 150, height: 150)
        self.font = UIFont.systemFont(ofSize: CGFloat(randomSize))
        self.backgroundColor = .clear
        self.text = "Azhar"
        self.textColor = .random()
        self.alpha = CGFloat.random(min: 0.4, max: 0.8)
    }

}
