//
//  CarCollectionViewCell.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 28.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography

class CarCollectionViewCell: UICollectionViewCell {
    
    lazy var carNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .catalinaBlue
        return label
    }()
    
    lazy var carImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews(){
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.addSubview(carNameLabel)
        self.addSubview(carImage)
    }
    
    func configureConstraints(){
        constrain(carNameLabel, carImage, contentView) { cnl, ci, cv in
            cnl.top == cv.top + 16
            cnl.centerX == cv.centerX
            
            ci.top == cnl.bottom + 93
            ci.centerX == cv.centerX
            ci.height == 130
            ci.width == 248
        }
    }
}
