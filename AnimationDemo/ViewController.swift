//
//  ViewController.swift
//  AnimationDemo
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Animation
import Easing

private let π_2 = CGFloat.pi/2

extension Double
{
    func format(_ f: String = "") -> String
    {
        return String(format: "%\(f)f", self)
    }
}

class ViewController: UIViewController
{
    @IBOutlet weak var label: UILabel?
    @IBOutlet weak var durationTextField: UITextField!
    
    @IBOutlet weak var redBox: UIView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func beginAnimating(_ button: UIButton)
    {
        button.isEnabled = false
        
        var counter = 0
        
        let duration = Double(durationTextField.text ?? "0") ?? 0
        let delay = 0.1
//        let options = UIViewAnimationOptions.allowAnimatedContent
        
        let l = CGFloat(50)
        
        if let redBox = self.redBox, let bounds = redBox.superview?.bounds
        {
            button.layer.animate("transform.rotation.z", byValue: π_2, duration: duration, timing: timingFunction)
            
            UIView.animate(
                withDuration: duration,
                delay: delay,
                timing: timingFunction,
//                options: options,
                animations: {
                    
                    let t = CGFloat($0)
                    
                    let s = l + t * l
                    
                    redBox.frame = CGRect(x: (bounds.width - l * 2) * t, y: bounds.midY - s / 2, width: s, height: s)
                },
                completion: { completed in
                    button.isEnabled = completed
            })
        }

        Animator.animate(duration: duration,
            delay: delay,
            timingFunction: timingFunction,
            closure:
            {
                self.label?.text = String(format: "%.03f", $0)
                counter += 1
            }) { (completed) -> () in
                button.isEnabled = completed
        }

    }
    
    var timingFunction = TimingFunction()
    
    let curves : Array<EasingCurve> =
    [
        .linear, // 0
        .quadratic,
        .cubic,
        .quartic,
        .quintic,
        .sine, // 5
        .circular,
        .exponential,
        .overshootingCubic,
        .elastic,
        .bounce
    ]
    
    func handleChange(_ index: Int, closure: (EasingCurve?)->())
    {
        if index < 0 || index >= curves.count
        {
            closure(nil)
        }
        else
        {
            closure(curves[index])
        }
    }
    
    @IBAction func handleEaseInChange(_ sender: UISegmentedControl)
    {
        handleChange(sender.selectedSegmentIndex) {
            timingFunction.easeIn = $0
        }
    }
    
    
    @IBAction func handleEaseOutChange(_ sender: UISegmentedControl)
    {
        handleChange(sender.selectedSegmentIndex) {
            timingFunction.easeOut = $0
        }
    }
    
}

