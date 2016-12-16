//
//  CGPoint.swift
//  Animation
//
//  Created by Christian Otkjær on 06/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Foundation

// MARK: - Random

extension CGPoint
{
    public static func random(inRect rect: CGRect) -> CGPoint
    {
        return CGPoint(x: rect.minX + rect.width * CGFloat.random(), y: rect.minY + rect.height * CGFloat.random())
    }
}
