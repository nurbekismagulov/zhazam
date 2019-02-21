//
//  TimerModeTableViewCell.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 06.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class TimerModeTableViewCell: UITableViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Constant.multiplyToWidth(number: 15))
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        setupViews()
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        self.backgroundColor = .catalinaBlue
    }
    func setupViews() {
        contentView.addSubview(label)
    }
    func setupConstraints() {
        constrain(label, contentView) { l, cv in
            l.center == cv.center
        }
    }
}
