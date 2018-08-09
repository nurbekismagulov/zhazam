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
        label.font = .boldSystemFont(ofSize: Constant.multiplyToWidth(number: 32))
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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constant.multiplyToWidth(number: 19))
        button.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = Constant.multiplyToHeight(number: 37)
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
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
            ml.top == v.top + Constant.multiplyToHeight(number: 25)
            ml.centerX == v.centerX
            
            mv.top == ml.bottom + Constant.multiplyToHeight(number: 50)
            mv.centerX == v.centerX
            mv.height == Constant.multiplyToHeight(number: 337)
            mv.width == Constant.multiplyToWidth(number: 184)
            
            ob.centerX == v.centerX
            ob.height == Constant.multiplyToHeight(number: 74)
            ob.width == Constant.multiplyToHeight(number: 74)
                        
            if UIScreen.main.bounds.height == 812 {
                ob.bottom == v.bottom - 120
            } else {
                ob.bottom == v.bottom - Constant.multiplyToHeight(number: 40)
            }
        }
    }
}
