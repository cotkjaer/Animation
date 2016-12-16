//
//  IndicatorView.swift
//  Animation
//
//  Created by Christian Otkjær on 06/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit

open class IndicatorView: UIView
{
    internal let shapeLayer = CAShapeLayer()
    
    // MARK: - Init
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    override open func awakeFromNib()
    {
        super.awakeFromNib()
        setup()
    }
    
    func setup()
    {
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = tintColor.cgColor
        shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layer.addSublayer(shapeLayer)
        
        updateShapeLayer()
    }
    
    // MARK: - Interface Builder
    
    override open func prepareForInterfaceBuilder()
    {
        setup()
    }
    
    override open var intrinsicContentSize : CGSize
    {
        return CGSize(width: UIViewNoIntrinsicMetric, height:  UIViewNoIntrinsicMetric)
    }
    
    // MARK: - Color
    
    override open func tintColorDidChange()
    {
        super.tintColorDidChange()
        
        shapeLayer.strokeColor = tintColor.cgColor
    }
    
    // MARK: - Path
    
    internal func path(forBounds: CGRect? = nil) -> UIBezierPath?
    {
        return nil
    }
    
    private func updateShapeLayer()
    {
        let diameter = min(bounds.height, bounds.width)
        
        shapeLayer.frame = bounds
        
        shapeLayer.lineWidth = min(5, max(1, diameter / 50))
        
        shapeLayer.path = path(forBounds: bounds)?.cgPath
    }
    
    // MARK: - Layout

    override open func layoutSubviews()
    {
        super.layoutSubviews()
        
        updateShapeLayer()
    }
}
