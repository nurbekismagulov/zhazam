//
//  ModeView.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 25.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class SwitchView: UIView {
    
   // weak var delegate: SWitchViewDelegate?
    
    var atIndex = 0
    var initialTouchPoint:CGPoint = CGPoint(x: 0, y: 0)
    var images: [UIImage] = [#imageLiteral(resourceName: "singleplayerWhite"), #imageLiteral(resourceName: "multiplayerBlue"), #imageLiteral(resourceName: "singleplayerBlue"), #imageLiteral(resourceName: "multiplayerWhite")]
    
    // MARK: - Views
    lazy var choiceView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var firstImage: UIImageView = {
        let image = UIImageView(image: images[0])
        return image
    }()
    
    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Single Player"
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var secondImage: UIImageView = {
        let image = UIImageView(image: images[1])
        return image
    }()
    lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.textColor = .catalinaBlue
        label.text = "Multiplayer"
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    lazy var offlineIsEnableCircle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7.5
        view.backgroundColor = .appleGreen
        return view
    }()
    lazy var onlineIsEnableCircle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7.5
        view.backgroundColor = .candyAppleRed
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        createViews()
        setupConstraints()
        addGestures()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Creating views
    func configureView(){
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
    }
    func createViews(){
        [choiceView, firstImage, firstLabel, secondImage, secondLabel, offlineIsEnableCircle, onlineIsEnableCircle].forEach { self.addSubview($0) }
    }
    
    func addGestures() {
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp))
        swipeUpGesture.direction = .up
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        swipeDownGesture.direction = .down
        self.addGestureRecognizer(swipeUpGesture)
        self.addGestureRecognizer(swipeDownGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func swipeUp(){
        if atIndex == 1 {
            animateAtIndexOne()
        }
    }
    @objc func swipeDown(){
        if atIndex == 0 {
            animateAtIndexZero()
        }
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        if !choiceView.frame.contains(sender.location(in: self)) {
            if atIndex == 0 {
                animateAtIndexZero()
            }
            else {
                animateAtIndexOne()
            }
        }
    }
    func animateAtIndexZero() {
        UIView.animate(withDuration: 0.2) {
            self.choiceView.frame = CGRect(x: 0, y: self.choiceView.frame.height, width: self.frame.size.width, height: self.choiceView.frame.height)
        }
        atIndex = 1
        firstImage.image = images[2]
        firstLabel.textColor = .catalinaBlue
        secondImage.image = images[3]
        secondLabel.textColor = .white
    }
    func animateAtIndexOne() {
        UIView.animate(withDuration: 0.2) {
            self.choiceView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.choiceView.frame.height)
        }
        atIndex = 0
        firstImage.image = images[0]
        firstLabel.textColor = .white
        secondImage.image = images[1]
        secondLabel.textColor = .catalinaBlue
    }
    func setImages(arrayOfImages: [UIImage]){
        firstImage.image = arrayOfImages[0]
        secondImage.image = arrayOfImages[1]
    }
    
    // MARK: - Layouts
    func setupConstraints(){
        constrain(choiceView, firstImage, firstLabel, secondImage, secondLabel, offlineIsEnableCircle, onlineIsEnableCircle, self) { cv, si, sl, mi, ml, ofc, onc, v in
            cv.top == v.top
            cv.left == v.left
            cv.right == v.right
            cv.height == 169
            
            si.top == v.top + 48
            si.centerX == v.centerX
            si.height == 51
            si.width == 42
            
            sl.top == si.bottom + 26
            sl.centerX == v.centerX
            
            ml.bottom == v.bottom - 35
            ml.centerX == v.centerX
            
            mi.bottom == ml.top - 24
            mi.centerX == v.centerX
            
            
            ofc.top == v.top + 15
            ofc.right == v.right - 15
            ofc.height == 15
            ofc.width == 15
            
            onc.bottom == v.bottom - 138
            onc.right == v.right - 15
            onc.height == 15
            onc.width == 15
        }
    }
    
}
