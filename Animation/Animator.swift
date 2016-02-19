//
//  Animator.swift
//  Animation
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

public class Animator : AnimationDelegate
{
    private static let singletonAnimator = Animator()
    
    public static func animate(duration: Double, delay: Double = 0, timingFunction: TimingFunction = TimingFunction.QuadraticEaseInOut, closure: Double -> ())
    {
        let animation = Animation(duration: duration, delay: delay, timingFunction: timingFunction, closure: closure)

        singletonAnimator.addAnimation(animation)
    }
    
    private var animations = Set<Animation>()

    private func addAnimation(animation: Animation)
    {
        guard !animations.contains(animation) else { debugPrint("already added"); return }
        
        animation.delegate = self
        
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
    
    func animationDidFinish(animation: Animation)
    {
        animations.remove(animation)
    }
}