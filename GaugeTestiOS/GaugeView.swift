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
    
    let arcStrokeSize: CGFloat = 20.0
    var shapeLayer: CAShapeLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        print("DRAW")
        
        initialize()
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        let size = min(width, height)
        
        let centerX = width / 2
        let centerY = height / 2 + 3 * size / 8
        
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = arcStrokeSize
        var circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX,y: centerY), radius: CGFloat(size / 2 - arcStrokeSize), startAngle: CGFloat(180).degreesToRadians, endAngle:CGFloat(279).degreesToRadians, clockwise: true)
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        self.layer.addSublayer(shapeLayer)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = arcStrokeSize
        circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX,y: centerY), radius: CGFloat(size / 2 - arcStrokeSize), startAngle: CGFloat(279).degreesToRadians, endAngle:CGFloat(306).degreesToRadians, clockwise: true)
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = UIColor.yellow.cgColor
        self.layer.addSublayer(shapeLayer)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = arcStrokeSize
        circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX,y: centerY), radius: CGFloat(size / 2 - arcStrokeSize), startAngle: CGFloat(306).degreesToRadians, endAngle:CGFloat(324).degreesToRadians, clockwise: true)
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = UIColor.orange.cgColor
        self.layer.addSublayer(shapeLayer)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = arcStrokeSize
        circlePath = UIBezierPath(arcCenter: CGPoint(x: centerX,y: centerY), radius: CGFloat(size / 2 - arcStrokeSize), startAngle: CGFloat(324).degreesToRadians, endAngle:CGFloat(360).degreesToRadians, clockwise: true)
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        self.layer.addSublayer(shapeLayer)
    }
    
    private func initialize() {
    }
    
    func showGauge() {
        print("SHOULD BE DRAWN")
    }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
