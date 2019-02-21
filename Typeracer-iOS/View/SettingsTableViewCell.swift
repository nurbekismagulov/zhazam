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
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Next", size: Constant.multiplyToWidth(number: 16))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.07
        imageView.layer.shadowOffset = CGSize(width: Constant.multiplyToHeight(number: 1), height: Constant.multiplyToHeight(number: 1))
        imageView.layer.shadowRadius = Constant.multiplyToHeight(number: 3)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: Initilizer
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    //MARK: Set views
    func setupViews(){
        [titleLabel, icon].forEach(contentView.addSubview)
    }
    
    func setupConstraints(){
        constrain(titleLabel, icon, contentView) { tl, ci, sf in
            ci.centerY == sf.centerY
            ci.width == Constant.multiplyToWidth(number: 24)
            ci.height == Constant.multiplyToHeight(number: 24)
            ci.left == sf.left + Constant.multiplyToWidth(number: 15)
            
            tl.centerY == sf.centerY
            tl.left == ci.right + Constant.multiplyToWidth(number: 20)
        }
    }
}
