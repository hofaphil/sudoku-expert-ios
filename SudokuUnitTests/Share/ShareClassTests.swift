//
// Created by Philipp Hofer on 10.04.22.
// Copyright (c) 2022 Philipp Hofer. All rights reserved.
//

import XCTest
@testable import Sudoku

class ShareClassTests: XCTestCase {

    // 5 6 0   2 0 3   0 9 0         5 6 4   2 8 3   1 9 7
    // 1 9 0   7 0 4   0 5 8         1 9 3   7 6 4   2 5 8
    // 7 8 0   0 0 5   0 3 6         7 8 2   1 9 5   4 3 6
    //
    // 3 0 0   5 2 9   0 6 4         3 1 8   5 2 9   7 6 4
    // 0 0 0   3 0 8   9 1 0    ->   2 7 6   3 4 8   9 1 5
    // 4 5 9   6 0 7   0 2 3         4 5 9   6 1 7   8 2 3
    //
    // 0 0 0   0 0 0   0 0 2         9 3 1   8 7 6   5 4 2
    // 6 0 0   4 0 0   0 0 0         6 2 7   4 5 1   3 8 9
    // 0 4 0   9 0 0   6 0 0         8 4 5   9 3 2   6 7 1
    static let link = "https://philipphofer.de/share?id=m6i9o8jk7la5qa58k63d4595293p6on491a23b6b4c4a9c2b6a";

    let game = [
        [[5, 6, 0], [1, 9, 0], [7, 8, 0]],
        [[2, 0, 3], [7, 0, 4], [0, 0, 5]],
        [[0, 9, 0], [0, 5, 8], [0, 3, 6]],
        //
        [[3, 0, 0], [0, 0, 0], [4, 5, 9]],
        [[5, 2, 9], [3, 0, 8], [6, 0, 7]],
        [[0, 6, 4], [9, 1, 0], [0, 2, 3]],
        //
        [[0, 0, 0], [6, 0, 0], [0, 4, 0]],
        [[0, 0, 0], [4, 0, 0], [9, 0, 0]],
        [[0, 0, 2], [0, 0, 0], [6, 0, 0]],
    ];

    let solution = [
        [[5, 6, 4], [1, 9, 3], [7, 8, 2]],
        [[2, 8, 3], [7, 6, 4], [1, 9, 5]],
        [[1, 9, 7], [2, 5, 8], [4, 3, 6]],
        //
        [[3, 1, 8], [2, 7, 6], [4, 5, 9]],
        [[5, 2, 9], [3, 4, 8], [6, 1, 7]],
        [[7, 6, 4], [9, 1, 5], [8, 2, 3]],
        //
        [[9, 3, 1], [6, 2, 7], [8, 4, 5]],
        [[8, 7, 6], [4, 5, 1], [9, 3, 2]],
        [[5, 4, 2], [3, 8, 9], [6, 7, 1]],
    ];

    func testLoad() throws {
        let returnValues = try ShareClass.load(url: URL(string: ShareClassTests.link)!)
        let sudoku = returnValues.0

        XCTAssertEqual(returnValues.1, Difficulty.BEGINNER)

        for b in 0...8 {
            for r in 0...2 {
                for c in 0...2 {
                    let pos = Position(block: b, row: r, column: c)
                    let n = game[b][r][c], s = solution[b][r][c]
                    let expectedNumber = Number(number: n, solution: s, isChangeable: n == 0)
                    XCTAssertEqual(sudoku.getNumber(position: pos), expectedNumber)
                }
            }
        }
    }

    func testGenerateShareLink() throws {
        let returnValues = try ShareClass.load(url: URL(string: ShareClassTests.link)!)
        let sudoku = returnValues.0, difficulty = returnValues.1

        XCTAssertEqual(ShareClassTests.link, ShareClass.generateShareLink(sudoku: sudoku, difficulty: difficulty)?.absoluteString)
    }

    // TODO test error cases
}