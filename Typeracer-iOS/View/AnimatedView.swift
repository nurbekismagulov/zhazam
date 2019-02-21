//
//  AnimatedView.swift
//  Typeracer-iOS
//
//  Created by Adlet on 03.08.2018.
//  Copyright © 2018 theSmartest. All rights reserved.
//

import UIKit

class AnimatedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        generateBubbles(8)
        animateBubbles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateBubbles(_ number: Int){
        let x = self.frame.origin.x
        let y = self.frame.origin.y
        let w = self.frame.width
        let h = self.frame.height
        
        while subviews.count != number {
            let origin = Random.generatePoint(min: CGPoint(x: x, y: y), max: CGPoint(x: w, y: h))
            self.addSubview(generateBubble(origin: origin))
        }
    }
   
    func generateBubble(origin: CGPoint) -> UILabel {
        let bubble = RandomLabelView()
        bubble.frame.origin = origin
        return bubble
    }
    
    func animateBubbles() {
        for bubble in self.subviews {
            self.animate(bubble, xRandomizer: Random.generateCGFloat(0, 1.5), yRandomizer: Random.generateCGFloat(0, 1.5))
        }
    }


}

extension AnimatedView: Animatable {
    
    func animate(_ view: UIView, xRandomizer: CGFloat, yRandomizer: CGFloat) {
        let path = createBezierPath()
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = path.cgPath
//        anim.rotationMode = nil
        anim.repeatCount = Float.infinity
        anim.duration = 45
        anim.speed = 0.7
        view.layer.add(anim, forKey: "animate position along path")
    }
    
    
}
