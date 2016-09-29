//
//  CALayer.swift
//  Animation
//
//  Created by Christian Otkjær on 09/12/15.
//  Copyright © 2015 Christian Otkjær. All rights reserved.
//

import UIKit
import Easing

private let π2 : CGFloat = 6.28318530717958647692528676655900576

//MARK: - Animation

private let framesPerSecond = 30.0

public extension CALayer
{
    func animate(_ keyPath: String, byValue delta: CGFloat, duration: Double, timing: TimingFunction)
    {
        if let valueNow = presentation()?.value(forKeyPath: keyPath) as? CGFloat
        {
            animate(keyPath, toValue: valueNow + delta, duration: duration, timing: timing)
        }
    }
    
    func animate(_ keyPath: String, toValue value: CGFloat, duration: Double, timing: TimingFunction)
    {
        if let valueNow = presentation()?.value(forKeyPath: keyPath) as? CGFloat
        {
            let frames = ceil(duration * framesPerSecond)

            func lerp(_ factor: Double) -> CGFloat
            {
                let t = CGFloat(timing.function(factor / frames))
                
                return valueNow * CGFloat(1 - t) + value * t
            }

            let animation = CAKeyframeAnimation(keyPath: keyPath)
            
            animation.values = stride(from: 0.0, through: frames, by: 1).map(lerp)
            
            animation.calculationMode = kCAAnimationCubicPaced
            animation.duration = duration
        
            setValue(value, forKeyPath: keyPath)

            add(animation, forKey: keyPath + " animation")
        }
    }
}


public extension CALayer
{
    private func animationFor(keyPath: String, duration: Double) -> CABasicAnimation
    {
        let animation = CABasicAnimation(keyPath: keyPath)
        
        animation.duration = duration
        animation.fromValue = self.value(forKeyPath: keyPath)

        return animation
    }
    
    func animate(keyPath: String, to value: CGFloat, duration: Double)
    {
        let animation = animationFor(keyPath: keyPath, duration: duration)
        
        setValue(value, forKeyPath: keyPath)
        
        add(animation, forKey: keyPath + " animation")
    }

    func animate(duration: Double, keyPath: String, to value: AnyObject)
    {
        let animation = animationFor(keyPath: keyPath, duration: duration)
        
        setValue(value, forKeyPath: keyPath)
        
        add(animation, forKey: keyPath + " animation")
    }

    
    func animate(_ value: AnyObject, duration: Double, keyPath: String)
    {
        let animation = animationFor(keyPath: keyPath, duration: duration)

        setValue(value, forKeyPath: keyPath)
        
        add(animation, forKey: keyPath + " animation")
    }
}

//MARK: - Rotation

private let CALayerRotationKeyPath = "transform.rotation.z"

public extension CALayer
{
    //TODO: Move to non-animation framework
    public var rotation : CGFloat
        {
        get { return value(forKeyPath: CALayerRotationKeyPath) as? CGFloat ?? 0 }
        set { setValue(newValue, forKeyPath: CALayerRotationKeyPath) }
    }
    
    func animateRotationTo(
        _ angle: CGFloat,
        clockwise: Bool = true,
        duration: Double)
    {
        var delta = angle - rotation
        
        while clockwise && delta < 0 { delta += π2 }
        
        while !clockwise && delta > 0 { delta -= π2 }
        
        animateRotateBy(delta, duration: duration)
    }
    
    func animateRotateBy(
        _ deltaAngle: CGFloat,
        duration: Double = 0.1,
        timingFunctionName: String = kCAMediaTimingFunctionLinear)
    {
        if let currentRotation = value(forKeyPath: CALayerRotationKeyPath) as? CGFloat
        {
            let animation = CAKeyframeAnimation(keyPath: CALayerRotationKeyPath)
            
            animation.duration = duration
            
            animation.fillMode = kCAFillModeForwards
            
            animation.calculationMode = kCAAnimationPaced
            
            animation.values =
                [
                currentRotation,
                currentRotation + deltaAngle * 0.3333333333,
                currentRotation + deltaAngle * 0.6666666667,
                currentRotation + deltaAngle
            ]
            
            var timingFunctions = Array<String>(repeating: kCAMediaTimingFunctionLinear, count: 3)
            
            switch timingFunctionName
            {
            case kCAMediaTimingFunctionEaseIn:
                timingFunctions[0] = kCAMediaTimingFunctionEaseIn
                
            case kCAMediaTimingFunctionEaseInEaseOut:
                timingFunctions[0] = kCAMediaTimingFunctionEaseIn
                timingFunctions[2] = kCAMediaTimingFunctionEaseOut
                
            case kCAMediaTimingFunctionEaseOut:
                timingFunctions[2] = kCAMediaTimingFunctionEaseOut
                
            default:
                break
            }
            
            animation.timingFunctions = timingFunctions.map { CAMediaTimingFunction(name: $0) }
            
            setValue(currentRotation + deltaAngle, forKeyPath: CALayerRotationKeyPath)
            add(animation, forKey:CALayerRotationKeyPath)
        }
    }
}
