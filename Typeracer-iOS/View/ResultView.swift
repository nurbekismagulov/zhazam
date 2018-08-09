//
//  ResultView.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 05.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class ResultView: UIView {

    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .catalinaBlue
        view.alpha = 0.87
        return view
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .setCabinSketch(ofSize: Constant.multiplyToWidth(number: 45))
        label.text = "YOUR RESULT"
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .setCabinSketch(ofSize: Constant.multiplyToWidth(number: 50))
        return label
    }()
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = Constant.multiplyToHeight(number: 35)
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        return button
    }()
    
    lazy var homeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = Constant.multiplyToHeight(number: 50)
        button.setImage(#imageLiteral(resourceName: "home"), for: .normal)
        return button
    }()
    
    lazy var replayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = Constant.multiplyToHeight(number: 35)
        button.setImage(#imageLiteral(resourceName: "replay"), for: .normal)
        return button
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
    
    func createViews(){
        [backgroundView, resultLabel, scoreLabel, shareButton, homeButton, replayButton].forEach { self.addSubview($0) }
    }
    func configureConstraints() {
        constrain(backgroundView, resultLabel, scoreLabel, shareButton, homeButton, replayButton, self) { bv, rl, sl, hb, sb, rb, v in
            bv.edges == v.edges
            
            rl.top == v.top + Constant.multiplyToHeight(number: 150)
            rl.centerX == v.centerX
            
            sl.top == rl.bottom + Constant.multiplyToHeight(number: 65)
            sl.centerX == v.centerX
            
            hb.left == v.left + Constant.multiplyToWidth(number: 50)
            hb.height == Constant.multiplyToHeight(number: 70)
            hb.width == Constant.multiplyToWidth(number: 70)
            
            sb.left == hb.right + Constant.multiplyToWidth(number: 18)
            sb.height == Constant.multiplyToHeight(number: 100)
            sb.width == Constant.multiplyToWidth(number: 100)
            
            rb.right == v.right - Constant.multiplyToWidth(number: 50)
            rb.height == Constant.multiplyToHeight(number: 70)
            rb.width == Constant.multiplyToWidth(number: 70)
            
            if UIScreen.main.bounds.height == 812 {
                hb.bottom == v.bottom - 140
                sb.bottom == v.bottom - 120
                rb.bottom == v.bottom - 140
            } else {
                hb.bottom == v.bottom - Constant.multiplyToHeight(number: 80)
                sb.bottom == v.bottom - Constant.multiplyToHeight(number: 65)
                rb.bottom == v.bottom - Constant.multiplyToHeight(number: 80)
            }
        }
    }
    
}
