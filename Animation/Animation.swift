//
//  Animation.swift
//  Animation
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

protocol AnimationDelegate
{
    func animationDidFinish(animation: Animation)
}

internal class Animation : NSObject
{
    internal var delegate : AnimationDelegate?
    
    private var createdTime : Double
    
    private var duration : Double
    private var delay : Double
    
    private var closure : (Double -> ())
    private var timingFunction : TimingFunction
    
    init(duration: Double = 5, delay: Double = 0, timingFunction: TimingFunction = TimingFunction.QuadraticEaseInOut, closure: Double -> ())
    {
        createdTime = NSDate.timeIntervalSinceReferenceDate()
        
        self.duration = duration
        self.delay = delay
        self.closure = closure
        self.timingFunction = timingFunction
    }
    
    func executeAnimation()//(displayLink: CADisplayLink)
    {
        //        guard displayLink == self.displayLink else { return }
        
        let now = NSDate.timeIntervalSinceReferenceDate()
        
        if now > endTime
        {
            self.displayLink?.invalidate()
            self.displayLink = nil
            closure(1)
        }
        else if now >= startTime
        {
            let rawT = (now - startTime) / (endTime - startTime)
            
            let t = timingFunction.function(rawT)
            
            closure(t)
            
            delegate?.animationDidFinish(self)
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
            displayLink = CADisplayLink(target: self, selector: Selector("executeAnimation"))
//            displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            
            displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        }
        else
        {
            closure(1)
            delegate?.animationDidFinish(self)
        }
    }
}


//MARK: - Hashable

//func == (lhs: Animation, rhs:Animation) -> Bool
//{
//    return lhs.hashValue == rhs.hashValue
//}
