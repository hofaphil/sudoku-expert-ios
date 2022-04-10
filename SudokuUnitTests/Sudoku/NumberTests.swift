//
// Created by Philipp Hofer on 10.04.22.
// Copyright (c) 2022 Philipp Hofer. All rights reserved.
//


import XCTest
@testable import Sudoku

class NumberTests: XCTestCase {

    private let correctNumber = 3, wrongNumber = 4
    private let changeable = true, notes = true
    private let expectedNotes = Array.init(repeating: false, count: 9)

    // constructors
    func testInit() {
        let number = Number()

        assert(number, 0, 0, false, false, expectedNotes)
    }

    func testInitWithParameter() {
        let number = Number(number: wrongNumber, solution: correctNumber, isChangeable: changeable)

        assert(number, wrongNumber, correctNumber, !notes, changeable, expectedNotes)
    }

    // insert
    func testInsertCorrectNumber() {
        let number = Number(number: wrongNumber, solution: correctNumber, isChangeable: changeable)

        let noError = number.insert(number: correctNumber, note: !notes)

        XCTAssertTrue(noError)
        assert(number, correctNumber, correctNumber, !notes, changeable, expectedNotes)
    }

    func testInsertWrongNumber() {
        let number = Number(number: correctNumber, solution: correctNumber, isChangeable: changeable)

        let noError = number.insert(number: wrongNumber, note: !notes)

        XCTAssertFalse(noError)
        assert(number, wrongNumber, correctNumber, !notes, changeable, expectedNotes)
    }

    func testInsertNumberTwoTimes() {
        let number = Number(number: 0, solution: correctNumber, isChangeable: changeable)

        var noError = number.insert(number: wrongNumber, note: !notes)
        XCTAssertFalse(noError)

        noError = number.insert(number: wrongNumber, note: !notes)
        XCTAssertTrue(noError)

        assert(number, 0, correctNumber, !notes, changeable, expectedNotes)
    }

    func testInsertNote() {
        let number = Number(number: 0, solution: correctNumber, isChangeable: changeable)

        let noError = number.insert(number: wrongNumber, note: notes)

        XCTAssertTrue(noError)
        assert(number, 0, correctNumber, notes, changeable, getExpectedNotes(wrongNumber))
    }

    func testInsertNoteTwoTimes() {
        let number = Number(number: 0, solution: correctNumber, isChangeable: changeable)

        var noError = number.insert(number: wrongNumber, note: notes)
        XCTAssertTrue(noError)

        noError = number.insert(number: wrongNumber, note: notes)
        XCTAssertTrue(noError)

        assert(number, 0, correctNumber, notes, changeable, expectedNotes)
    }

    func testInsertNumberWhenNote() {
        let number = Number(number: 0, solution: correctNumber, isChangeable: changeable)
        var noError = number.insert(number: wrongNumber, note: notes)
        XCTAssertTrue(noError)

        noError = number.insert(number: wrongNumber, note: !notes)
        XCTAssertFalse(noError)

        assert(number, wrongNumber, correctNumber, !notes, changeable, expectedNotes)
    }

    func testInsertNoteWhenNumber() {
        let number = Number(number: 0, solution: correctNumber, isChangeable: changeable)
        var noError = number.insert(number: wrongNumber, note: !notes)
        XCTAssertFalse(noError)

        noError = number.insert(number: wrongNumber, note: notes)
        XCTAssertTrue(noError)

        assert(number, 0, correctNumber, notes, changeable, getExpectedNotes(wrongNumber))
    }

    func testInsertWhenNotChangeable() {
        let otherNumber = 5
        let number = Number(number: otherNumber, solution: correctNumber, isChangeable: !changeable)

        var noError = number.insert(number: correctNumber, note: !notes)

        XCTAssertTrue(noError)
        assert(number, otherNumber, correctNumber, !notes, !changeable, expectedNotes)

        noError = number.insert(number: correctNumber, note: notes)

        XCTAssertTrue(noError)
        assert(number, otherNumber, correctNumber, !notes, !changeable, expectedNotes)
    }

    // delete
    func testDeleteNumber() {
        let number = Number(number: wrongNumber, solution: correctNumber, isChangeable: changeable)

        number.delete()

        assert(number, 0, correctNumber, !notes, changeable, expectedNotes)
    }

    func testDeleteNote() {
        let number = Number(number: 0, solution: correctNumber, isChangeable: changeable)
        var _ = number.insert(number: correctNumber, note: notes)
        var _ = number.insert(number: wrongNumber, note: notes)

        number.delete()

        assert(number, 0, correctNumber, notes, changeable, expectedNotes)
    }

    func testDeleteWhenNotChangeable() {
        let number = Number(number: correctNumber, solution: correctNumber, isChangeable: !changeable)

        number.delete()

        assert(number, correctNumber, correctNumber, !notes, !changeable, expectedNotes)
    }

    // checkNote
    func testCheckNote() {
        let number = Number(number: correctNumber, solution: correctNumber, isChangeable: changeable)
        var _ = number.insert(number: correctNumber, note: notes)
        var _ = number.insert(number: wrongNumber, note: notes)

        number.checkNote(number: correctNumber)

        assert(number, 0, correctNumber, notes, changeable, getExpectedNotes(wrongNumber))
    }

    // isError
    func testIsErrorCorrect() {
        let number = Number(number: wrongNumber, solution: correctNumber, isChangeable: changeable)

        XCTAssertTrue(number.isError())
    }

    func testIsErrorWrong() {
        let number = Number(number: 0, solution: correctNumber, isChangeable: changeable)

        XCTAssertFalse(number.isError())

        let noError = number.insert(number: correctNumber, note: !notes)
        XCTAssertTrue(noError)

        XCTAssertFalse(number.isError())
    }

    // equals
    func testEquality() {
        let number1 = Number(number: wrongNumber, solution: correctNumber, isChangeable: changeable)
        let number2 = Number(number: wrongNumber, solution: correctNumber, isChangeable: changeable)

        XCTAssertTrue(number1 == number2)

        var _ = number1.insert(number: correctNumber, note: !notes)

        XCTAssertTrue(number1 != number2)

        var _ = number1.insert(number: correctNumber, note: notes)

        XCTAssertTrue(number1 != number2)

        var _ = number2.insert(number: correctNumber, note: notes)

        XCTAssertTrue(number1 == number2)
    }

    // helper method
    private func assert(_ number: Number, _ n: Int, _ s: Int, _ isNotes: Bool, _ isChangeable: Bool, _ notes: [Bool]) {
        XCTAssertEqual(number.number, n)
        XCTAssertEqual(number.solution, s)
        XCTAssertEqual(number.isNotes, isNotes)
        XCTAssertEqual(number.isChangeable, isChangeable)
        XCTAssertEqual(number.notes, notes)
    }

    private func getExpectedNotes(_ notes: Int...) -> [Bool] {
        var expectedNotes = Array.init(repeating: false, count: 9)
        for note in notes {
            expectedNotes[note - 1] = true
        }

        return expectedNotes
    }
}