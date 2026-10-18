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

    // count
    func testCount() {
        XCTAssertEqual(sudoku.count(number: wrongNumber), 0)

        sudoku.insert(number: wrongNumber, position: position, note: !note)
        XCTAssertEqual(sudoku.count(number: wrongNumber), 1)

        sudoku.insert(number: correctNumber, position: position, note: note)
        XCTAssertEqual(sudoku.count(number: wrongNumber), 0)
        XCTAssertEqual(sudoku.count(number: correctNumber), 0)
    }

    // check notes
    func testCheckNotesOnlyAfterCorrectNumber() {
        UserDefaults.standard.set(true, forKey: Storage.SETTINGS_CHECK_NOTES)
        defer { UserDefaults.standard.removeObject(forKey: Storage.SETTINGS_CHECK_NOTES) }

        let peerPosition = Position(block: position.block, row: position.row, column: 0)
        let peer = Number(number: 0, solution: 9, isChangeable: changeable)
        sudoku.setNumber(position: peerPosition, number: peer)
        sudoku.insert(number: correctNumber, position: peerPosition, note: note)

        let main = MainModel()
        main.game = sudoku
        main.isNotes = false
        main.select(position: position)

        main.insert(number: wrongNumber)
        XCTAssertTrue(peer.notes[correctNumber - 1])

        main.insert(number: correctNumber)
        XCTAssertFalse(peer.notes[correctNumber - 1])
    }

    func testCheckNotesNotOnFixedField() {
        UserDefaults.standard.set(true, forKey: Storage.SETTINGS_CHECK_NOTES)
        defer { UserDefaults.standard.removeObject(forKey: Storage.SETTINGS_CHECK_NOTES) }

        let fixed = Number(number: correctNumber, solution: correctNumber, isChangeable: !changeable)
        sudoku.setNumber(position: position, number: fixed)

        let peerPosition = Position(block: position.block, row: position.row, column: 0)
        let peer = Number(number: 0, solution: 9, isChangeable: changeable)
        sudoku.setNumber(position: peerPosition, number: peer)
        sudoku.insert(number: wrongNumber, position: peerPosition, note: note)

        let main = MainModel()
        main.game = sudoku
        main.isNotes = false
        main.select(position: position)

        main.insert(number: wrongNumber)
        XCTAssertTrue(peer.notes[wrongNumber - 1])
    }
}
