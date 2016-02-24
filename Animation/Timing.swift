//
//  Timing.swift
//  Animation
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//
/*
private let π_2 = M_PI_2

private let π_1_8 = M_PI_4 / 2

private let π_5_8 = π_1_8 * 5
private let π_10_8 = π_1_8 * 10
private let π_11_8 = π_1_8 * 11
private let sin_π_5_8 = sin(π_5_8)
private let sin_π_11_8 = sin(π_11_8)

public enum TimingFunction
{
    case Linear
    case QuadraticEaseIn
    case QuadraticEaseOut
    case QuadraticEaseInOut
    case SineEaseIn
    case SineEaseOut
    case SineEaseInOut
    case Custom(Double -> Double)
    
    public init?(text: String?)
    {
        switch text
        {
        case "Linear"?:
            self = Linear
            
        case "QuadraticEaseIn"?:
            self = QuadraticEaseIn
            
        case "QuadraticEaseOut"?:
            self = QuadraticEaseOut
            
        case "QuadraticEaseInOut"?:
            self = QuadraticEaseInOut
            
        case "SineEaseIn"?:
            self = SineEaseIn
            
        case "SineEaseOut"?:
            self = SineEaseOut
            
        case "SineEaseInOut"?:
            self = SineEaseInOut
            
        default:
            debugPrint("Create function parser")
            return nil
        }
    }
    
    public var function : (Double -> Double)
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

            case .SineEaseIn:
                return { 1 - sin(π_11_8 + $0 * π_5_8) / sin_π_11_8 }
                
            case .SineEaseOut:
                return { t in return sin(t * π_5_8) / sin_π_5_8 }
                
            case .SineEaseInOut:
                return { t in return (1 - sin(π_11_8 + t * π_10_8) / sin_π_11_8 ) / 2 }

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
*/