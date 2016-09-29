//
//  Animator.swift
//  Animation
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Easing

open class Animator
{
    fileprivate static let singletonAnimator = Animator()
    
    open static func animate(
        duration: Double,
        delay: Double = 0,
        timingFunction: TimingFunction = TimingFunction(),
        closure: @escaping (Double) -> (),
        completion: @escaping (Bool) -> () = { _ in return }
        )
    {
        singletonAnimator.animate(
            duration: duration,
            delay: delay,
            timingFunction: timingFunction,
            closure: closure,
            completion: completion)
    }
    
    fileprivate func animate(
        duration: Double,
        delay: Double,
        timingFunction: TimingFunction,
        closure: @escaping (Double) -> (),
        completion: @escaping (Bool) -> ()
        )
    {
        let animation = Animation(
            duration: duration,
            delay: delay,
            timingFunction: timingFunction,
            closure: closure,
            completion: { self.animations.remove($0); completion($0.completed) } )
        
        addAnimation(animation)
    }
    
    fileprivate var animations = Set<Animation>()

    fileprivate func addAnimation(_ animation: Animation)
    {
        guard !animations.contains(animation) else { debugPrint("already added"); return }
        
        animations.insert(animation)
        
        guard animations.contains(animation) else { fatalError("Could not start animation") }
        
        animation.begin()
    }
}
