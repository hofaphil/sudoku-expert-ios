//
//  Data.swift
//  Sudoku
//
//  Created by Philipp Hofer on 08.07.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

class Data {
    
    static let DIFFICULTY = "difficulty"
    static let FIELDMODELS = "fieldModels"
    static let ERRORCHECK = "errorCheck"
    static let TIMEINT = "timeInt"
    static let LOAD_MODE = "loadMode"
    
    // fields
    static let FIELD_NUMBER = "fieldNumber"
    static let FIELD_NOTES = "fieldNotes"
    static let FIELD_IS_NOTES = "fieldIsNotes"
    static let FIELD_CHANGEABLE = "fieldChangeable"
    
    // for settings
    static let SETTINGS_POWERMODE = "powermode";
    static let SETTINGS_MARK_LINES = "marklines";
    static let SETTINGS_MARK_NUMBERS = "marknumbers";
    static let SETTINGS_MARK_ERRORS = "markerrors";
    static let SETTINGS_CHECK_NOTES = "checknotes";
    static let SETTINGS_SHOW_TIME = "showtime";
    static let SETTINGS_COLOR = "color";
    static let SETTINGS_SUPPORTER = "supporter";
    
    // errorCheck
    //static let ERRORCHECK_OVERALLERRORS = "overallErrors"
    
    static let instance = Data()
    
    let storage = UserDefaults.standard
    
    private init() {}
    
    func saveGame(main: MainModel) {
        storage.set(main.difficulty, forKey: Data.DIFFICULTY)
        storage.set(main.timeInt, forKey: Data.TIMEINT)
        saveFieldModels(main.fields)
    }
    
    func loadGame(main: MainModel) {
        print("load")
        main.difficulty = storage.integer(forKey: Data.DIFFICULTY)
        main.timeInt = storage.integer(forKey: Data.TIMEINT)
        loadErrorCheck(main)
        loadFieldModels(main: main)
        print("ready loading")
    }
    
    func setLoadMode(mode: Bool) {
        storage.set(mode, forKey: Data.LOAD_MODE)
    }
    
    func getLoadMode() -> Bool {
        return storage.bool(forKey: Data.LOAD_MODE)
    }
    
    private func saveFieldModels(_ fields: [[[SudokuFieldModel]]]) {
        for i in 0..<fields.count {
            for j in 0..<fields[i].count {
                for (index, field) in fields[i][j].enumerated() {
                    storage.set(field.isNotes, forKey: Data.FIELD_IS_NOTES + String(i) + String(j) + String(index))
                    storage.set(field.number, forKey: Data.FIELD_NUMBER + String(i) + String(j) + String(index))
                    storage.set(field.notes, forKey: Data.FIELD_NOTES + String(i) + String(j) + String(index))
                    storage.set(field.changeable, forKey: Data.FIELD_CHANGEABLE + String(i) + String(j) + String(index))
                }
            }
        }
    }
    
    private func loadFieldModels(main: MainModel) {
        for i in 0..<9 {
            main.fields.append([[SudokuFieldModel]]())
            for j in 0..<3 {
                main.fields[i].append([SudokuFieldModel]())
                for a in 0..<3 {
                    main.fields[i][j].append(SudokuFieldModel(main: main, position: Position(row: j, column: a, parent: i),number: 0, error: false))
                    main.fields[i][j][a].isNotes = storage.bool(forKey: Data.FIELD_IS_NOTES + String(i) + String(j) + String(a))
                    if main.fields[i][j][a].isNotes {
                        main.fields[i][j][a].notes = storage.array(forKey: Data.FIELD_NOTES + String(i) + String(j) + String(a)) as! [Bool]
                    } else {
                        main.fields[i][j][a].insert(storage.integer(forKey: Data.FIELD_NUMBER + String(i) + String(j) + String(a)))
                    }
                    main.fields[i][j][a].changeable = storage.bool(forKey: Data.FIELD_CHANGEABLE + String(i) + String(j) + String(a))
                }
            }
        }
    }
    
    private func loadErrorCheck(_ main: MainModel) {
        // load numbers and generate solution for errorCheck
        var solution = [Block]()
        for i in 0..<9 {
            var numbers = [[Int]]()
            for j in 0..<3 {
                numbers.append([Int](repeating: 0, count: 3))
                for a in 0..<3 {
                    numbers[j][a] = storage.integer(forKey: Data.FIELD_NUMBER + String(i) + String(j) + String(a))
                }
            }
            let block = Block()
            block.setNumbers(numbers: numbers)
            solution.append(block)
        }
        let sudoku = SudokuClass(threads: 1)
        do {
            try main.errorCheck = ErrorCheck(solution: sudoku.getSolution(sudoku: solution))
            try SudokuClass.printBlocks(blocks: sudoku.getSolution(sudoku: solution))
        } catch  {
            print("error") // TODO errorhandling
        }
    }
}
