//
//  ViewController.swift
//  BMI_Calc
//
//  Created by user238804 on 2/9/24.
//
 
 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hlabel: UILabel!
    @IBOutlet weak var htextfield: UITextField!
    
    @IBOutlet weak var wlabel: UILabel!
    @IBOutlet weak var wtextfield: UITextField!
    
    @IBOutlet weak var bmivaluetextfield: UITextField!
    @IBOutlet weak var bmicategorytextfield: UITextField!
    
    var isImperial: Bool = false // Track if the input is in Imperial units
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // By default, display labels (m) and (kg) beside height and weight labels
        hlabel.text = "Height (m)"
        wlabel.text = "Weight (kg)"
    }

    @IBAction func typeClicked(_ sender: UISegmentedControl) {
        // Segment control clicked
        if sender.selectedSegmentIndex == 1 {
            // Switched to Imperial segment
            hlabel.text = "Height (in)"
            wlabel.text = "Weight (lbs)"
            isImperial = true
        } else {
            // Switched to Metric segment
            hlabel.text = "Height (m)"
            wlabel.text = "Weight (kg)"
            isImperial = false
        }
    }
    
    @IBAction func calcClicked(_ sender: Any) {
        // Calculate BMI
        guard let heightStr = htextfield.text, let weightStr = wtextfield.text else {
            showAlert(message: "Please enter both height and weight.")
            return
        }
        
        guard let height = Double(heightStr), let weight = Double(weightStr) else {
            showAlert(message: "Invalid height or weight entered.")
            return
        }
        
        if height <= 0 || weight <= 0 {
            showAlert(message: "Height and weight must be positive values.")
            return
        }
        
        var bmi: Double
        
        if isImperial {
            // Convert height from inches to meters and weight from lbs to kg
            let heightInMeters = height * 0.0254
            let weightInKg = weight * 0.453592
            bmi = weightInKg / (heightInMeters * heightInMeters)
        } else {
            // BMI calculation for metric units
            bmi = weight / (height * height)
        }
        
        // Update BMI textfield
        bmivaluetextfield.text = String(format: "%.2f", bmi)
        
        // Determine BMI category
        var category: String
        if bmi < 18.5 {
            category = "Underweight"
        } else if bmi < 25 {
            category = "Normal"
        } else if bmi < 30 {
            category = "Overweight"
        } else {
            category = "Obese"
        }
        
        // Update BMI category textfield
        bmicategorytextfield.text = category
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


