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
        
        // Set the value of tipPercentages to calculate tip and total
        if defaults.bool(forKey: "customFirstPercent") == true {
            tipPercentages[0] =  defaults.double(forKey: "firstPercent") / 100
        }
        
        if defaults.bool(forKey: "customSecondPercent") == true {
            tipPercentages[1] =  defaults.double(forKey: "secondPercent") / 100
        }
        
        if defaults.bool(forKey: "customThirdPercent") == true {
            tipPercentages[2] =  defaults.double(forKey: "thirdPercent") / 100
        }
        
        //Calculate the tip and total and update the labels
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipChoice.selectedSegmentIndex]
        let total = bill + tip
        tipValue.text = String.init(format: "$%.2f", tip)
        totalValue.text = String.init(format: "$%.2f", total)
    }
    
    
    @IBAction func tipPercentChanged(_ sender: Any) {
        
        /*
        //Reset value of frame
        self.tipValue.frame.origin.y = 157
        UIView.animate(withDuration: 1, animations: {
            self.totalValue.textColor = .green
        }, completion: nil)
        
        UIView.animate(withDuration: 1, animations: {
            self.tipValue.textColor = .green
            //self.tipValue.frame.size.width += 10
            //self.tipValue.frame.size.height += 10
        }) { _ in
            UIView.animate(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat], animations: {
                self.tipValue.frame.origin.y -= 10
            })
        }
        */
        
        // Optionally initialize the property to a desired starting value
        //self.firstView.alpha = 0
        //self.secondView.alpha = 1
        UIView.animate(withDuration:1, animations: {
            // This causes first view to fade in and second view to fade out
            self.tipValue.alpha = 0
            self.totalValue.alpha = 0
            self.tipValue.alpha = 1
            self.totalValue.alpha = 1
        }, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //When coming back from settings page, we set the segmented controller and update Tip and Total
        loadPercentChoices()
        billField.sendActions(for: UIControlEvents.editingChanged)
    }
    
    /*
     Function that sets the value of the segment controller
     If the defaults are set, then get values from there.
     If not, then we set the original values.
     */
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

