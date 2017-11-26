//
//  WaveViewController.swift
//  Animation
//
//  Created by Christian Otkjær on 07/10/16.
//  Copyright © 2016 Christian Otkjær. All rights reserved.
//

import UIKit

class WaveViewController: UIViewController
{
    @IBOutlet weak var label: UILabel?
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        super.viewDidLoad()
        
        let color = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        
        guard let label = label else { return }

        let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.strokeWidth: -1.0,
                          NSAttributedStringKey.strokeColor: label.textColor,
                          NSAttributedStringKey.foregroundColor: color] //as! [String : Any]
                
        label.attributedText = NSAttributedString(string: "17", attributes: attributes)

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
