//
//  Util.swift
//  pomodoroApp
//
//  Created by Arilson Carmo on 1/12/16.
//  Copyright © 2016 Arilson Carmo. All rights reserved.
//

import Foundation
import UIKit

public class Util: NSObject {
    
    public class func showAlerts(stringTitle: String, stringMessage: String) {
        let rootViewController: UIViewController = UIApplication.sharedApplication().windows[0].rootViewController!
        let errorAlert = UIAlertController(title: stringTitle, message: stringMessage, preferredStyle: UIAlertControllerStyle.Alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
        }))
        rootViewController.presentViewController(errorAlert, animated: true, completion: nil)
    }
    
    public class func stringToDictionary(text: String) -> [String:String]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String:String]
                return json
            } catch {
                print("error")
                return nil
            }
        } else {
          return nil
        }
    }
    
    public class func dictToJsonString(strArr:NSDictionary) -> String {
        do {
            let JSONData  = try NSJSONSerialization.dataWithJSONObject(
                strArr,
                options: NSJSONWritingOptions(rawValue: 0))
            let JSONString = String(data: JSONData,
                encoding: NSASCIIStringEncoding)
            return JSONString!
        } catch {
            print("error")
            return ""
        }
    }
}
