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
        layout.itemSize = CGSize(width: 260, height: 230)
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
        linePlot.lineColor = "#16aafc".hexColor
        linePlot.setLineStyle()
   
        return linePlot
    }()
    
    
    lazy var dot: DotPlot = {
        let linePlotDot = DotPlot(identifier: "lineColor")
        linePlotDot.setDotStyle()
        linePlotDot.dataPointFillColor = "#16aafc".hexColor
        return linePlotDot
    }()
    
    lazy var graphView: ScrollableGraphView = {
        let graph = ScrollableGraphView()
        let linePlot2 = LinePlot(identifier: "line2")
        linePlot2.lineColor = .candyAppleRed
        linePlot2.setLineStyle()
        let linePlotDot2 = DotPlot(identifier: "lineColor2")
        linePlotDot2.setDotStyle()
        linePlotDot2.dataPointFillColor = .candyAppleRed
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
        label.text = "You need to ..."
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        label.textColor = .white
        label.alpha = 1
        label.numberOfLines = 0
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
            self.graphView.alpha = 1
            self.infoLabel.alpha = 0
            self.loadViewIfNeeded()
        }
    }
 
    
    //MARK: Set views
    func configureViews(){
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
        [graphView, collectionView, infoLabel ].forEach( {view.addSubview($0)} )
    }
    
    func configureConstraints(){
        constrain(graphView, collectionView, infoLabel, view){gv, cv, il, v in
            gv.bottom == v.bottom - 5
            gv.width == v.width
            gv.height == 250
            
            cv.top == v.top
            cv.left == v.left
            cv.right == v.right
            cv.height == 300
            
            il.bottom == v.bottom - 5
            il.width == v.width
            il.height == 250
            
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
            cell.timerLabel.text = "\(data1)"
            cell.classicLabel.text = "\(data)"
        case 2:
            cell.titleLabel.text = "Average of all results"
        default:
            cell.titleLabel.text = "Best"
        }
        return cell
    }
}




