//
//  Timing.swift
//  Animation
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

public enum TimingFunction
{
    case Linear
    case QuadraticEaseIn
    case QuadraticEaseOut
    case QuadraticEaseInOut
    case Custom(Double -> Double)
    
    var function : (Double -> Double)
        {
            switch self
            {
            case Linear:
                return { p in return p }
                
            case .QuadraticEaseOut:
                return { p in return -(p * (p - 2)) }
                
            case .QuadraticEaseIn:
                return { $0 * $0 }
                
            case .QuadraticEaseInOut:
                return { p in
                    if p < 0.5
                    {
                        return 2 * p * p
                    }
                    else
                    {
                        return (-2 * p * p) + (4 * p) - 1
                    }
                }
                
            case .Custom(let f):
                return f
            }
    }
    
    /*
    // Modeled after the line y = x
    public func LinearInterpolation(p: Double) -> Double
    {
    return p
    }
    
    // Modeled after the parabola y = x^2
    public func QuadraticEaseIn(p: Double) -> Double
    {
    return p * p
    }
    
    // Modeled after the parabola y = -x^2 + 2x
    public func QuadraticEaseOut(p: Double) -> Double
    {
    return -(p * (p - 2))
    }
    
    // Modeled after the piecewise quadratic
    // y = (1/2)((2x)^2)              [0, 0.5)
    // y = -(1/2)((2x-1)*(2x-3) - 1)  [0.5, 1]
    public func QuadraticEaseInOut(p: Double) -> Double
    {
    if(p < 0.5)
    {
    return 2 * p * p
    }
    else
    {
    return (-2 * p * p) + (4 * p) - 1
    }
    }
    */
}