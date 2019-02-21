//
//  ViewController.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 22.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class MainMenuViewController: UIViewController {
    
    //MARK: Properties
    var isPressed = true
    
    
    // MARK: - views
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.setTextWithTypeAnimation(typedText: " ZHAZAM")
        label.font = .setCabinSketch(ofSize: Constant.multiplyToWidth(number: 70))
        return label
    }()
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constant.multiplyToHeight(number: 8)
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var animatedContainerView = AnimatedView()
    
    lazy var playImageView = UIImageView(image: UIImage(named: "play"))
    
    lazy var menuView: MenuView = {
        let menuView = MenuView()
        menuView.graphButton.addTarget(self, action: #selector(graphPressed), for: .touchUpInside)
        menuView.soundButton.addTarget(self, action: #selector(soundPressed), for: .touchUpInside)
        menuView.settingsButton.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        return menuView
    }()
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        self.playButton.setGradientBackground()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatedContainerView.animateBubbles()
    }
  
    func commonInit() {
        view.backgroundColor = .catalinaBlue
        Music.share.playBackgroundMusic(filename: "sound")
    }
    
    // MARK : - creating Views
    func setupViews(){
        [animatedContainerView,nameLabel, playButton, menuView].forEach(view.addSubview)
        playButton.addSubview(playImageView)
    }
   
    func setupConstraints(){
        constrain(nameLabel, view){ nl, v in
            nl.top == v.top + Constant.multiplyToHeight(number: 150)
            nl.centerX == v.centerX
            nl.width == Constant.multiplyToWidth(number: 300)
        }
        
        constrain(menuView, playButton, view) { mv, pb, v in
            mv.bottom == v.bottom - 65
            mv.centerX == v.centerX
            mv.height == Constant.multiplyToHeight(number: 66)
            mv.width == Constant.multiplyToWidth(number: 335)
            
            pb.bottom == mv.top - Constant.multiplyToHeight(number: 20)
            pb.centerX == v.centerX
            pb.height == Constant.multiplyToHeight(number: 66)
            pb.width == Constant.multiplyToWidth(number: 335)
        }
        
        constrain(playImageView, playButton) { pi, pb in
            pi.center == pb.center
            pi.height == Constant.multiplyToHeight(number: 30)
            pi.width == Constant.multiplyToWidth(number: 20)
        }
    }
    
    //MARK: Helper methods
    @objc func playPressed(){
        let vc = PlayViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func graphPressed(){
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func soundPressed(){
        if isPressed {
            Music.share.backgroundMusicPlayer.pause()
            menuView.soundImageView.image = #imageLiteral(resourceName: "musinOff")
            isPressed.toggle()
        } else {
            Music.share.backgroundMusicPlayer.play()
            menuView.soundImageView.image = #imageLiteral(resourceName: "musicOn")
            isPressed.toggle()
        }
    }
   
    @objc func settingsPressed(){
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
