//
//  Animation.swift
//  Animation
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Easing

internal class Animation : NSObject
{
//    internal var delegate : AnimationDelegate?
    
    internal var completed = false
    
    private let createdTime : Double
    
    private let duration : Double
    private let delay : Double
    
    private let closure : Double -> ()
    private let completion : Animation -> ()
    
    private let timingFunction : Double -> Double
    
    init(duration: Double = 5,
        delay: Double = 0,
        timingFunction: TimingFunction = TimingFunction(),
        closure: Double -> (),
        completion: (Animation -> ()) = { _ in }
        )
    {
        createdTime = NSDate.timeIntervalSinceReferenceDate()
        
        self.duration = duration
        self.delay = delay
        self.timingFunction = timingFunction.function
        self.closure = closure
        self.completion = completion
    }
    
    private func wrapUp(completed : Bool)
    {
        closure(1)
        self.completed = completed
        completion(self)
    }
    
    func executeAnimation()//(displayLink: CADisplayLink)
    {
        //        guard displayLink == self.displayLink else { return }
        
        let now = NSDate.timeIntervalSinceReferenceDate()
        
        if now > endTime
        {
            self.displayLink?.invalidate()
            self.displayLink = nil
            
            wrapUp(true)
        }
        else if now >= startTime
        {
            closure(timingFunction((now - startTime) / (endTime - startTime)))
        }
    }
    
    private var startTime : Double = NSDate.distantPast().timeIntervalSinceReferenceDate
    private var endTime : Double = NSDate.distantPast().timeIntervalSinceReferenceDate
    private var displayLink : CADisplayLink?
    
    func begin()
    {
        guard displayLink == nil else { return }
        
        let now = NSDate.timeIntervalSinceReferenceDate()
        
        startTime = max(now, createdTime + delay)
        endTime = startTime + duration
        
        if endTime > startTime + 0.02
        {
            displayLink = CADisplayLink(target: self, selector: #selector(Animation.executeAnimation))
//            displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            
            displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        }
        else
        {
            wrapUp(true)
        }
    }
}


//MARK: - Hashable

//func == (lhs: Animation, rhs:Animation) -> Bool
//{
//    return lhs.hashValue == rhs.hashValue
//}
