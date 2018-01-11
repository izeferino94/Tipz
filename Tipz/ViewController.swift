//
//  ViewController.swift
//  Tipz
//
//  Created by Isaias Zeferino on 12/22/17.
//  Copyright © 2017 Isaias Zeferino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipValue: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipChoice: UISegmentedControl!
    @IBOutlet weak var splitStep: UIStepper!
    @IBOutlet weak var splitAmount: UILabel!
    
    let defaults = UserDefaults.standard
    let currencyFormatter = NumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPercentChoices()
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = NSLocale.current
        print("viewDidLoad")
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
        let total = (bill + tip) / splitStep.value
        tipValue.text = String.init(format: "$%.2f", tip)
        totalValue.text = String.init(format: "$%.2f", total)
        tipValue.text = currencyFormatter.string(from: NSNumber(value: tip))
        totalValue.text = currencyFormatter.string(from: NSNumber(value: total))
    }
    
    @IBAction func splitChanged(_ sender: Any) {
        splitAmount.text = String(format: "%.0f%", splitStep.value)
        tipChoice.sendActions(for: UIControlEvents.valueChanged)
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
        print("viewWillAppear")
        //When coming back from settings page, we set the segmented controller and update Tip and Total
        loadPercentChoices()
        billField.sendActions(for: UIControlEvents.editingChanged)
        loadTheme()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        billField.becomeFirstResponder()
        
        print("viewDidAppear")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidDisappear")
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
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func loadTheme() {
        let theme = defaults.string(forKey: "theme")
        if(theme == "dark") {
            self.view.backgroundColor = UIColorFromHex(rgbValue: 0x0F3161, alpha: 1)
            tipValue.textColor = UIColor.white
            totalValue.textColor = UIColor.white
            splitAmount.textColor = UIColor.white
            billLabel.textColor = UIColor.white
            tipLabel.textColor = UIColor.white
            splitLabel.textColor = UIColor.white
            totalLabel.textColor = UIColor.white
            
        }
        else {
            self.view.backgroundColor = UIColor.white
            tipValue.textColor = UIColor.black
            totalValue.textColor = UIColor.black
            splitAmount.textColor = UIColor.black
            billLabel.textColor = UIColor.black
            tipLabel.textColor = UIColor.black
            splitLabel.textColor = UIColor.black
            totalLabel.textColor = UIColor.black
        }

    }
    
    
    
}

