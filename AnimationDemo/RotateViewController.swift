//
//  RotateViewController.swift
//  Animation
//
//  Created by Christian Otkjær on 06/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit
import Animation

class RotateViewController: UIViewController
{
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var activityIndicator: ActivityIndicatorView?
    
    @IBOutlet weak var progressIndicator: ProgressIndicatorView?
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        label.layer.beginRotating(clockwise: false, speed: 0.01)
        
//        activityIndicator?.startAnimating()
    }
    
    @IBAction func handleButton(_ button: UIButton)
    {
        activityIndicator?.startAnimating()
    }

    @IBAction func handleProgressButton(_ sender: UIButton)
    {
        
        progressIndicator?.progress += 0.1
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
