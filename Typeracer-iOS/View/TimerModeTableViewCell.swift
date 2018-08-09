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

    let label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        
    }
    func configure(){
        label.textColor = .white
        self.backgroundColor = .catalinaBlue
        label.font = UIFont.systemFont(ofSize: Constant.multiplyToWidth(number: 15))
        self.addSubview(label)
        constrain(label, self) { l, cv in
            l.center == cv.center
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
