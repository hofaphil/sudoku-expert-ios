//
//  Data.swift
//  Sudoku
//
//  Created by Philipp Hofer on 08.07.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

class Data {
    
    static let LOAD_MODE = "loadmode"
    
    // for game
    static let GAME_ERRORS = "game_errors";
    static let GAME_DIFFICULTY = "game_difficulty";
    static let GAME_TIME = "game_time";
    static let GAME_SHOW_ERRORS = "game_main_show_errors";
    static let GAME_SHOW_TIME = "game_main_show_time";
    
    // for fields
    static let FIELD_NUMBER = "field_Number"
    static let FIELD_NOTES = "field_Notes"
    static let FIELD_IS_NOTES = "field_IsNotes"
    static let FIELD_CHANGEABLE = "field_Changeable"
    
    // for settings
    static let SETTINGS_POWERMODE = "settings_powermode";
    static let SETTINGS_MARK_LINES = "settings_marklines";
    static let SETTINGS_MARK_NUMBERS = "settings_marknumbers";
    static let SETTINGS_MARK_ERRORS = "settings_markerrors";
    static let SETTINGS_CHECK_NOTES = "settings_checknotes";
    static let SETTINGS_SHOW_TIME = "settings_showtime";
    static let SETTINGS_COLOR = "settings_color";
    static let SETTINGS_SUPPORTER = "settings_supporter";
    
    static let instance = Data()
    
    let storage = UserDefaults.standard
    
    private init() {}
    
    func saveGame(main: MainModel) {
        storage.set(main.difficulty, forKey: Data.GAME_DIFFICULTY)
        storage.set(main.timeInt, forKey: Data.GAME_TIME)
        saveFieldModels(main.fields)
        print("saved")
    }
    
    func loadGame(main: MainModel) {
        print("load")
        main.difficulty = storage.integer(forKey: Data.GAME_DIFFICULTY)
        main.timeInt = storage.integer(forKey: Data.GAME_TIME)
        loadErrorCheck(main)
        loadFieldModels(main: main)
        print("ready loading")
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
        var sudoku = [Block]()
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
            sudoku.append(block)
        }
        print("here")
        SudokuClass.printBlocks(blocks: sudoku)
        do {
            try main.errorCheck = ErrorCheck(solution: SudokuClass(threads: 1).getSolution(sudoku: sudoku))
            try SudokuClass.printBlocks(blocks: SudokuClass(threads: 1).getSolution(sudoku: sudoku))
        } catch  {
            print(error)
            print("error") // TODO errorhandling
        }
    }
}
