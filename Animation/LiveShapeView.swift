//
//  ShapeView.swift
//  Animation
//
//  Created by Christian Otkjær on 07/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit

@IBDesignable
open class LiveShapeView: UIView
{
    private let shapeLayer = CAShapeLayer()
    
    open var path : UIBezierPath = UIBezierPath()
    {
        didSet { shapeLayer.path = path.cgPath }
    }
    
    @IBInspectable
    open var fillColor : UIColor? = nil
        { didSet { shapeLayer.fillColor = fillColor?.cgColor } }
    
    @IBInspectable
    open var strokeColor : UIColor? = nil
        { didSet { updateStrokeColor() } }
    
    @IBInspectable
    open var strokeWidth : CGFloat = 0
        { didSet { shapeLayer.lineWidth = strokeWidth } }
    
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
        shapeLayer.fillColor = fillColor?.cgColor
        shapeLayer.lineWidth = strokeWidth
        shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layer.addSublayer(shapeLayer)
        
        updateStrokeColor()
        update()
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
        
        updateStrokeColor()
    }
    
    // MARK: - Layout
    
    override open func layoutSubviews()
    {
        super.layoutSubviews()
        
        shapeLayer.frame = bounds

        update()
    }
    
    // MARK: - Update

    internal func updateStrokeColor()
    {
        shapeLayer.strokeColor = (strokeColor ?? tintColor)?.cgColor
    }
    
    /// Override to update this shape
    open func update()
    {
        
    }
    
    // MARK: - Animation

    public var startTime : Double?

    public var elapsed : Double
    {
        guard let startTime = startTime else { return 0 }
        
        return CACurrentMediaTime() - startTime
    }
    
    public var isAnimating : Bool { return startTime != nil }
    
    private var shouldInvalidateDisplayLinkOnDeinit = false
    
    private lazy var displayLink : CADisplayLink =
        {
            let displayLink = CADisplayLink(target: self, selector: #selector(LiveShapeView.updateLoop))
            displayLink.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
            return displayLink
    }()
    
    func updateLoop(sender: CADisplayLink)
    {
        update()
    }
    
    public func startUpdateLoop()
    {
        guard !isAnimating else { return }
        
        startTime = CACurrentMediaTime()
        shouldInvalidateDisplayLinkOnDeinit = true
        displayLink.isPaused = false
    }
    
    public func stopUpdateLoop()
    {
        displayLink.isPaused = true
        startTime = nil
    }
    
    deinit
    {
        if shouldInvalidateDisplayLinkOnDeinit { displayLink.invalidate() }
    }
}

