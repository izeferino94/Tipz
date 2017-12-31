//
//  SettingsViewController.swift
//  Tipz
//
//  Created by Isaias Zeferino on 12/30/17.
//  Copyright © 2017 Isaias Zeferino. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var firstPercentStep: UIStepper!
    @IBOutlet weak var secondPercentStep: UIStepper!
    @IBOutlet weak var thirdPercentStep: UIStepper!
    @IBOutlet weak var firstPercentValue: UILabel!
    @IBOutlet weak var secondPercentValue: UILabel!
    @IBOutlet weak var thirdPercentValue: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstPercentStep.wraps = true
        firstPercentStep.autorepeat = true
        firstPercentStep.minimumValue = 0
        firstPercentStep.maximumValue = 100
        
        secondPercentStep.wraps = true
        secondPercentStep.autorepeat = true
        secondPercentStep.minimumValue = 0
        secondPercentStep.maximumValue = 100
        
        thirdPercentStep.wraps = true
        thirdPercentStep.autorepeat = true
        thirdPercentStep.minimumValue = 0
        thirdPercentStep.maximumValue = 100
        defaults.synchronize()
        
        if defaults.bool(forKey: "customFirstPercent") == true {
            print("First percent is set")
            let firstPercent = defaults.double(forKey: "firstPercent")
            firstPercentValue.text = String.init(format: "%.0f%%", firstPercent)
            firstPercentStep.value = firstPercent
        } else {
            firstPercentStep.value = 18
        }
        
        if defaults.bool(forKey: "customSecondPercent") == true {
            print("First percent is set")
            let secondPercent = defaults.double(forKey: "secondPercent")
            secondPercentValue.text = String.init(format: "%.0f%%", secondPercent)
            secondPercentStep.value = secondPercent
        } else {
            secondPercentStep.value = 20
        }
        
        if defaults.bool(forKey: "customThirdPercent") == true {
            let thirdPercent = defaults.double(forKey: "thirdPercent")
            thirdPercentValue.text = String.init(format: "%.0f%%", thirdPercent)
            thirdPercentStep.value = thirdPercent
        } else {
            thirdPercentStep.value = 25
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func firstPercentChange(_ sender: Any) {
        defaults.set(firstPercentStep.value, forKey: "firstPercent")
        defaults.set(true, forKey: "customFirstPercent")
        defaults.synchronize()
        //Set value of label
        firstPercentValue.text = String.init(format: "%.0f%%", firstPercentStep.value)
    }
    
    @IBAction func secondPercentChange(_ sender: Any) {
        defaults.set(secondPercentStep.value, forKey: "secondPercent")
        defaults.set(true, forKey: "customSecondPercent")
        defaults.synchronize()
        secondPercentValue.text = String.init(format: "%.0f%%", secondPercentStep.value)
    }
    
    @IBAction func thirdPercentChange(_ sender: Any) {
        defaults.set(thirdPercentStep.value, forKey: "thirdPercent")
        defaults.set(true, forKey: "customThirdPercent")
        defaults.synchronize()
        thirdPercentValue.text = String.init(format: "%.0f%%", thirdPercentStep.value)
    }
    
    @IBAction func resetPercent(_ sender: Any) {
        defaults.set(false, forKey: "customFirstPercent")
        defaults.set(false, forKey: "customSecondPercent")
        defaults.set(false, forKey: "customThirdPercent")
    }
    
    
    
    
    

}
