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
    public func animate(lineWidthTo width: CGFloat, duration: Double = 0.1)
    {
        let kp = #keyPath(CAShapeLayer.lineWidth)
        animate(keyPath: kp, to: width, duration: duration)
    }
    
    public func animate(strokeEndTo strokeEnd: CGFloat, duration: Double = 0.1)
    {
        let kp = #keyPath(CAShapeLayer.strokeEnd)
        animate(keyPath: kp, to: strokeEnd, duration: duration)
    }
    
    public func animate(strokeStartTo strokeStart: CGFloat, duration: Double = 0.1)
    {
        let kp = #keyPath(CAShapeLayer.strokeStart)
        animate(keyPath: kp, to: strokeStart, duration: duration)
    }
    
    public func animate(pathTo path: CGPath, duration: Double = 0.1)
    {
        let keyPath = #keyPath(CAShapeLayer.path)
        
        let animation = CABasicAnimation(keyPath: keyPath)
        
        animation.duration = duration
        animation.fromValue = self.value(forKeyPath: keyPath)
        
        setValue(path, forKeyPath: keyPath)
        
        add(animation, forKey: keyPath + " animation")
    }
    
}
