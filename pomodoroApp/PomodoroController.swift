//
//  FirstViewController.swift
//  pomodoroApp
//
//  Created by Arilson Carmo on 1/7/16.
//  Copyright © 2016 Arilson Carmo. All rights reserved.
//

import UIKit

class PomodoroController: UIViewController {
    
    /*
    * status 0 = not started
    * status 1 = started
    */
    var status = 0
    var imageCounter = 0
    var timer = NSTimer()
    var secondsElapsed = 0
    var secondsLeft = Int()
    var minutes = Int()
    var seconds = Int()
    var pomodoroList = [String]()
    var settings = [String]()
    let tabBar = UITabBar()
    
    @IBOutlet weak var timeTxt: UILabel!
    @IBOutlet weak var pomodoroImage: UIImageView!
    @IBOutlet weak var initButton: UIButton!
    
    @IBAction func startActionBtn(sender: AnyObject) {
        if (status == 0) {
            status = 1
            initButton.backgroundColor = UIColor(red:1, green:0.263, blue:0.318, alpha:1)
            initButton.setTitle("Stop", forState: UIControlState.Normal)
            doAnimation()
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector: "countDown", userInfo: nil, repeats: true)
        }
        else {
            save()
            clear()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        applyButtonStyle()
    }
    
    override func viewWillAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().objectForKey("pomodoroList") != nil {
            pomodoroList = NSUserDefaults.standardUserDefaults().objectForKey("pomodoroList") as! [String]
        }
        if status == 0{
            clear()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if status == 1{
            save()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func clear() {
        if NSUserDefaults.standardUserDefaults().objectForKey("settings") != nil {
            settings = NSUserDefaults.standardUserDefaults().objectForKey("settings") as! [String]
            
        } else {
            settings.insert("25", atIndex: 0)
        }
        
        secondsElapsed = 0
        secondsLeft = Int(settings[0])! * 60
        timeTxt.text =  getMinutes()
        minutes = Int()
        seconds = Int()
        
        status = 0
        initButton.setTitle("Start", forState: UIControlState.Normal)
        pomodoroImage.image? = UIImage(named:"pomodoro1.png")!
        initButton.backgroundColor = UIColor.grayColor()
        
        timer.invalidate()
    }
    
    func save() {
        let toSave = ["elapsed": String(secondsElapsed), "date" : String(NSDate())]
        pomodoroList.append(Util.dictToJsonString(toSave));
        NSUserDefaults.standardUserDefaults().setObject(pomodoroList, forKey: "pomodoroList");
    }
    
    func applyButtonStyle() {
        initButton.layer.cornerRadius = 5;
        initButton.layer.borderWidth = 0;
    }
    
    func countDown() {
        secondsLeft--
        secondsElapsed++
        
        if secondsLeft == 0 {
            timeUp()
        } else {
            timeTxt.text = getMinutes()
        }
        
    }
    
    func timeUp() {
        save()
        Util.showAlerts("Timeup!", stringMessage: "Pomodoro time is finished! Touch Start if you want start over.")
        clear()
    }
    
    func getMinutes() -> String {
        minutes = (secondsLeft % 3600) / 60
        seconds = (secondsLeft % 3600) % 60
        let minutesString = String(format:"%02d", minutes)
        let secondsString = String(format: "%02d", seconds)
        
        return "\(minutesString):\(secondsString)"
    }
    
    func doAnimation() {
        let transition = CATransition()
        let imageName = "pomodoro"+String(imageCounter)+".png"
        transition.type = kCATransitionFade
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.3)
        CATransaction.setCompletionBlock { () -> Void in
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue()){
                if(self.status == 1){
                   self.doAnimation()
                }
            }
        }
        
        if (imageCounter == 1) {
            pomodoroImage.layer.addAnimation(transition, forKey: kCATransition);
            pomodoroImage.image? = UIImage(named:imageName)!
            imageCounter = 0
        }
        else {
            pomodoroImage.layer.addAnimation(transition, forKey: kCATransition);
            pomodoroImage.image? = UIImage(named:imageName)!
            imageCounter = 1
        }
        CATransaction.commit()
    }
    
}

