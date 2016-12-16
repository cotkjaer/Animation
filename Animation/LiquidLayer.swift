//
//  LiquidLayer.swift
//  Animation
//
//  Created by Christian Otkjær on 06/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import Foundation

///A layer representing an undulating 2d-liquid surface

private class Surface
{
    var width : CGFloat
    
    var points : [SurfacePoint] = []
    
    var waves : [Wave] = []
    
    init(width: CGFloat, numberOfWaves: Int)
    {
        self.width = abs(width)
        
        guard self.width > 0 else { return }
        
        let numberOfPoints = Int(ceil(width / 8)) + 1
        
        for i in 0...numberOfPoints
        {
            let point = SurfacePoint()
            point.position = CGPoint(x: CGFloat(i) * width / CGFloat(numberOfPoints), y: 0)
            points.append(point)
            
            switch i
            {
            case 0:
                break
                
            case numberOfPoints:
                point.rightNeighbour = points[0]
                
            default:
                point.leftNeighbour = points[i-1]
            }
        }
        
        for _ in 0..<numberOfWaves
        {
            let wave = Wave(amplitude: CGFloat.random() * width / 100,
                 length: CGFloat.random() * width / 100,
                 speed: 0,
                 offset: CGFloat.random() * 2 * CGFloat.pi)
            
            waves.append(wave)
        }
    }
}

// Spring constant for forces applied by adjacent points
var SPRING_CONSTANT : CGFloat = 0.005
// Sprint constant for force applied to baseline
var SPRING_CONSTANT_BASELINE : CGFloat = 0.005
//// Vertical draw offset of simulation
//var Y_OFFSET = 200

// Damping to apply to speed changes
var  DAMPING : CGFloat = 0.99
// Number of iterations of point-influences-point to do on wave per step
// (this makes the waves animate faster)
var ITERATIONS = 5

private class SurfacePoint
{
    var position : CGPoint = CGPoint.zero // Position
    var velocity : CGFloat = 0 // Vertical velocity
    var acceleration : CGFloat = 0 // Vertical acceleration
    var mass : CGFloat = 1 // Mass of the point
    
    var leftNeighbour : SurfacePoint? = nil
        {
            didSet
            {
                if leftNeighbour?.rightNeighbour !== self
                {
                    leftNeighbour?.rightNeighbour = self
                }
        }
    }
    var rightNeighbour : SurfacePoint? = nil
        {
        didSet
        {
            if rightNeighbour?.leftNeighbour !== self
            {
                rightNeighbour?.leftNeighbour = self
            }
        }
    }
    private func forceFrom(neighbour: SurfacePoint?) -> CGFloat
    {
        guard let neighbour = neighbour else { return 0 }
        
        let dy = (neighbour.position.y - position.y)

        return SPRING_CONSTANT * dy
    }
    
    func update()
    {
        // forces caused by the point immediately to the left
        let forceFromLeft = forceFrom(neighbour: leftNeighbour)
        // and the right
        let forceFromRight = forceFrom(neighbour: rightNeighbour)
        
        // force toward the baseline
        let dy = -position.y
        let forceToBaseline = SPRING_CONSTANT_BASELINE * dy
        
        // force to apply to this point
        let force = forceFromLeft + forceFromRight + forceToBaseline
        
        // Acceleration
        let acceleration = force / mass
        
        // Apply acceleration (with damping)
        velocity = DAMPING * velocity + acceleration
        
        // Apply speed
        position.y += velocity
    }
}

var NUM_BACKGROUND_WAVES = 7

private let BACKGROUND_WAVE_MAX_HEIGHT : CGFloat = 6
private let BACKGROUND_WAVE_MAX_LENGTH : CGFloat = 10

internal struct Wave
{
    /// Height in points - multiplied to sin() to get the actual vertical offset
    var amplitude : CGFloat = 10
    
    /// Wavelength in points pr cycle. T (time) is divided by this before sin() is applied
    var length: CGFloat = 100
    
    /// Speed the wave undulates, in cycles pr second.
    var speed: CGFloat = 0.1
    
    /// Horizontal offset, measured in points
    var offset : CGFloat = 0
    
    func offset(forX x: CGFloat, atTime t: CGFloat) -> CGFloat
    {
        let actualX = (offset + x) / length
        
        let actualTime = t * speed
        
        return amplitude * sin(π2 * (actualX + actualTime))
    }
}

open class SingleWaveView : UIView
{
    private let wave = Wave()
    private let waveLayer = CAShapeLayer()
    
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
}


open class LiquidLayer: CALayer
{
    private var points : [SurfacePoint] = []
    
    // Resolution of simulation
    var NUM_POINTS = 80
    // Width of simulation
    var WIDTH = 600
    // Spring constant for forces applied by adjacent points
    var SPRING_CONSTANT = 0.005
    // Sprint constant for force applied to baseline
    var SPRING_CONSTANT_BASELINE = 0.005
    // Vertical draw offset of simulation
    var Y_OFFSET = 200
    // Damping to apply to speed changes
    var  DAMPING = 0.99
    // Number of iterations of point-influences-point to do on wave per step
    // (this makes the waves animate faster)
    var ITERATIONS = 5
    
    private let shapeLayer = CAShapeLayer()
    
    override init()
    {
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
