//
//  SettingsTableViewCell.swift
//  Typeracer-iOS
//
//  Created by Adlet on 08.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class SettingsTableViewCell: UITableViewCell {
    
    //MARK: UI init
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Avenir-Next", size: 16)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = "#16aafc".hexColor
        return titleLabel
    }()
    
    lazy var cellIcon: UIImageView = {
        let cellIcon = UIImageView()
        cellIcon.layer.shadowColor = UIColor.black.cgColor
        cellIcon.layer.shadowOpacity = 0.07
        cellIcon.layer.shadowOffset = CGSize(width: 1, height: 1)
        cellIcon.layer.shadowRadius = 3
        return cellIcon
    }()
    
    //MARK: Initilizer
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    //MARK: Set views
    func configureViews(){
        [titleLabel, cellIcon].forEach({contentView.addSubview($0)})
    }
    
    func configureConstraints(){
        constrain(titleLabel, cellIcon, contentView) { tl, ci, sf in
            ci.centerY == sf.centerY
            ci.left == sf.left + 15
            
            tl.centerY == sf.centerY
            tl.left == ci.right + 20
        }
    }

}
