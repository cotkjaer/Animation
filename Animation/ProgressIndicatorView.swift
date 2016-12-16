//
//  ProgressIndicatorView.swift
//  Animation
//
//  Created by Christian Otkjær on 06/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit

@IBDesignable
open class ProgressIndicatorView: IndicatorView
{
    override func setup()
    {
        progress = 0
        
        super.setup()
    }
    
    // MARK: - Interface Builder
    
    override open var intrinsicContentSize: CGSize
    {
        return CGSize(width: 60, height: 60)
    }
    
    // MARK: - progress
    
    /// Progress should be in [0;1]
    @IBInspectable
    open var progress : CGFloat
        {
        get { return shapeLayer.strokeEnd }
        set { shapeLayer.strokeEnd = min(1, max(0, newValue)) }
    }
    
    override open func tintColorDidChange()
    {
        super.tintColorDidChange()
        
        shapeLayer.strokeColor = tintColor.cgColor
    }
    
    // MARK: - Layout
    
    override func path(forBounds: CGRect?) -> UIBezierPath?
    {
        let bounds = forBounds ?? self.bounds
        
        let radius = (min(bounds.height, bounds.width) - shapeLayer.lineWidth) / 2
        
        return UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: radius, startAngle: -π/2, endAngle: 3*π/2, clockwise: true)
    }
}
