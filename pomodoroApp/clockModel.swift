//
//  clockModel.swift
//  pomodoroApp
//
//  Created by Arilson Carmo on 1/8/16.
//  Copyright © 2016 Arilson Carmo. All rights reserved.
//

import Foundation

class clockModel: NSObject{
    var secondsLeft = Int()
    var minutes = Int()
    var seconds = Int()
    var progress = Float()
    var intervalSize: Int
    var breakSize: Int
    var numIntervals: Int
    var active = false
    var breaked = false
    var timer = NSTimer()
    var pastsSeconds = 0
    
    
    required init(sSize: Int, bSize: Int, nIntervals: Int) {
        intervalSize = sSize
        breakSize = bSize
        numIntervals = nIntervals
        super.init()
    }
    
    func getIntervalSecondsLeft() {
        secondsLeft = intervalSize * 60
        breaked = false
    }
    
    func getBreakSecondsLeft() {
        secondsLeft = breakSize * 60
        breaked = true
    }
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "progressTimeAndDecrementCountdown", userInfo: nil, repeats: true)
        active = true
        notifyObservers("Pomodoro Started!")
    }
    
    func progressTimeAndDecrementCountdown() {
        secondsLeft--
        minutes =  (secondsLeft % 3600) / 60
        seconds = (secondsLeft % 3600) % 60
        pastsSeconds++
        progress = Float(pastsSeconds) / Float(intervalSize * 60)
    }
    
    func decrementCountdown() {
        if (secondsLeft == 0) {
            pastsSeconds = 0
            
        }
    }
    
    func notifyObservers(message: String) {
        let notification = NSNotification(name: "pomodoroTimer", object: self, userInfo: [ "message" : message ])
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    
}