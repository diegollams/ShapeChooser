//
//  TimerLabel.swift
//  ShapeChooser
//
//  Created by Diego Llamas Velasco on 6/27/16.
//  Copyright © 2016 Diego Llamas Velasco. All rights reserved.
//

import Foundation
import UIKit

class TimerLabel: UILabel{
    struct Events{
        static let onTimerFinish = "onTimerFinish"
    }
    
    private var _startingTime: Int?
    private var _currentTime: Int?
    private var _timer: NSTimer?
    private let notificationOnTimerFinish = NSNotification(name: Events.onTimerFinish, object: nil)
    
    var startingTime: Int{
        get{
            if _startingTime != nil{
                return _startingTime!
            }else{
                return 0
            }
        }
        set{
            _startingTime = newValue
            resetTimer()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func resetTimer(){
        if _timer != nil{
            _timer?.invalidate()
        }
        _currentTime = startingTime
        text = "\(startingTime)"
    }
    
    func restartTimer(){
        resetTimer()
        startTimer()
    }
    
    func startTimer(){
        if _startingTime != nil{
            _timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.decreeTime), userInfo: nil, repeats: false)
        }
    }
    
    func stopTimer(){
        if _timer != nil{
            _currentTime = 0
            _timer?.invalidate()
            _timer = nil
        }
        
    }
    func decreeTime(){
        if _currentTime != nil && _timer != nil{
            _currentTime! -= 1
            if _currentTime > 0{
                startTimer()
            }else{
                NSNotificationCenter.defaultCenter().postNotification(notificationOnTimerFinish)
            }
            text = "\(_currentTime!)"
        }
    }
    
    
}