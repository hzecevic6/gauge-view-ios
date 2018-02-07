//
//  ViewController.swift
//  GaugeTestiOS
//
//  Created by Helena Zecevic on 1/25/18.
//  Copyright © 2018 Helena Zecevic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gaugeView: GaugeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gaugeView.showGauge(values: ["25", "40", "70", "80"], colors: ["#009900", "#FFFF00", "#FFA500", "#FF0000", "#940000"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

