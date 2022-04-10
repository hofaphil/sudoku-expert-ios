//
// Created by Philipp Hofer on 10.04.22.
// Copyright (c) 2022 Philipp Hofer. All rights reserved.
//

import XCTest
@testable import Sudoku

class StatisticsTests: XCTestCase {

    let statistics = Statistics()
    let beg = Difficulty.BEGINNER, adv = Difficulty.ADVANCED, exp = Difficulty.EXPERT
    let time = 100

    func testStatistics() {
        assertIsNone(beg)
        assertIsNone(adv)
        assertIsNone(exp)

        statistics.addGame(difficulty: beg, time: time)

        XCTAssertEqual(statistics.getTimesPlayed(difficulty: beg), 1)
        XCTAssertEqual(statistics.getAverageTime(difficulty: beg), time)
        XCTAssertEqual(statistics.getBestTime(difficulty: beg), time)
        assertIsNone(adv)
        assertIsNone(exp)

        statistics.addGame(difficulty: beg, time: time + time)

        XCTAssertEqual(statistics.getTimesPlayed(difficulty: beg), 2)
        XCTAssertEqual(statistics.getAverageTime(difficulty: beg), time + time / 2)
        XCTAssertEqual(statistics.getBestTime(difficulty: beg), time)
        assertIsNone(adv)
        assertIsNone(exp)

        statistics.addGame(difficulty: exp, time: time)

        XCTAssertEqual(statistics.getTimesPlayed(difficulty: beg), 2)
        XCTAssertEqual(statistics.getAverageTime(difficulty: beg), time + time / 2)
        XCTAssertEqual(statistics.getBestTime(difficulty: beg), time)
        XCTAssertEqual(statistics.getTimesPlayed(difficulty: exp), 1)
        XCTAssertEqual(statistics.getAverageTime(difficulty: exp), time)
        XCTAssertEqual(statistics.getBestTime(difficulty: exp), time)
        assertIsNone(adv)
    }

    private func assertIsNone(_ difficulty: Difficulty) {
        XCTAssertEqual(statistics.getTimesPlayed(difficulty: difficulty), 0)
        XCTAssertEqual(statistics.getAverageTime(difficulty: difficulty), 0)
        XCTAssertEqual(statistics.getBestTime(difficulty: difficulty), 0)
    }
}