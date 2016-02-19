//
//  ViewController.swift
//  AnimationDemo
//
//  Created by Christian Otkjær on 19/02/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Animation

extension Double
{
    func format(f: String = "") -> String
    {
        return String(format: "%\(f)f", self)
    }
}

class ViewController: UIViewController
{
    @IBOutlet weak var label: UILabel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func beginAnimating()
    {
        var counter = 0
        
        Animator.animate(20, delay: 1) {
            
            self.label?.text = String(format: "%.03f", $0)
            counter++
        }
    }
}

