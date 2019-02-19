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
        label.font = .boldSystemFont(ofSize: Constant.multiplyToWidth(number: 32))
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
        self.layer.cornerRadius = Constant.multiplyToHeight(number: 15)
        self.addSubview(carNameLabel)
        self.addSubview(carImage)
    }
    
    func configureConstraints(){
        constrain(carNameLabel, carImage, contentView) { cnl, ci, cv in
            cnl.top == cv.top + Constant.multiplyToHeight(number: 16)
            cnl.left == cv.left + Constant.multiplyToWidth(number: 29)
            cnl.right == cv.right - Constant.multiplyToWidth(number: 29)
            
            ci.top == cnl.bottom + Constant.multiplyToHeight(number: 93)
            ci.centerX == cv.centerX
            ci.height == Constant.multiplyToHeight(number: 130)
            ci.width == Constant.multiplyToHeight(number: 248)
        }
    }
}
