//
//  CALayer.swift
//  Animation
//
//  Created by Christian Otkjær on 09/12/15.
//  Copyright © 2015 Christian Otkjær. All rights reserved.
//

import UIKit
import Easing

internal let π : CGFloat = 3.14159265358979323846264338327950288
internal let π2 : CGFloat = 6.28318530717958647692528676655900576

//MARK: - Animation

private let framesPerSecond = 30.0

public extension CALayer
{
    func animate(_ keyPath: String, byValue delta: CGFloat, duration: Double, timing: TimingFunction, completion : ((Bool) -> ())? = nil)
    {
        if let valueNow = presentation()?.value(forKeyPath: keyPath) as? CGFloat
        {
            animate(keyPath, toValue: valueNow + delta, duration: duration, timing: timing)
        }
    }
    
    func animate(_ keyPath: String, toValue value: CGFloat, duration: Double, timing: TimingFunction, completion : ((Bool) -> ())? = nil)
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

            if let completion = completion
            {
                add(animation: animation, forKey: keyPath + " animation", completionHandler: completion)
            }
            else
            {
                add(animation, forKey: keyPath + " animation")
            }
        }
    }
}

private var animationCompletionHandlers = Set<AnimationCompletionHandler>()

private class AnimationCompletionHandler : NSObject, CAAnimationDelegate
{
    let finished: (Bool) -> ()
    let started: () -> ()
    
    private init(started: @escaping () -> () = { _ in return }, finished: @escaping (Bool) -> ())
    {
        self.started = started
        self.finished = finished
    }
    
    fileprivate static func handler(started: @escaping () -> () = { _ in return }, finished: @escaping (Bool) -> ()) -> AnimationCompletionHandler
    {
        let handler = AnimationCompletionHandler(started: started, finished: finished)
    
        animationCompletionHandlers.insert(handler)
        
        return handler
    }
    
    fileprivate func animationDidStart(_ anim: CAAnimation)
    {
        started()
    }
    
    fileprivate func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
        finished(flag)

        animationCompletionHandlers.remove(self)
    }
}


public extension CALayer
{
    /// Returns an animation from the current value. Set the toValue and add it to the layer.
    internal func animation(forKeyPath keyPath: String, duration: Double) -> CABasicAnimation
    {
        let animation = CABasicAnimation(keyPath: keyPath)

        animation.duration = duration
        animation.fromValue = self.presentation()?.value(forKeyPath: keyPath) ?? self.value(forKeyPath: keyPath)

        return animation
    }
    
    func animate(keyPath: String, to value: CGFloat, duration: Double)
    {
        let anim = animation(forKeyPath: keyPath, duration: duration)
        
        setValue(value, forKeyPath: keyPath)
        
        add(anim, forKey: keyPath + " animation")
    }

    func animate(duration: Double, keyPath: String, to value: AnyObject)
    {
        let anim = animation(forKeyPath: keyPath, duration: duration)
        
        setValue(value, forKeyPath: keyPath)
        
        add(anim, forKey: keyPath + " animation")
    }
    
    func animate(_ value: AnyObject, duration: Double, keyPath: String)
    {
        let anim = animation(forKeyPath: keyPath, duration: duration)

        setValue(value, forKeyPath: keyPath)
        
        add(anim, forKey: keyPath + " animation")
    }
}


public extension CALayer
{
    func add(animation: CAAnimation, forKey: String?, completionHandler : @escaping (Bool) -> ())
    {
        guard let key = forKey else { return completionHandler( false ) }
        
        let handler = AnimationCompletionHandler.handler(finished: completionHandler)
        
        animation.delegate = handler
     
        add(animation, forKey: key)
    }
    
//    func add(animation: CAAnimation, forKey: String?, completion : @escaping (Bool) -> ())
//    {
//        guard let key = forKey else { return completion( false ) }
//        
//        let completionHandler = AnimationCompletionHandler(finished: completion)
//        
//        animation.delegate = completionHandler
//        
////        // Begin the transaction
////        CATransaction.begin()
////        CATransaction.setCompletionBlock(completion)
////        
//        // Do the actual animation and commit the transaction
//        add(animation, forKey: key)
////        CATransaction.commit()
//    }
}
