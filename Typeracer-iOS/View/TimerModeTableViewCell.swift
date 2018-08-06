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
        //        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(label)
        constrain(label, self) { l, cv in
            l.center == cv.center
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
