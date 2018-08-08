//
//  ModesViewController.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 26.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class ModesViewController: UIViewController {
    
    //MARK: - Views
    lazy var modeLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose mode"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    lazy var switchView: SwitchView = {
        let view = SwitchView()
        view.firstLabel.text = "Classic"
        view.secondLabel.text = "Timer"
        view.offlineIsEnableCircle.backgroundColor = .clear
        view.onlineIsEnableCircle.backgroundColor = .clear
        view.images = [#imageLiteral(resourceName: "flagWhite"), #imageLiteral(resourceName: "timerBLue"), #imageLiteral(resourceName: "flagBlue"), #imageLiteral(resourceName: "timerWhite")]
        view.setImages(arrayOfImages: view.images)
        return view
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.catalinaBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 37
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createViews()
        configureConstraints()
    }
    override func viewDidLayoutSubviews() {
        switchView.layoutIfNeeded()
        switchView.choiceView.setGradientBackground()
    }
    
    //MARK: - Creating views
    func configureView(){
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    func createViews(){
        [modeLabel, switchView, okButton].forEach { view.addSubview($0) }
    }
    
    // MARK: - Logic
    @objc func okButtonPressed() {
        switch switchView.atIndex {
        case 0:
            let vc = CarsCollectionViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = TimerModeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
    
    // MARK: - Layouts
    func configureConstraints(){
        constrain(modeLabel, switchView, okButton, view){ ml, mv, ob, v in
            ml.top == v.top + 25
            ml.centerX == v.centerX
            
            mv.top == ml.bottom + 50
            mv.centerX == v.centerX
            mv.height == 337
            mv.width == 184
            
            ob.bottom == v.bottom - 40
            ob.centerX == v.centerX
            ob.height == 74
            ob.width == 74
        }
    }
}
