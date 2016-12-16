//
//  IdentityTransform.swift
//  Animation
//
//  Created by Christian Otkjær on 06/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Foundation


// MARK: - Identity

extension CATransform3D
{
    /// Identity transformation that is oriented upwards - rather than the standard which is oriented to the right
    public static let Identity : CATransform3D =
    {
        var transform = CATransform3DIdentity
        transform.m34 = CGFloat(1.0 / -500.0)
        transform = CATransform3DRotate(transform, -π/2, 0.0, 0.0, 1.0)
        return transform
    }()
}
