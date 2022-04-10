//
//  Sudoku.swift
//  SudokuUnitTests
//
//  Created by Philipp Hofer on 10.04.22.
//  Copyright © 2022 Philipp Hofer. All rights reserved.
//

import XCTest
@testable import Sudoku

class SudokuTests: XCTestCase {

    let correctNumber = 3, wrongNumber = 4
    let position = Position(block: 3, row: 2, column: 1)
    let note = true, changeable = true

    var number = Number()
    var sudoku = Sudoku()

    override func setUp() {
        super.setUp()

        number = Number(number: 0, solution: correctNumber, isChangeable: changeable)
        sudoku.setNumber(position: position, number: number)
    }

    // insert
    func testInsertNumber() {
        XCTAssertEqual(sudoku.overallErrors, 0)

        sudoku.insert(number: wrongNumber, position: position, note: !note)
        XCTAssertEqual(sudoku.overallErrors, 1)

        sudoku.insert(number: correctNumber, position: position, note: !note)
        XCTAssertEqual(sudoku.overallErrors, 1)

        sudoku.insert(number: wrongNumber, position: position, note: !note)
        XCTAssertEqual(sudoku.overallErrors, 2)
    }

    func testInsertNote() {
        XCTAssertEqual(sudoku.overallErrors, 0)

        sudoku.insert(number: wrongNumber, position: position, note: note)
        XCTAssertEqual(sudoku.overallErrors, 0)

        sudoku.insert(number: correctNumber, position: position, note: note)
        XCTAssertEqual(sudoku.overallErrors, 0)

        sudoku.insert(number: wrongNumber, position: position, note: !note)
        XCTAssertEqual(sudoku.overallErrors, 1)
    }

    // freeFields
    func testFreeFields() {
        XCTAssertEqual(sudoku.freeFields(), 81)

        sudoku.insert(number: wrongNumber, position: position, note: !note)
        XCTAssertEqual(sudoku.freeFields(), 80)

        sudoku.insert(number: correctNumber, position: position, note: note)
        XCTAssertEqual(sudoku.freeFields(), 81)
    }

    // currentErrors
    func testCurrentErrors() {
        XCTAssertEqual(sudoku.currentErrors(), 0)

        sudoku.insert(number: wrongNumber, position: position, note: !note)
        XCTAssertEqual(sudoku.currentErrors(), 1)

        sudoku.insert(number: correctNumber, position: position, note: !note)
        XCTAssertEqual(sudoku.currentErrors(), 0)

        sudoku.insert(number: wrongNumber, position: position, note: note)
        XCTAssertEqual(sudoku.currentErrors(), 0)
    }

    // equals
    func testEquality() {
        let s = Sudoku()
        XCTAssertTrue(s != sudoku)

        s.setNumber(position: position, number: Number(number: 0, solution: correctNumber, isChangeable: changeable))
        XCTAssertTrue(s == sudoku)

        sudoku.insert(number: correctNumber, position: position, note: !note)
        XCTAssertTrue(s != sudoku)

        s.insert(number: correctNumber, position: position, note: !note)
        XCTAssertTrue(s == sudoku)

        s.insert(number: wrongNumber, position: position, note: !note)
        XCTAssertTrue(s != sudoku)

        s.insert(number: correctNumber, position: position, note: !note)
        XCTAssertTrue(s != sudoku)
    }
}
