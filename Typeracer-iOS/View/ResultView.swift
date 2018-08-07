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
        label.font = .setCabinSketch(ofSize: 45)
        label.text = "YOUR RESULT"
        return label
    }()
    
    lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .setCabinSketch(ofSize: 50)
        return label
    }()
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 35
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        return button
    }()
    
    lazy var homeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 50
        button.setImage(#imageLiteral(resourceName: "home"), for: .normal)
        return button
    }()
    
    lazy var replayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 35
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
            
            rl.top == v.top + 150
            rl.centerX == v.centerX
            
            sl.top == rl.bottom + 65
            sl.centerX == v.centerX
            
            hb.bottom == v.bottom - 80
            hb.left == v.left + 50
            hb.height == 70
            hb.width == 70
            
            sb.bottom == v.bottom - 65
            sb.left == hb.right + 18
            sb.height == 100
            sb.width == 100
            
            rb.bottom == v.bottom - 80
            rb.right == v.right - 50
            rb.height == 70
            rb.width == 70
        }
    }
    
}
