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
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPercentChoices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        var tipPercentages = [0.18, 0.2, 0.25]
        
        if defaults.bool(forKey: "customFirstPercent") == true {
            tipPercentages[0] =  defaults.double(forKey: "firstPercent") / 100
        }
        
        if defaults.bool(forKey: "customSecondPercent") == true {
            tipPercentages[1] =  defaults.double(forKey: "secondPercent") / 100
        }
        
        if defaults.bool(forKey: "customThirdPercent") == true {
            tipPercentages[2] =  defaults.double(forKey: "thirdPercent") / 100
        }
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipChoice.selectedSegmentIndex]
        let total = bill + tip
        tipValue.text = String.init(format: "$%.2f", tip)
        totalValue.text = String.init(format: "$%.2f", total)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        loadPercentChoices()
        billField.sendActions(for: UIControlEvents.editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
    }
    
    func loadPercentChoices() {
        if defaults.bool(forKey: "customFirstPercent") == true {
            let firstPercent = defaults.double(forKey: "firstPercent")
            tipChoice.setTitle(String.init(format: "%.0f%%", firstPercent), forSegmentAt: 0)
        } else {
            tipChoice.setTitle("18%", forSegmentAt: 0)
        }
        
        if defaults.bool(forKey: "customSecondPercent") == true {
            let secondPercent = defaults.double(forKey: "secondPercent")
            tipChoice.setTitle(String.init(format: "%.0f%%", secondPercent), forSegmentAt: 1)
        } else {
            tipChoice.setTitle("20%", forSegmentAt: 1)
        }
        
        if defaults.bool(forKey: "customThirdPercent") == true {
            let thirdPercent = defaults.double(forKey: "thirdPercent")
            tipChoice.setTitle(String.init(format: "%.0f%%", thirdPercent), forSegmentAt: 2)
        } else {
            tipChoice.setTitle("25%", forSegmentAt: 2)
        }
    }
    
}

