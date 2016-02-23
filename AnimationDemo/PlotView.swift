//
//  PoltView.swift
//  Animation
//
//  Created by Christian Otkjær on 23/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit

class PlotView: UIView
{
    var functions = Array<(UIColor, Double->Double)>()
    
//    var function : (Double -> Double)?
//        {
//        didSet { setNeedsDisplay() }
//    }
    

    override func drawRect(rect: CGRect)
    {
        for (color, function) in functions
        {
            var values = Array<Double>()
            
            let width = Double(bounds.width) / 2
            
            for t in Double(0).stride(through: width, by: 1)
            {
                values.append(function(t/width))
            }
            
//            let maxF = values.reduce(-Double.infinity, combine: { max($0, $1) })
//            let minF = values.reduce(Double.infinity, combine: { min($0, $1) })
            
//            let height = width / (maxF - minF)
            
            let path = UIBezierPath()
            
            
            let offset = width / 2
            
            path.moveToPoint(CGPoint(x: offset + 0, y: offset + (1 - values[0]) * width))
            
            for (i, v) in values.enumerate()
            {
                path.addLineToPoint(CGPoint(x: offset +  Double(i), y: offset + (1 - v) * width))
            }
            
            path.lineWidth = 1
            color.setStroke()
            
            path.stroke()
        }
    }
}
