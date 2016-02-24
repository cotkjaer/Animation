//
//  UIView.swift
//  Animation
//
//  Created by Christian Otkjær on 24/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Easing

// MARK: - Animation

// MARK: - <#comment#>

extension UIViewAnimationOptions
{
    var keyframeOptions : UIViewKeyframeAnimationOptions
        {
        return UIViewKeyframeAnimationOptions(rawValue: rawValue)
    }
}


public extension UIView
{
    /**
     Animation with the given timing function
     */
    static func animate(
        duration duration: Double,
        delay: Double = 0,
        timing: TimingFunction,
//        options: UIViewAnimationOptions = [],
        animations: Double -> (),
        completion: (Bool -> ())? = nil)
    {
        let keyframeOptions = UIViewKeyframeAnimationOptions.CalculationModeCubicPaced
       
        //TODO: transfer other options
        
        let framesPerSecond = 30.0
        
        let frames = ceil(framesPerSecond * duration)
        
        let function = timing.function
        
        animations(0)
        
        animateKeyframesWithDuration(duration,
            delay: delay,
            options: keyframeOptions, animations:
            {
                for frame in 0.0.stride(through: frames, by: 1)
                {
                    UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0, animations: {
                        animations(function(frame / frames))
                    })
                }
            },
            completion: completion)
    }
}
