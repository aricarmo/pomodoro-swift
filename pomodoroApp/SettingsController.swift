//
//  SettingsController.swift
//  pomodoroApp
//
//  Created by Arilson Carmo on 1/12/16.
//  Copyright © 2016 Arilson Carmo. All rights reserved.
//

import Foundation
import UIKit

class SettingsController: UIViewController {
    
    var settings = [String]()
    
    @IBOutlet weak var txtInterval: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveAct(sender: AnyObject) {
        if txtInterval.text != nil && txtInterval.text != "0" && txtInterval.text != "" {
            settings.insert(txtInterval.text!, atIndex: 0)
            NSUserDefaults.standardUserDefaults().setObject(settings, forKey: "settings")
            Util.showAlerts("SUCCESS", stringMessage: "Your new interval is " + txtInterval.text!)
        } else {
            Util.showAlerts("ERROR", stringMessage: "Cannot save null or 0 minutes")
        }
    }
    
    override func viewDidLoad() {
        if NSUserDefaults.standardUserDefaults().objectForKey("settings") != nil {
            settings = NSUserDefaults.standardUserDefaults().objectForKey("settings") as! [String]
            txtInterval.text = settings[0]
        }
        applyButtonStyle()
        //add event to hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "donePressed")
        view.addGestureRecognizer(tap)
        
    }
    
    /*
    *  Hide all inputs after End Editing
    */
    func donePressed() {
        view.endEditing(true)
    }
    
    func applyButtonStyle() {
        saveButton.layer.cornerRadius = 5;
        saveButton.layer.borderWidth = 0;
    }
    
}
