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
    
    var arr = ["powel", "nahooi", "pidor", "nurbek", "is", "the", "best", "pidorasi", "ebal", "v", "rot"]
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0:58"
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    
    lazy var firstWordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = arr[0]
        label.font = .systemFont(ofSize: 55)
        return label
    }()
    
    lazy var secondWordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.alpha = 0.7
        label.text = arr[1]
        label.font = .systemFont(ofSize: 35)
        return label
    }()
    
    lazy var thirdWordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.alpha = 0.5
        label.text = arr[2]
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    lazy var testButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 140, y: 500, width: 100, height: 50))
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(testButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var erasableTextField = ErasableTextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createViews()
        configureConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func createViews() {
        [timeLabel, firstWordLabel, secondWordLabel, thirdWordLabel, erasableTextField, testButton].forEach { view.addSubview($0) }
    }
    func configureConstraints() {
        constrain(timeLabel, firstWordLabel, secondWordLabel, thirdWordLabel, erasableTextField, view) { tl, fwl, swl, twl, et, v in
            tl.top == v.top + 20
            tl.centerX == v.centerX
            
            fwl.top == tl.bottom + 15
            fwl.centerX == v.centerX
            
            swl.top == fwl.bottom + 10
            swl.centerX == v.centerX
            
            twl.top == swl.bottom + 10
            twl.centerX == v.centerX
            
            et.top == twl.bottom + 65
            et.left == v.left
            et.right == v.right
        }
    }
    
    @objc func testButtonPressed() {
//        for i in 0...arr.count - 2 {
//            UIView.animate(withDuration: 0.3, delay: 0.5, options: .allowAnimatedContent, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//        }
    }
    
}
