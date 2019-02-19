//
//  ProfileViewController.swift
//  Typeracer-iOS
//
//  Created by Adlet on 06.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit
import Cartography
import ScrollableGraphView
import UPCarouselFlowLayout
import RealmSwift

class ProfileViewController: UIViewController, Reusable {
    
    //MARK: Properties
    var realm: Realm!
    var data = 0
    var data1 = 0
    
    var classicModeResults: Results<ClassicResult> {
        get {
            return realm.objects(ClassicResult.self)
        }
    }
    
    var timerModeResults: Results<TimerResult> {
        get {
            return realm.objects(TimerResult.self)
        }
    }
    

    //MARK: UI init
    
    lazy var layout: UPCarouselFlowLayout = {
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: Constant.multiplyToHeight(number: 260), height: Constant.multiplyToHeight(number: 230))
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        return cv
    }()
    
    lazy var plot: LinePlot = {
        let linePlot = LinePlot(identifier: "line")
        linePlot.lineColor = .candyAppleRed
        linePlot.setLineStyle()
        return linePlot
    }()
    
    
    lazy var dot: DotPlot = {
        let linePlotDot = DotPlot(identifier: "lineColor")
        linePlotDot.setDotStyle()
        linePlotDot.dataPointFillColor = .candyAppleRed
        return linePlotDot
    }()
    
    lazy var graphView: ScrollableGraphView = {
        let graph = ScrollableGraphView()
        let linePlot2 = LinePlot(identifier: "line2")
        linePlot2.lineColor = .deepSkyBlue
        linePlot2.setLineStyle()
        let linePlotDot2 = DotPlot(identifier: "lineColor2")
        linePlotDot2.setDotStyle()
        linePlotDot2.dataPointFillColor = .deepSkyBlue//"#16aafc".hexColor
        let referenceLines = ReferenceLines()
        referenceLines.setReferenceStyle()
        graph.setGraphStyle()
        graph.addReferenceLines(referenceLines: referenceLines)
        graph.addPlot(plot: plot)
        graph.addPlot(plot: dot)
        graph.addPlot(plot: linePlot2)
        graph.addPlot(plot: linePlotDot2)
        graph.dataSource = self
        graph.alpha = 0
        return graph
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Play at least 10 games\nto see statistics"
        label.font = .boldSystemFont(ofSize: Constant.multiplyToWidth(number: 30))
        label.textAlignment = .center
        label.textColor = .white
        label.alpha = 1
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Average of last 10 results"
        label.font = .boldSystemFont(ofSize: Constant.multiplyToWidth(number: 12))
        label.textAlignment = .center
        label.textColor = .white
        label.alpha = 0
        label.numberOfLines = 0
        return label
    }()
    
    lazy var fView: UIView = {
        let view = UIView()
        view.backgroundColor = .deepSkyBlue
        view.layer.cornerRadius = Constant.multiplyToWidth(number: 3)
        view.alpha = 0
        return view
    }()
    
    lazy var sView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constant.multiplyToWidth(number: 3)
        view.backgroundColor = .candyAppleRed
        view.alpha = 0
        return view
    }()
    
    lazy var fLabel: UILabel = {
        let label = UILabel()
        label.text = "timer"
        label.textColor = .white
        label.font = .systemFont(ofSize: Constant.multiplyToWidth(number: 12))
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()
    
    lazy var sLabel: UILabel = {
        let label = UILabel()
        label.text = "classic"
        label.font = .systemFont(ofSize: Constant.multiplyToWidth(number: 12))
        label.textColor = .white
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        realm = try? Realm()
        print(classicModeResults)
        print(timerModeResults)
        if classicModeResults.count >= 9 || timerModeResults.count >= 9 {
            self.infoLabel.alpha = 0
            [graphView, descriptionLabel, fView, fLabel, sView, sLabel].forEach { $0.alpha = 1 }
            self.loadViewIfNeeded()
        }
    }
    
    //MARK: Set views
    func configureViews(){
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
        [graphView, collectionView, infoLabel, descriptionLabel, fView, sView, fLabel, sLabel].forEach(view.addSubview)
    }
    
    func configureConstraints(){
        constrain(graphView, collectionView, infoLabel, descriptionLabel, view){gv, cv, il, dl, v in
            gv.bottom == v.bottom - Constant.multiplyToHeight(number: 5)
            gv.width == v.width
            gv.height == Constant.multiplyToHeight(number: 250)
            
            cv.top == v.top
            cv.left == v.left
            cv.right == v.right
            cv.height == Constant.multiplyToHeight(number: 300)
            
            dl.bottom == gv.top
            dl.left == v.left + Constant.multiplyToWidth(number: 20)
            
            il.centerX == v.centerX

            if UIScreen.main.bounds.height == 812 {
                il.bottom == v.bottom - 200
            } else {
                il.bottom == v.bottom - Constant.multiplyToHeight(number: 150)
            }
        }
        constrain(fView, sView, descriptionLabel, fLabel, sLabel, view){fv, sv, dl, fl, sl, v in
            fv.left == dl.right + Constant.multiplyToWidth(number: 100)
            fv.top == dl.top + Constant.multiplyToHeight(number: 4)
            fv.height == Constant.multiplyToHeight(number: 12)
            fv.width == Constant.multiplyToWidth(number: 12)
            
            fl.top == fv.top
            fl.left == fv.right + Constant.multiplyToWidth(number: 4)
            fl.height == Constant.multiplyToHeight(number: 12)
            fl.width == Constant.multiplyToWidth(number: 30)
            
            sv.top == fv.top + Constant.multiplyToHeight(number: 1)
            sv.left == fl.right + Constant.multiplyToWidth(number: 4)
            sv.height == Constant.multiplyToHeight(number: 12)
            sv.width == Constant.multiplyToWidth(number: 12)
            
            sl.top == fl.top
            sl.left == sv.right + Constant.multiplyToWidth(number: 4)
            fl.height == Constant.multiplyToHeight(number: 12)
            fl.width == Constant.multiplyToWidth(number: 30)
        }
    }
    
    
}

//MARK: GraphView delegate and dataSource
extension ProfileViewController: ScrollableGraphViewDataSource {
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        switch(plot.identifier) {
        case "line","lineColor":
            if classicModeResults.count > 9 {
                data = classicModeResults[classicModeResults.count - 10 + pointIndex].result
            }
            else{
                data = -200
            }
            return Double(data)
        case "line2","lineColor2":
            if timerModeResults.count > 9 {
                data1 = timerModeResults[timerModeResults.count - 10 + pointIndex].result
            }
            else{
                data1 = -200
            }
            return Double(data1)
        default:
            return 0
        }
    }

    func label(atIndex pointIndex: Int) -> String {
        return "\(pointIndex)"
    }

    func numberOfPoints() -> Int {
            if classicModeResults.count > 9 {
                return 10
            } else if timerModeResults.count > 9 {
                return 10
            }
            return 0
    }
}

//MARK: UICollectionView delegate and dataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ResultCollectionViewCell
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Last Results"
            if let last = classicModeResults.last{
                cell.classicLabel.text = "\(last.result) wpm"
                print(last)
            }
            if let last = timerModeResults.last{
                cell.timerLabel.text = "\(last.result) wpm"
                print(last)
            }
        case 1:
            cell.titleLabel.text = "Average of last 10"
            cell.timerLabel.text = "\(data1) wpm"
            cell.classicLabel.text = "\(data) wpm"
        case 2:
            cell.titleLabel.text = "Average of all results"
        default:
            cell.titleLabel.text = "Best"
        }
        return cell
    }
}




