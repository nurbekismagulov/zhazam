//
//  ComingSoonViewController.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 31.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class ComingSoonViewController: UIViewController {

    lazy var comingSoonLabel: UILabel = {
        let label = UILabel()
        label.text = "Coming Soon..."
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        view.addSubview(comingSoonLabel)
        configureConstraints()
    }

    func configureView(){
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    func configureConstraints() {
        constrain(comingSoonLabel, view) { csl, v in
            csl.center == v.center
        }
    }
    
}
