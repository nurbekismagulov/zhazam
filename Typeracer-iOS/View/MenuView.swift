//
//  MenuView.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 23.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class MenuView: UIView {
    
    //MARK: - Views
    lazy var soundButton: UIButton = {
        let button = UIButton()
        button.addSubview(soundImageView)
        return button
    }()
    lazy var soundImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "soundOff"))
        return image
    }()
    
    lazy var graphButton: UIButton = {
        let button = UIButton()
        button.addSubview(graphImageView)
        return button
    }()
    lazy var graphImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "graph"))
        return image
    }()
    
    lazy var profileButton: UIButton = {
        let button = UIButton()
        button.addSubview(profileImageView)
        return button
    }()
    
    lazy var profileImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "profile"))
        return image
    }()
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.addSubview(settingsImageView)
        return button
    }()
    lazy var settingsImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "settings"))
        return image
    }()
    
    lazy var firstLine: UIView = {
        let v = UIView()
        v.backgroundColor = .silverGray
        return v
    }()
    
    lazy var secondLine: UIView = {
        let v = UIView()
        v.backgroundColor = .silverGray
        return v
    }()
    
    lazy var thirdLine: UIView = {
        let v = UIView()
        v.backgroundColor = .silverGray
        return v
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        createViews()
        setupConstraints()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Creating Views
    func configureView(){
        self.backgroundColor = .white
        self.layer.cornerRadius = Constant.multiplyToHeight(number: 8)
    }
    
    func createViews(){
        [soundButton, graphButton, profileButton, settingsButton, firstLine, secondLine, thirdLine].forEach { self.addSubview($0) }
    }
    //MARK: - Layouts
    func setupConstraints(){
        constrain(soundImageView, soundButton, graphImageView, graphButton, profileImageView, profileButton, settingsImageView, settingsButton){ si, sb, gi, gb, pi, pb, seti, setb in
            si.center == sb.center
            si.width == Constant.multiplyToWidth(number: 24)
            si.height == Constant.multiplyToHeight(number: 20)
            
            gi.center == gb.center
            gi.width == Constant.multiplyToWidth(number: 24)
            gi.height == Constant.multiplyToHeight(number: 20)
            
            pi.center == pb.center
            pi.width == Constant.multiplyToWidth(number: 18)
            pi.height == Constant.multiplyToHeight(number: 22)
            
            seti.center == setb.center
            seti.width == Constant.multiplyToWidth(number: 22)
            seti.height == Constant.multiplyToHeight(number: 22)
        }
        [soundButton, graphButton, profileButton, settingsButton].forEach { (button) in
            constrain(button, self){ b, v in
                b.centerY == v.centerY
                b.height == Constant.multiplyToHeight(number: 55)
                b.width == Constant.multiplyToWidth(number: 70)
            }
        }
        [firstLine, secondLine, thirdLine].forEach { (line) in
            constrain(line, self){ l, v in
                l.centerY == v.centerY
                l.height == Constant.multiplyToHeight(number: 33)
                l.width == Constant.multiplyToWidth(number: 1)
            }
        }
        constrain(soundButton, firstLine, graphButton, secondLine, profileButton, thirdLine, settingsButton, self){ sb, fl, gb, sl, pb, tl, setb, v in
            sb.left == v.left + Constant.multiplyToWidth(number: 7)
            
            fl.left == sb.right + Constant.multiplyToWidth(number: 7)
            
            gb.left == fl.right + Constant.multiplyToWidth(number: 7)
            
            sl.left == gb.right + Constant.multiplyToWidth(number: 6)
            
            pb.left == sl.right + Constant.multiplyToWidth(number: 7)
            
            tl.left == pb.right + Constant.multiplyToWidth(number: 7)
            
            setb.left == tl.right + Constant.multiplyToWidth(number: 7)
            
        }
        
    }
}
