//
// Created by Philipp Hofer on 04.04.22.
// Copyright (c) 2022 Philipp Hofer. All rights reserved.
//

import Foundation

class Statistics: Codable {

    var bestTime: [Int] = [0, 0, 0]
    var timesPlayed: [Int] = [0, 0, 0]
    var timeOverall: [Int] = [0, 0, 0]

    func addGame(difficulty: Difficulty, time: Int) {
        let index = difficulty.rawValue
        timesPlayed[index] += 1
        timeOverall[index] += time
        bestTime[index] = bestTime[index] > time || bestTime[index] == 0 ? time : bestTime[index]
    }

    func getTimesPlayed(difficulty: Difficulty) -> Int {
        timesPlayed[difficulty.rawValue]
    }

    func getBestTime(difficulty: Difficulty) -> Int {
        bestTime[difficulty.rawValue]
    }

    func getAverageTime(difficulty: Difficulty) -> Int {
        if (timesPlayed[difficulty.rawValue] != 0) {
            return timeOverall[difficulty.rawValue] / timesPlayed[difficulty.rawValue]
        }
        return 0
    }
}