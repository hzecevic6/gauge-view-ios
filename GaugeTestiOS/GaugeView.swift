//
//  GaugeView.swift
//  GaugeTestiOS
//
//  Created by Helena Zecevic on 1/25/18.
//  Copyright © 2018 Helena Zecevic. All rights reserved.
//

import Foundation
import UIKit

class GaugeView: UIView {
    
    override func draw(_ rect: CGRect) {
        print("DRAW")
        
        let height = self.bounds.size.height
        let width = self.bounds.size.width
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100,y: 100), radius: CGFloat(20), startAngle: CGFloat(195).degreesToRadians, endAngle:CGFloat(270).degreesToRadians, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.red.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 20.0
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func showGauge() {
        print("SHOULD BE DRAWN")
    }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
