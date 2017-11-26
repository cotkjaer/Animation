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
    internal var completed = false
    
    fileprivate let createdTime : Double
    
    fileprivate let duration : Double
    fileprivate let delay : Double
    
    fileprivate let closure : (Double) -> ()
    fileprivate let completion : (Animation) -> ()
    
    fileprivate let timingFunction : (Double) -> Double
    
    init(duration: Double = 5,
        delay: Double = 0,
        timingFunction: TimingFunction = TimingFunction(),
        closure: @escaping (Double) -> (),
        completion: @escaping ((Animation) -> ()) = { _ in }
        )
    {
        createdTime = Date.timeIntervalSinceReferenceDate
        
        self.duration = duration
        self.delay = delay
        self.timingFunction = timingFunction.function
        self.closure = closure
        self.completion = completion
    }
    
    fileprivate func wrapUp(_ completed : Bool)
    {
        closure(1)
        self.completed = completed
        completion(self)
    }
    
    @objc func executeAnimation()//(displayLink: CADisplayLink)
    {
        //        guard displayLink == self.displayLink else { return }
        
        let now = Date.timeIntervalSinceReferenceDate
        
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
    
    fileprivate var startTime : Double = Date.distantPast.timeIntervalSinceReferenceDate
    fileprivate var endTime : Double = Date.distantPast.timeIntervalSinceReferenceDate
    fileprivate var displayLink : CADisplayLink?
    
    func begin()
    {
        guard displayLink == nil else { return }
        
        let now = Date.timeIntervalSinceReferenceDate
        
        startTime = max(now, createdTime + delay)
        endTime = startTime + duration
        
        if endTime > startTime + 0.02
        {
            displayLink = CADisplayLink(target: self, selector: #selector(Animation.executeAnimation))
//            displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            
            displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
        }
        else
        {
            wrapUp(true)
        }
    }
}
