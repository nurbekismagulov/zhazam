//
//  CarsViewController.swift
//  Typeracer-iOS
//
//  Created by Nurbek Ismagulov on 28.07.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography
import UPCarouselFlowLayout

class CarsCollectionViewController: UIViewController, Reusable {
    
    var arrayOfCars: [Vehicle] = [
        Vehicle(fullImage: "Ferrari", iconImages: ["ferrariGreen", "ferrariYellow", "ferrariRed"], name: "Ferrari"),
        Vehicle(fullImage: "kawasaki", iconImages: ["k100Red", "k100Green", "k100Yellow"], name: "Kawasaki"),
        Vehicle(fullImage: "range", iconImages: ["gelikRed", "gelikGreen", "gelikYellow"], name: "Range Rover"),
        Vehicle(fullImage: "bike", iconImages: ["bikeGreen", "bikeYellow", "bikeRed"], name: "Harley"),
        Vehicle(fullImage: "Maserati", iconImages: ["maseratiRed", "maseratiGreen", "maseratiYellow"], name: "Maseratti")
    ]
    var atIndex = 0
    
    //MARK: - Views
    lazy var carLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose car"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: Constant.multiplyToWidth(number: 32))
        return label
    }()
    lazy var carouselLayout: UPCarouselFlowLayout = {
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: Constant.multiplyToHeight(number: 249), height: Constant.multiplyToHeight(number: 337))
        layout.scrollDirection = .horizontal
        return layout
    }()
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        cv.backgroundColor = .catalinaBlue
        cv.register(CarCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    lazy var startRaceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Start Race", for: .normal)
        button.setTitleColor(.catalinaBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constant.multiplyToWidth(number: 19))
        button.addTarget(self, action: #selector(startRaceButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = Constant.multiplyToHeight(number: 7)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createViews()
        configureConstraints()
    }
    
    func configureView(){
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    func createViews(){
        view.addSubview(carLabel)
        view.addSubview(collectionView)
        view.addSubview(startRaceButton)
    }
    
    @objc func startRaceButtonPressed(){
        let vc = ClassicModeViewController()
        vc.game.carIcon = random(array: arrayOfCars[atIndex].iconImages) as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func configureConstraints(){
        constrain(carLabel, collectionView, startRaceButton, view){ cl, cv, srb, v in
            cl.top == v.top + Constant.multiplyToHeight(number: 25)
            cl.centerX == v.centerX
            
            cv.top == cl.bottom + Constant.multiplyToHeight(number: 50)
            cv.left == v.left
            cv.right == v.right
            cv.height == Constant.multiplyToHeight(number: 337)
            
            srb.top == cv.bottom + Constant.multiplyToHeight(number: 50)
            srb.centerX == v.centerX
            srb.height == Constant.multiplyToHeight(number: 58)
            srb.width == Constant.multiplyToWidth(number: 183)
            
            if UIScreen.main.bounds.height == 812 {
                srb.top == cv.bottom + 50
                srb.centerX == v.centerX
                srb.height == 58
                srb.width == 183
            }
        }
    }
    func random(array: [Any]) -> Any {
        return array[Int(arc4random_uniform(UInt32(array.count)))]
        
    }
}

extension CarsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfCars.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CarCollectionViewCell
        cell.carNameLabel.text = arrayOfCars[indexPath.row].name
        cell.carImage.image = UIImage(named: arrayOfCars[indexPath.row].fullImage)
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        atIndex = (collectionView.indexPathForItem(at: visiblePoint)?.row)!
    }
    
}
