//
//  TimerModeViewController.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 03.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class TimerModeViewController: UIViewController {
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var firstWordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var secondWordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.alpha = 0.7
        return label
    }()
    
    lazy var thirdWordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.alpha = 0.5
        return label
    }()
    
    lazy var erasableTextField = ErasableTextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createViews()
    }
    
    func configureView() {
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func createViews() {
        [timeLabel, firstWordLabel, secondWordLabel, thirdWordLabel, erasableTextField].forEach { view.addSubview($0) }
    }
    func configureConstraints() {
        
    }
    
}
