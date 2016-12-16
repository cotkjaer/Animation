//
//  CGFloat.swift
//  Animation
//
//  Created by Christian Otkjær on 06/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Foundation

// MARK: - Random

extension CGFloat
{
    public static func random() -> CGFloat
    {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    public static func random(lower: CGFloat, upper: CGFloat) -> CGFloat
    {
        let t = random()
        
        //LERP
        return lower * (1 - t) + upper * t
    }
}
