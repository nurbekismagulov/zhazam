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
        label.numberOfLines = 2
        label.textColor = .catalinaBlue
        label.textAlignment = .center
        return label
    }()
    
    lazy var carImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
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
            cnl.left == cv.left + 29
            cnl.right == cv.right - 29
            
            ci.top == cnl.bottom + 93
            ci.centerX == cv.centerX
            ci.height == 130
            ci.width == 248
        }
    }
}
