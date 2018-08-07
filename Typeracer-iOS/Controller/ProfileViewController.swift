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

class ProfileViewController: UIViewController, Reusable {
    
    //MARK: Properties
    let graph = [50,30,10,70,40,40,80,60]
    let graph2 = [10,65,55,30,70,20,80,12,12,4]

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
    
    lazy var graphView: ScrollableGraphView = {
        let graph = ScrollableGraphView()
        let linePlot = LinePlot(identifier: "line")
        linePlot.lineColor = "#16aafc".hexColor
        linePlot.setLineStyle()
        let linePlotDot = DotPlot(identifier: "lineColor")
        linePlotDot.setDotStyle()
        linePlotDot.dataPointFillColor = "#16aafc".hexColor
        let linePlot2 = LinePlot(identifier: "line2")
        linePlot2.lineColor = .red
        linePlot2.setLineStyle()
        let linePlotDot2 = DotPlot(identifier: "lineColor2")
        linePlotDot2.setDotStyle()
        linePlotDot2.dataPointFillColor = .red
        let referenceLines = ReferenceLines()
        referenceLines.setReferenceStyle()
        graph.setGraphStyle()
        graph.addReferenceLines(referenceLines: referenceLines)
        graph.addPlot(plot: linePlot)
        graph.addPlot(plot: linePlotDot)
        graph.addPlot(plot: linePlot2)
        graph.addPlot(plot: linePlotDot2)
        graph.dataSource = self
        return graph
    }()


    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
    }
    
    //MARK: Set views
    func configureViews(){
        view.backgroundColor = .catalinaBlue
        self.navigationController?.navigationBar.topItem?.title = ""
        [graphView, collectionView].forEach( {view.addSubview($0)} )
    }
    
    func configureConstraints(){
        constrain(graphView, view){gv, v in
            gv.bottom == v.bottom - 5
            gv.width == v.width
            gv.height == 300

        }
        constrain(collectionView, view){cv, v in
            cv.top == v.top
            cv.left == v.left
            cv.right == v.right
            cv.height == 300
        }
    }
    
 
    
    

}

//MARK: GraphView delegate and dataSource
extension ProfileViewController: ScrollableGraphViewDataSource {
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        switch(plot.identifier) {
        case "line","lineColor":
            let data = graph[pointIndex]
            return Double(data)
        case "line2","lineColor2":
            return Double(graph2[pointIndex])
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return "Jan\(pointIndex)"
    }
    
    func numberOfPoints() -> Int {
         return graph.count
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
        case 1:
            cell.titleLabel.text = "Average of last 10"
        case 2:
            cell.titleLabel.text = "Average of all results"
        default:
            cell.titleLabel.text = "Best"
        }
        return cell
    }
}





