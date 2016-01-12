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
            pomodoroList = pomodoroList.reverse()
        }
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        let dict = Util.stringToDictionary(pomodoroList[indexPath.row])
        let secondsLeft: Int? = Int(dict!["elapsed"]!)
        let minutes = (secondsLeft! % 3600) / 60
        let seconds = (secondsLeft! % 3600) % 60
        let minutesString = String(format:"%02d", minutes)
        let secondsString = String(format: "%02d", seconds)
        cell.textLabel?.text = "\(minutesString):\(secondsString)"
        cell.detailTextLabel?.text = TimeModel.timeAgoCalc(dict!["date"]!, numericDates: true)
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return pomodoroList.count
    }

}

