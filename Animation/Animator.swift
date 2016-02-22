//
//  Animator.swift
//  Animation
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

public class Animator
{
    private static let singletonAnimator = Animator()
    
    public static func animate(
        duration: Double,
        delay: Double = 0,
        timingFunction: TimingFunction = .QuadraticEaseInOut,
        closure: Double -> ()
        )
    {
        animate(duration, delay: delay, timingFunction: timingFunction, closure: closure, completion: nil)
    }
    
    public static func animate(
        duration: Double,
        delay: Double = 0,
        timingFunction: TimingFunction = .QuadraticEaseInOut,
        closure: Double -> (),
        completion: (Bool -> ())? = nil
        )
    {
        singletonAnimator.animate(duration,
            delay: delay,
            timingFunction: timingFunction,
            closure: closure,
            completion: completion )
    }
    
    private func animate(
        duration: Double,
        delay: Double,
        timingFunction: TimingFunction,
        closure: Double -> (),
        completion: (Bool -> ())?
        )
    {
        let animation = Animation(
            duration: duration,
            delay: delay,
            timingFunction: timingFunction,
            closure: closure,
            completion: { self.animations.remove($0); completion?($0.completed)} )
        
        addAnimation(animation)
    }
    
    private var animations = Set<Animation>()

    private func addAnimation(animation: Animation)
    {
        guard !animations.contains(animation) else { debugPrint("already added"); return }
        
        animations.insert(animation)
        
        if animations.contains(animation)
        {
            animation.begin()
        }
        else
        {
            fatalError("Could not start animation")
        }
    }
}