//
//  SettingsViewController.swift
//  Tipz
//
//  Created by Isaias Zeferino on 12/30/17.
//  Copyright © 2017 Isaias Zeferino. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    //labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstOptionLabel: UILabel!
    @IBOutlet weak var secondOptionLabel: UILabel!
    @IBOutlet weak var thirdOptionLabel: UILabel!
    @IBOutlet weak var colorThemeLabel: UILabel!
    
    
    @IBOutlet weak var firstPercentStep: UIStepper!
    @IBOutlet weak var secondPercentStep: UIStepper!
    @IBOutlet weak var thirdPercentStep: UIStepper!
    @IBOutlet weak var firstPercentValue: UILabel!
    @IBOutlet weak var secondPercentValue: UILabel!
    @IBOutlet weak var thirdPercentValue: UILabel!
    @IBOutlet weak var themeSegCon: UISegmentedControl!
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the steppers
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
        
        //Check if 1st default tip has been changed, and set the values
        if defaults.bool(forKey: "customFirstPercent") == true {
            let firstPercent = defaults.double(forKey: "firstPercent")
            firstPercentValue.text = String.init(format: "%.0f%%", firstPercent)
            firstPercentStep.value = firstPercent
        } else {
            firstPercentStep.value = 18
        }
        
        //Check if 2nd default tip has been changed, and set the values
        if defaults.bool(forKey: "customSecondPercent") == true {
            let secondPercent = defaults.double(forKey: "secondPercent")
            secondPercentValue.text = String.init(format: "%.0f%%", secondPercent)
            secondPercentStep.value = secondPercent
        } else {
            secondPercentStep.value = 20
        }
        
        //Check if 3rd default tip has been changed, and set the values
        if defaults.bool(forKey: "customThirdPercent") == true {
            let thirdPercent = defaults.double(forKey: "thirdPercent")
            thirdPercentValue.text = String.init(format: "%.0f%%", thirdPercent)
            thirdPercentStep.value = thirdPercent
        } else {
            thirdPercentStep.value = 25
        }
        
        //Set theme control
        let theme = defaults.string(forKey: "theme")
        if(theme == "dark") {
            themeSegCon.selectedSegmentIndex = 1
            themeSegCon.sendActions(for: UIControlEvents.valueChanged)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func firstPercentChange(_ sender: Any) {
        //Update value of 1st percent in defaults
        defaults.set(firstPercentStep.value, forKey: "firstPercent")
        defaults.set(true, forKey: "customFirstPercent")
        defaults.synchronize()
        
        //Set value of label
        firstPercentValue.text = String.init(format: "%.0f%%", firstPercentStep.value)
    }
    
    @IBAction func secondPercentChange(_ sender: Any) {
        //Update value of 2nd percent in defaults
        defaults.set(secondPercentStep.value, forKey: "secondPercent")
        defaults.set(true, forKey: "customSecondPercent")
        defaults.synchronize()
        
        //Set value of label
        secondPercentValue.text = String.init(format: "%.0f%%", secondPercentStep.value)
    }
    
    @IBAction func thirdPercentChange(_ sender: Any) {
        //Update value of 3rd percent in defaults
        defaults.set(thirdPercentStep.value, forKey: "thirdPercent")
        defaults.set(true, forKey: "customThirdPercent")
        defaults.synchronize()
        
        //Set value of label
        thirdPercentValue.text = String.init(format: "%.0f%%", thirdPercentStep.value)
    }
    
    @IBAction func themeChanged(_ sender: Any) {
        if(themeSegCon.selectedSegmentIndex == 0) {
            defaults.set("light", forKey: "theme")
            self.view.backgroundColor = UIColor.white
            firstPercentValue.textColor = UIColor.black
            secondPercentValue.textColor = UIColor.black
            thirdPercentValue.textColor = UIColor.black
            titleLabel.textColor = UIColor.black
            firstOptionLabel.textColor = UIColor.black
            secondOptionLabel.textColor = UIColor.black
            thirdOptionLabel.textColor = UIColor.black
            colorThemeLabel.textColor = UIColor.black
            
        }
        else {
            defaults.set("dark", forKey: "theme")
            self.view.backgroundColor = UIColorFromHex(rgbValue: 0x0F3161, alpha: 1)
            firstPercentValue.textColor = UIColor.white
            secondPercentValue.textColor = UIColor.white
            thirdPercentValue.textColor = UIColor.white
            titleLabel.textColor = UIColor.white
            firstOptionLabel.textColor = UIColor.white
            secondOptionLabel.textColor = UIColor.white
            thirdOptionLabel.textColor = UIColor.white
            colorThemeLabel.textColor = UIColor.white
        }
        defaults.synchronize()
    }
    
    @IBAction func resetPercent(_ sender: Any) {
        //Resetting values in defaults
        defaults.set(false, forKey: "customFirstPercent")
        defaults.set(false, forKey: "customSecondPercent")
        defaults.set(false, forKey: "customThirdPercent")
        
        //Set values in defaults
        defaults.set(18, forKey: "thirdPercent")
        defaults.set(20, forKey: "secondPercent")
        defaults.set(25, forKey: "thirdPercent")
        defaults.synchronize()
        
        //Set values in label
        firstPercentValue.text = "18%"
        secondPercentValue.text = "20%"
        thirdPercentValue.text = "25%"
        
        // Animation
        UIView.animate(withDuration:1, animations: {
            self.firstPercentValue.alpha = 0
            self.secondPercentValue.alpha = 0
            self.thirdPercentValue.alpha = 0
            self.firstPercentValue.alpha = 1
            self.secondPercentValue.alpha = 1
            self.thirdPercentValue.alpha = 1
        }, completion: nil)
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}
