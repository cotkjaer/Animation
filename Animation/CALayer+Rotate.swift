//
//  CALayer+Rotate.swift
//  Animation
//
//  Created by Christian Otkjær on 06/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import CoreGraphics

private let CALayerRotationKeyPath = "transform.rotation.z"
private let ContinousRotationAnimationKey = "RotationAnimationKey"

public extension CALayer
{
    private var rot : CGFloat?
    {
        return value(forKeyPath: CALayerRotationKeyPath) as? CGFloat
    }
    
    public var rotation : CGFloat
        {
        get { return presentation()?.rot ?? rot ?? 0 }
        set { setValue(newValue, forKeyPath: CALayerRotationKeyPath) }
    }
    
    public func rotate(
        to radians: CGFloat,
        clockwise: Bool = true,
        duration: Double,
        timingFunctionName: String = kCAMediaTimingFunctionLinear,
        completion : @escaping (Bool) -> ())
    {
        var delta = radians - rotation
        
        while clockwise && delta < 0 { delta += π2 }
        
        while !clockwise && delta > 0 { delta -= π2 }
        
        rotate(by: delta, duration: duration, completion: completion)
    }
    
    public func rotate(
        by deltaAngle: CGFloat,
        duration: Double = 0.1,
        timingFunctionName: String = kCAMediaTimingFunctionLinear,
        completion : @escaping (Bool) -> ())
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
    
    /// begin rotating around anchor point at a given velocity (revolutions pr second) and direction (clock or anticlockwise)
    public func beginRotating(clockwise: Bool = true, speed: Double = 1)
    {
        if animation(forKey: ContinousRotationAnimationKey) != nil
        {
            stopRotating()
        }
        
        guard speed > 0 else { return }
        
        let rotationAnimation = CABasicAnimation(keyPath: CALayerRotationKeyPath)
        rotationAnimation.toValue = rotation + (clockwise ? π2 : -π2)
        rotationAnimation.duration = 1 / speed
        rotationAnimation.repeatCount = Float.infinity
//        rotationAnimation.isRemovedOnCompletion = false
//        rotationAnimation.fillMode = kCAFillModeForwards
        
        add(rotationAnimation, forKey: ContinousRotationAnimationKey)
    }
    
    public func stopRotating()
    {
        removeAnimation(forKey: ContinousRotationAnimationKey)
    }
}
