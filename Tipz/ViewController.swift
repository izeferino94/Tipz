//
//  ViewController.swift
//  Tipz
//
//  Created by Isaias Zeferino on 12/22/17.
//  Copyright © 2017 Isaias Zeferino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipValue: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipChoice: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipChoice.setTitle("18%", forSegmentAt: 0)
        tipChoice.setTitle("18%", forSegmentAt: 1)
        tipChoice.setTitle("18%", forSegmentAt: 2)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipChoice.selectedSegmentIndex]
        let total = bill + tip
        tipValue.text = String.init(format: "$%.2f", tip)
        totalValue.text = String.init(format: "$%.2f", total)
    }
    
}

