//
//  Timer.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.06.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

extension MainModel {
    
    func startTimer(time: Int) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        self.timeInt = time
        setTime(time)
    }
    
    @objc func timerAction() {
        if timerRun {
            timeInt += 1
            setTime(timeInt)
        }
    }
    
    // input time in sec!
    func setTime(_ time: Int) {
        var t = time
        var hours: Int = 0, min10: Int = 0, min: Int = 0, sec10: Int = 0, sec: Int = 0
        while t - 3600 >= 0 {
            hours += 1
            t -= 3600
        }
        while t - 600 >= 0 {
            min10 += 1
            t -= 600
        }
        while t - 60 >= 0 {
            min += 1
            t -= 60
        }
        while t - 10 >= 0 {
            sec10 += 1
            t -= 10
        }
        sec = t
        if hours > 0 {
            self.time = String(hours) + ":" + String(min10) + "" + String(min) + ":" + String(sec10) + "" + String(sec)
        }
        self.time = String(min10) + "" + String(min) + ":" + String(sec10) + "" + String(sec)
    }
}
