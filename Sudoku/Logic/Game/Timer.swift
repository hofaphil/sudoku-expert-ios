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
        if timerRun && !pause {
            timeInt += 1
            setTime(timeInt)
        }
    }

    // input time in seconds
    func setTime(_ time: Int) {
        self.time = MainModel.timeToString(time)
    }

    static func timeToString(_ time: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        return formatter.string(from: TimeInterval(time))!
    }
}
