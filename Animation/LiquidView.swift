//
//  LiquidView.swift
//  Animation
//
//  Created by Christian Otkjær on 06/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit


private let CALayerPathKeyPath = "path"
private let ContinousUndulationAnimationKey = "PathAnimationKey"

@IBDesignable
open class LiquidView: UIView
{
    @IBInspectable
    open var liquidColor : UIColor = UIColor.red.withAlphaComponent(0.3)

    @IBInspectable
    open var borderColor : UIColor = UIColor.clear//.withAlphaComponent(0.9)
    
    @IBInspectable
    open var progress : CGFloat = 0
        { didSet{ setNeedsDisplay() } }
    private let shapeLayer = CAShapeLayer()
    
    @IBInspectable
    open var leftStartsUp : Bool = true
    
    @IBInspectable
    open var velocity : Double = 1
    
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
        factor = leftStartsUp ? 1 : 0
        
        shapeLayer.lineWidth = 3
        shapeLayer.fillColor = liquidColor.cgColor
        shapeLayer.strokeColor = borderColor.cgColor
        shapeLayer.actions = ["path" : NSNull()]
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
    
    /// begin undulating at a given velocity (reverseals pr second)
    public func beginUndulating(speed: Double = 1)
    {
        if shapeLayer.animation(forKey: ContinousUndulationAnimationKey) != nil
        {
    //        stopUndulating()
        }
        
        guard speed > 0 else { return }
        
        let pathAnimation = CABasicAnimation(keyPath: CALayerPathKeyPath)
        pathAnimation.toValue = path()?.cgPath
        pathAnimation.duration = 1 / velocity
        
//        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut) // animation curve is Ease Out
//        pathAnimation.fillMode = kCAFillModeBoth // keep to value after finishing
//        pathAnimation.isRemovedOnCompletion = false // don't remove after finishing
//
//        pathAnimation.repeatCount = Float.infinity
        pathAnimation.autoreverses = true
        //        rotationAnimation.isRemovedOnCompletion = false
        //        rotationAnimation.fillMode = kCAFillModeForwards
        
        pathAnimation.delegate = self
        
        shapeLayer.add(pathAnimation, forKey: ContinousUndulationAnimationKey)
    }
    
    public func stopUndulating()
    {
        shapeLayer.removeAnimation(forKey: ContinousUndulationAnimationKey)
    }
    
    // MARK: - Path
    
    private var factor : CGFloat = 1
    
    internal func path(forBounds: CGRect? = nil) -> UIBezierPath?
    {
        let bounds = forBounds ?? self.bounds
        
        let inset = shapeLayer.lineWidth / 2
        let b = bounds.insetBy(dx: inset, dy: inset)
        
        let offset = min(b.width / 10, b.height / 3)
        
        let y = min(b.height, max(0, progress * b.height))
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: b.maxX, y: b.maxY))
        
        path.addLine(to: CGPoint(x: b.maxX, y: b.maxY - y))
        
        if progress <= 0 || progress >= 1
        {
            path.addLine(to: CGPoint(x: b.minX, y: b.maxY - y))
        }
        else
        {
            let ctrlPoint2 = CGPoint.random(inRect: CGRect(x: b.minX + b.width / 6, y: (b.maxY - y) -  offset / 2, width: b.width / 6, height: offset))
            
            //CGPoint(x: randomNumber() * (b.midX + b.maxX) / 2, y: (b.maxY - y) - factor * offset * randomNumber())

            factor = (factor + 1).truncatingRemainder(dividingBy: 2)

            let ctrlPoint1 = CGPoint.random(inRect: CGRect(x: b.maxX - b.width / 3, y: (b.maxY - y) - offset / 2, width: b.width / 6, height: offset))
                //CGPoint(x: randomNumber() *  (b.midX + b.minX) / 2, y: (b.maxY - y) + factor * offset * randomNumber())
            
            path.addCurve(to: CGPoint(x: b.minX, y: b.maxY - y), controlPoint1: ctrlPoint1, controlPoint2: ctrlPoint2)
            
        }
        
        path.addLine(to: CGPoint(x: b.minX, y: b.maxY))
        
        path.close()
        
        return path
    }
    
    private func updateShapeLayer()
    {
//        let diameter = min(bounds.height, bounds.width)
        
        shapeLayer.frame = bounds
        
        shapeLayer.lineWidth = 2 //min(5, max(1, diameter / 50))
        
        shapeLayer.path = path(forBounds: bounds)?.cgPath
    }
    
    // MARK: - Layout
    
    override open func layoutSubviews()
    {
        super.layoutSubviews()
        
        updateShapeLayer()
    }
    
//    // MARK: - Test
//    
//    o1verride func draw(_ rect: CGRect)
//    {
//        
//    }
}

// MARK: - <#comment#>

extension LiquidView : CAAnimationDelegate
{
    public func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
        beginUndulating()
    }
}


