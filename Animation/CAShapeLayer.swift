//
//  CAShapeLayer.swift
//  Animation
//
//  Created by Christian Otkjær on 09/12/15.
//  Copyright © 2015 Christian Otkjær. All rights reserved.
//

import UIKit

//MARK: - Animation

extension CAShapeLayer
{
    public func animateLineWidthTo(width: CGFloat, duration: Double = 0.1)
    {
        animate(width, duration: duration, keyPath: "lineWidth")
    }
    
    public func animateStrokeEndTo(strokeEnd: CGFloat, duration: Double = 0.1)
    {
        animate(strokeEnd, duration: duration, keyPath: "strokeEnd")
    }
    
    public func animateStrokeStartTo(strokeStart: CGFloat, duration: Double = 0.1)
    {
        animate(strokeStart, duration: duration, keyPath: "strokeStart")
    }
    
    public func animatePathTo(path: CGPath, duration: Double = 0.1)
    {
        animate(path, duration: duration, keyPath: "path")
    }
    
}
