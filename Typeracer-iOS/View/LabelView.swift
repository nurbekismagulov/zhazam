//
//  LabelView.swift
//  Typeracer-iOS
//
//  Created by Adlet on 03.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit

class RandomLabelView: UILabel {
    
    var texts: [Text] = []
    var array: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fetch()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        let randomSize = Int(arc4random_uniform(UInt32(15)) + 30)
        self.frame.size = CGSize(width: Constant.multiplyToHeight(number: 250), height: Constant.multiplyToHeight(number: 150))
        self.font = UIFont.setCabinSketch(ofSize: CGFloat(randomSize))
        self.backgroundColor = .clear
        array = texts[0].text.components(separatedBy: .whitespacesAndNewlines)
        let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        self.text = array[randomIndex].capitalized
        self.textColor = .random()
        self.alpha = CGFloat.random(min: 0.4, max: 0.8)
    }
    
    func fetch(){
        let text = Database.database.fetchRealmData()
        texts.append(text)
    }
}
