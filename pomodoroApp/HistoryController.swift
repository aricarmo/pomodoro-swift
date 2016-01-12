//
//  SecondViewController.swift
//  pomodoroApp
//
//  Created by Arilson Carmo on 1/7/16.
//  Copyright © 2016 Arilson Carmo. All rights reserved.
//

import UIKit

class HistoryController: UITableViewController {
    
    var pomodoroList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().objectForKey("pomodoroList") != nil {
            pomodoroList = NSUserDefaults.standardUserDefaults().objectForKey("pomodoroList") as! [String]
        }
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        let dict = convertStringToDictionary(pomodoroList[indexPath.row])
        print(dict!["elapsed"])
        let secondsLeft: Int? = Int(dict!["elapsed"]!)
        let minutes = (secondsLeft! % 3600) / 60
        let seconds = (secondsLeft! % 3600) % 60
        
        let minutesString = String(format:"%02d", minutes)
        let secondsString = String(format: "%02d", seconds)
        cell.textLabel?.text = "\(minutesString):\(secondsString)"
        cell.detailTextLabel?.text = formatDate(dict!["date"]!)
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return pomodoroList.count
    }
    
    func convertStringToDictionary(text: String) -> [String:String]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String:String]
                return json
            } catch {
                print("error")
            }
            
        }
        return nil
    }
    
    private func formatDate(sDate: String) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss xx"
        let date = dateFormatter.dateFromString(sDate)
        
        return timeAgoSinceDate(date!, numericDates: true)
    }
    
    func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        if (components.year >= 2) {
            return "\(components.year) years ago"
        } else if (components.year >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month >= 2) {
            return "\(components.month) months ago"
        } else if (components.month >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear >= 2) {
            return "\(components.weekOfYear) weeks ago"
        } else if (components.weekOfYear >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day >= 2) {
            return "\(components.day) days ago"
        } else if (components.day >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour >= 2) {
            return "\(components.hour) hours ago"
        } else if (components.hour >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute >= 2) {
            return "\(components.minute) minutes ago"
        } else if (components.minute >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second >= 3) {
            return "\(components.second) seconds ago"
        } else {
            return "Just now"
        }
        
    }


}

