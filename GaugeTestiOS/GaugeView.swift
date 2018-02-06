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
    
    let angleConst: CGFloat = 180.0
    let arcStrokeSize: CGFloat = 35.0
    
    // We get this from feed.
    let minValue: CGFloat = 0.0
    let maxValue: CGFloat = 100.0
    let currentValue: String = "55.0"
    
    var centerPoint = CGPoint()
    var startAngle: CGFloat = 180.0
    
    var values: [String] = []
    var colors: [String] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
    }
    
    func showGauge(values: [String], colors: [String]) {
        print("SHOULD BE DRAWN")
        
        self.values = values
        self.colors = colors
    }
    
    override func draw(_ rect: CGRect) {
        print("DRAW")
        
        initialize()
        guard values.count > 0  else {
            return
        }
        
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        let size = min(width, height)
        
        let centerX = width / 2
        let centerY = height / 2 + 3 * size / 8
        
        centerPoint = CGPoint(x: centerX, y: centerY)
        let radius = CGFloat(size / 2)
        
        // Draw first part of the arc from min value to first threshold.
        drawArcPart(left: minValue, right: CGFloat((values[0] as NSString).floatValue), color: UIColor(hexString: colors[0]), radius: radius)
        
        // Draw all thresholds and arcs between them.
        for i in 0..<values.count - 1 {
            drawText(centerX: centerX, centerY: centerY, size: size, value: values[i])
            drawArcPart(left: CGFloat((values[i] as NSString).floatValue), right: CGFloat((values[i + 1] as NSString).floatValue), color: UIColor(hexString: colors[i + 1]), radius: radius)
        }
        
        drawText(centerX: centerX, centerY: centerY, size: size, value: values[values.count - 1])
        
        // Draw last arc part from last value to max value.
        drawArcPart(left: CGFloat((values[values.count - 1] as NSString).floatValue), right: maxValue, color: UIColor(hexString: colors[values.count]), radius: radius)
    
        drawExtremeValues(centerX: centerX, centerY: centerY, size: size)
    }
    
    private func drawArcPart(left: CGFloat, right: CGFloat, color: UIColor, radius: CGFloat) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = arcStrokeSize
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        let sweepAngle = (right - left) / (maxValue - minValue) * angleConst
        
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle.degreesToRadians, endAngle: (startAngle + sweepAngle).degreesToRadians, clockwise: true)
        shapeLayer.path = circlePath.cgPath
        
        self.layer.addSublayer(shapeLayer)
        
        startAngle += sweepAngle
    }
    
    private func drawText(centerX: CGFloat, centerY: CGFloat, size: CGFloat, value: String) {
        let attributes = [NSAttributedStringKey.font            : UIFont.systemFont(ofSize: 10.0),
                          NSAttributedStringKey.foregroundColor : UIColor.gray]
        let attributedString = NSAttributedString(string: value, attributes: attributes)
    
        let lineDistance: CGFloat = size / 2 + arcStrokeSize / 2
        let lineEndX: CGFloat = centerX + lineDistance * cos(startAngle.degreesToRadians)
        let lineEndY: CGFloat = centerY + lineDistance * sin(startAngle.degreesToRadians)
        
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: centerX, y: centerY))
        linePath.addLine(to: CGPoint(x: lineEndX, y: lineEndY))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = linePath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 2.0
        
        self.layer.addSublayer(shapeLayer)
    
        let distance = size / 2 + arcStrokeSize - attributedString.size().height / 2
        let a = centerX + distance * cos(startAngle.degreesToRadians)
        let b = centerY + distance * sin(startAngle.degreesToRadians)
        
        let valueBounds = CGRect(x: a - attributedString.size().width/2, y: b - attributedString.size().height/2, width: attributedString.size().width, height: attributedString.size().height)
        attributedString.draw(in: valueBounds)
    }
    
    private func drawExtremeValues(centerX: CGFloat, centerY: CGFloat, size: CGFloat) {
        let attributes = [NSAttributedStringKey.font            : UIFont.systemFont(ofSize: 10.0),
                          NSAttributedStringKey.foregroundColor : UIColor.gray]
        let minAttributedString = NSAttributedString(string: "\(minValue)", attributes: attributes)
        let maxAttributedString = NSAttributedString(string: "\(maxValue)", attributes: attributes)
        
        let minX: CGFloat = centerX + size / 2 * cos(CGFloat(angleConst).degreesToRadians)
        let minY: CGFloat = centerY + size / 2 * sin(CGFloat(angleConst).degreesToRadians)
        let minBounds = CGRect(x: minX - minAttributedString.size().width / 2, y: minY, width: minAttributedString.size().width, height: minAttributedString.size().height)
        
        let maxX: CGFloat = centerX + size / 2 * cos(CGFloat(2 * angleConst).degreesToRadians)
        let maxY: CGFloat = centerY + size / 2 * sin(CGFloat(2 * angleConst).degreesToRadians)
        let maxBounds = CGRect(x: maxX - maxAttributedString.size().width / 2, y: maxY, width: maxAttributedString.size().width, height: maxAttributedString.size().height)
        
        minAttributedString.draw(in: minBounds)
        maxAttributedString.draw(in: maxBounds)
    }
    
    private func drawMinValue() {
        
    }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
