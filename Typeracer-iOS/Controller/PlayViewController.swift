//
//  PlayViewController.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 24.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class PlayViewController: UIViewController {

    // MARK: - views
    lazy var modeLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose mode"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: Constant.multiplyToWidth(number: 32))
        return label
    }()
    
    lazy var switchView: SwitchView = {
        let view = SwitchView()
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
    
    override func viewLayoutMarginsDidChange() {
        switchView.choiceView.setGradientBackground()
    }
    
    //MARK: - creating Views
    func configureView(){
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    func createViews(){
        [modeLabel, switchView, okButton].forEach { view.addSubview($0) }
    }
    
    //MARK: - Logic
    @objc func okButtonPressed() {
        switch switchView.atIndex {
        case 0:
            let vc = ModesViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            showAlert()
            break
        default:
            break
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Sorry", message: "Coming soon.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Layouts
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
