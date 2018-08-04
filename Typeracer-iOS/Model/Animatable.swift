//
//  Animatable.swift
//  Typeracer-iOS
//
//  Created by Adlet on 03.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import Foundation

import UIKit

protocol Animatable {
    
    var width: CGFloat { get }
    var height: CGFloat { get }
    func animate(_ view: UIView, xRandomizer: CGFloat, yRandomizer: CGFloat)
    func createBezierPath() -> UIBezierPath
    func randomCGPoint() -> CGPoint
    func offScreenCGPoint() -> CGPoint
}

extension Animatable {
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func createBezierPath() -> UIBezierPath {
        let path = UIBezierPath()
        let curves = Int(arc4random_uniform(4))
        path.move(to: offScreenCGPoint())
        for _ in 0...curves {
            path.addQuadCurve(to: randomCGPoint(), controlPoint: randomCGPoint())
        }
        path.addQuadCurve(to: offScreenCGPoint(), controlPoint: offScreenCGPoint())
        return path
    }
    
    
    
    func randomCGPoint() -> CGPoint {
        let xPoint = CGFloat(arc4random_uniform(UInt32(width)))
        let yPoint = CGFloat(arc4random_uniform(UInt32(height)))
        
        let point = CGPoint(x: xPoint, y: yPoint)
        return point
    }
    
    func offScreenCGPoint() -> CGPoint {
        var xPoint = CGFloat(arc4random_uniform(UInt32(width)))
        var yPoint = CGFloat(arc4random_uniform(UInt32(height)))
        
        let w = CGFloat(width / 2)
        if xPoint >= w {
            xPoint += w
        }
        else {
            xPoint -= w
        }
        
        let h = CGFloat(height / 2)
        if yPoint >= h {
            yPoint += h
        }
        else {
            yPoint -= h
        }
        
        let point = CGPoint(x: xPoint, y: yPoint)
        return point
    }
}
