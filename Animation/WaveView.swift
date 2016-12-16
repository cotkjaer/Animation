//
//  WaveView.swift
//  Animation
//
//  Created by Christian Otkjær on 07/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit

open class OverlappingWavesView: LiveShapeView
{
    private var waves = Array<Wave>(repeating: Wave(), count: 5)
    
    open override func didMoveToSuperview()
    {
        super.didMoveToSuperview()
        
        startUpdateLoop()
    }
    
    override open func setup()
    {
        super.setup()
        
        layer.mask = CAShapeLayer()
    }
    
    override open func update()
    {
        let time = CGFloat(elapsed)
        
        let bounds = self.bounds.insetBy(dx: strokeWidth/2, dy: strokeWidth/2)
        
        let yOffset = bounds.height / 2
        
        let steps = Int(ceil(bounds.width / 5))
        
        var points = Array<CGPoint>()
        
        for step in 0...steps
        {
            let x = CGFloat(step) * bounds.width / CGFloat(steps)
            
            points.append(CGPoint(x: x, y: yOffset))
        }
        
        for step in 0...steps
        {
            for wave in waves
            {
                let y = wave.offset(forX: points[step].x, atTime: time)
                
                points[step].y += y
            }
        }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))

        for point in points
        {
            path.addLine(to: point)
        }
        
        path.close()
        
        self.path = path
    }
    
    override open func layoutSubviews()
    {
        for index in 0..<waves.endIndex
        {
            waves[index].amplitude = CGFloat.random(lower: bounds.width / 200, upper: bounds.width / 100)
            waves[index].length = CGFloat.random(lower: bounds.width / 10, upper: bounds.width / 2)
            waves[index].speed = CGFloat.random(lower: -0.1, upper: 0.1)
        }
        
        (layer.mask as? CAShapeLayer)?.path = UIBezierPath(rect: bounds).cgPath
        super.layoutSubviews()
    }
}


open class WaveView: LiveShapeView
{
    private var wave : Wave = Wave()
    
    open override func didMoveToSuperview()
    {
        super.didMoveToSuperview()
        
                startUpdateLoop()
    }
    
    override open func setup()
    {
        super.setup()
        
        layer.mask = CAShapeLayer()
        
    }
    
    override open func update()
    {
        let path = UIBezierPath()
        let time = CGFloat(elapsed)
        
        let bounds = self.bounds.insetBy(dx: strokeWidth/2, dy: strokeWidth/2)
        
        let yOffset = bounds.height / 2
        
        path.move(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        
        let steps = Int(ceil(bounds.width / 5))
        
        for step in 0...steps
        {
            let x = CGFloat(step) * bounds.width / CGFloat(steps)
            
            let y = yOffset + wave.offset(forX: x, atTime: time)
            
            path.addLine(to: CGPoint(x: x, y : y))
        }
        
        path.close()
        
        self.path = path
    }
    
    override open func layoutSubviews()
    {
        wave.amplitude = CGFloat.random(lower: bounds.width / 100, upper: bounds.width / 50)
        wave.length = CGFloat.random(lower: bounds.width / 10, upper: bounds.width / 4)
        
        (layer.mask as? CAShapeLayer)?.path = UIBezierPath(rect: bounds).cgPath
        super.layoutSubviews()
    }
}

