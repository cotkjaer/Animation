//
//  PlotViewController.swift
//  Animation
//
//  Created by Christian Otkjær on 23/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Animation

class PlotViewController: UIViewController
{
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var plotView: PlotView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    let colorsAndFunctions = Array<(UIColor, TimingFunction)>(
    //        arrayLiteral:
    //        (UIColor.redColor(), TimingFunction.Linear),
    //        (UIColor.grayColor(), TimingFunction.QuadraticEaseIn),
    //        (UIColor.blueColor(), TimingFunction.QuadraticEaseInOut),
    //        (UIColor.cyanColor(), TimingFunction.QuadraticEaseOut),
    //        (UIColor.orangeColor(), TimingFunction.SineEaseIn),
    //        (UIColor.purpleColor(), TimingFunction.SineEaseInOut),
    //        (UIColor.greenColor(), TimingFunction.SineEaseOut),
    //        (UIColor.yellowColor(), TimingFunction.Custom({ $0 }))
    //    )
    //
    @IBAction func handleButton(button: UIButton)
    {
        button.selected = !button.selected
        
        if let function = TimingFunction(text: button.titleForState(.Normal))
            
        {
            let color = button.tintColor

            if button.selected
            {
                plotView?.functions.append((color, function.function))
            }
            else if let index = plotView?.functions.indexOf({ $0.0 == color })
            {
                plotView?.functions.removeAtIndex(index)
            }
            
            plotView?.setNeedsDisplay()
        }
    }
}
