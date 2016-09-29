//
//  Shake.swift
//  Animation
//
//  Created by Christian Otkjær on 25/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

// MARK: - Shake

public extension UIView
{
    func shake()
    {
        layer.shake()
    }
}


public extension CALayer
{
    func shake(_ duration: Double = 0.4)
    {
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0.0, 0.2, 0.5, 0.8, 1.0]
        animation.duration = duration
        
        animation.isAdditive = true
        
        add(animation, forKey:"shake")
    }
}

