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

    // MARK: - views
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.setTextWithTypeAnimation(typedText: " TYPERACER")
        label.font = .systemFont(ofSize: 55)
        return label
    }()
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var animatedConteinerView: AnimatedView = {
        let anim = AnimatedView(frame: .zero)
        return anim
    }()
    
    lazy var playImage = UIImageView(image: UIImage(named: "play"))
    
    lazy var menuView = MenuView()
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .catalinaBlue
        createViews()
        addTargetsToMenuView()
        configureConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        playButton.setGradientBackground()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animatedConteinerView.animateBubbles()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animatedConteinerView.animateBubbles()
    }
    
    // MARK : - creating Views
    func createViews(){
        [animatedConteinerView, nameLabel, playButton, menuView].forEach { view.addSubview($0) }
        playButton.addSubview(playImage)
    }
    func addTargetsToMenuView(){
        [menuView.graphButton, menuView.soundButton, menuView.profileButton, menuView.settingsButton].forEach{ $0.addTarget(self, action: #selector(otherButtonsPressed), for: .touchUpInside) }
    }
    func configureConstraints(){
        
        constrain(nameLabel, view){ nl, v in
            nl.top == v.top + 150
            nl.centerX == v.centerX
            nl.width == 330
        }
        
        constrain(menuView, playButton, view) { mv, pb, v in
            mv.bottom == v.bottom - 65
            mv.centerX == v.centerX
            mv.height == 66
            mv.width == 335
            
            pb.bottom == mv.top - 20
            pb.centerX == v.centerX
            pb.height == 66
            pb.width == 335
        }
        
        constrain(playImage, playButton) { pi, pb in
            pi.center == pb.center
            pi.height == 30
            pi.width == 20
        }
    }
    
    @objc func playPressed(){
        let vc = PlayViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func otherButtonsPressed() {
        let vc = ComingSoonViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
/*
 KANBAN
 how to do feature experiments
 pomodore principle
 find your own cave
 */
