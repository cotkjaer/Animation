//
//  ActivityIndicatorView.swift
//  Animation
//
//  Created by Christian Otkjær on 06/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit

@IBDesignable
open class ActivityIndicatorView: IndicatorView
{
    // MARK: - Animating
    
    open func startAnimating()
    {
        shapeLayer.beginRotating(clockwise: true, speed: 1.0 / 3.0)
    }
    
    open func stopAnimating()
    {
        shapeLayer.stopRotating()
    }
    
    // MARK: - Layout
    
    override func path(forBounds: CGRect?) -> UIBezierPath?
    {
        let bounds = forBounds ?? self.bounds
        
        let radius = (min(bounds.height, bounds.width) - shapeLayer.lineWidth) / 2

        return UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: radius, startAngle: -π/2 + π/16, endAngle: 3*π/2 - π/16, clockwise: true)
    }
}
