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
        Vehicle(fullImage: "bike", iconImages: ["bikeGreen", "bikeYellow", "bikeRed"], name: "Harley Davidson"),
        Vehicle(fullImage: "Ferrari", iconImages: ["ferrariGreen", "ferrariYellow", "ferrariRed"], name: "Ferrari"),
        Vehicle(fullImage: "bike", iconImages: ["bikeGreen", "bikeYellow", "bikeRed"], name: "Harley Davidson"),
        Vehicle(fullImage: "Ferrari", iconImages: ["ferrariGreen", "ferrariYellow", "ferrariRed"], name: "Ferrari")
    ]
    var atIndex = 0
    
    //MARK: - Views
    lazy var carLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose mode"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    lazy var carouselLayout: UPCarouselFlowLayout = {
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: 249, height: 337)
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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.addTarget(self, action: #selector(startRaceButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 7
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
            cl.top == v.top + 25
            cl.centerX == v.centerX
            
            cv.top == cl.bottom + 50
            cv.left == v.left
            cv.right == v.right
            cv.height == 337
            
            srb.top == cv.bottom + 50
            srb.centerX == v.centerX
            srb.height == 58
            srb.width == 183
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
