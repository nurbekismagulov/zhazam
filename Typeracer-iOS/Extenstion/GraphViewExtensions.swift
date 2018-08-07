//
//  GraphViewExtensions.swift
//  Typeracer-iOS
//
//  Created by Adlet on 07.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation
import ScrollableGraphView

extension LinePlot {
    
    func setLineStyle(){
        self.adaptAnimationType = .easeOut
        self.lineStyle = .straight
    }
}

extension DotPlot {
   
    func setDotStyle(){
        self.dataPointType = .circle
        self.dataPointSize = 5
    }
}

extension ReferenceLines {
    
    func setReferenceStyle(){
        self.referenceLineLabelFont = .boldSystemFont(ofSize: 8)
        self.referenceLineLabelFont = .boldSystemFont(ofSize: 8)
        self.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        self.referenceLineLabelColor = .white
        self.relativePositions = [0, 0.2, 0.4, 0.6, 0.8, 1]
        self.dataPointLabelColor = UIColor.white.withAlphaComponent(1)
    }
}

extension ScrollableGraphView {
    
    func setGraphStyle(){
        self.backgroundFillColor = .catalinaBlue
        self.dataPointSpacing = 80
        self.shouldAnimateOnStartup = true
        self.shouldAdaptRange = true
        self.shouldRangeAlwaysStartAtZero = true
    }
}


