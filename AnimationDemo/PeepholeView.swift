//
//  PeepholeView.swift
//  Animation
//
//  Created by Christian Otkjær on 06/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit

@IBDesignable
open class PeepholeView: UIView
{
    @IBInspectable
    open var borderWidth : CGFloat = 2
    
    @IBInspectable
    open var borderColor : UIColor = .black
    
    open override func layoutSubviews()
    {
        super.layoutSubviews()
        
        setNeedsDisplay()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override open func draw(_ rect: CGRect)
    {
        let clipPath = UIBezierPath(rect:CGRect.infinite)
        
        let radius = (min(bounds.width, bounds.height) - borderWidth ) / 2
        
        let holePath = UIBezierPath(arcCenter: CGPoint(x:bounds.midX, y: bounds.midY), radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        holePath.close()
        
        let boundsPath = UIBezierPath(rect: bounds)
        
        clipPath.append(holePath)
        clipPath.usesEvenOddFillRule = true
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.saveGState()
        
        clipPath.addClip()
        
        superview?.backgroundColor?.setFill()
        boundsPath.fill()
        
        holePath.lineWidth = borderWidth
        borderColor.setStroke()
        holePath.stroke()
        
        context.restoreGState()
    }
    
}
