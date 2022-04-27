//
//  Data.swift
//  Sudoku
//
//  Created by Philipp Hofer on 08.07.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

class Data {

    static let LOAD_MODE = "load_mode"

    // for game
    static let GAME_ERRORS = "game_errors"
    static let GAME_DIFFICULTY = "game_difficulty"
    static let GAME_TIME = "game_time"
    static let GAME_SHOW_ERRORS = "game_main_show_errors"
    static let GAME_SHOW_TIME = "game_main_show_time"
    static let GAME = "game"

    // for settings
    static let SETTINGS_MARK_LINES = "settings_mark_lines"
    static let SETTINGS_MARK_NUMBERS = "settings_mark_numbers"
    static let SETTINGS_CHECK_NOTES = "settings_check_notes"
    static let SETTINGS_SHOW_ERRORS = "settings_mark_errors"
    static let SETTINGS_SHOW_TIME = "settings_show_time"
    static let SETTINGS_COLOR = "settings_color"

    // for statistics
    static let STATISTICS = "statistics"

    static let instance = Data()

    let storage = UserDefaults.standard

    func saveGame(main: MainModel) {
        storage.set(main.difficulty.rawValue, forKey: Data.GAME_DIFFICULTY)
        storage.set(main.timeInt, forKey: Data.GAME_TIME)
        storage.set(storage.bool(forKey: Data.SETTINGS_SHOW_TIME), forKey: Data.GAME_SHOW_TIME)
        storage.set(storage.bool(forKey: Data.SETTINGS_SHOW_ERRORS), forKey: Data.GAME_SHOW_ERRORS)

        // save the game itself
        do {
            try storage.set(JSONEncoder().encode(main.game), forKey: Data.GAME)
        } catch {
            // TODO error handling
        }
    }

    func loadGame(main: MainModel) {
        main.difficulty = Difficulty.getDifficulty(intVal: storage.integer(forKey: Data.GAME_DIFFICULTY))
        main.timeInt = storage.integer(forKey: Data.GAME_TIME)

        // load the game itself
        let jsonString = storage.data(forKey: Data.GAME)
        if ((jsonString) != nil) {
            do {
                main.game = try JSONDecoder().decode(Sudoku.self, from: jsonString!)
            } catch {
                // TODO error handling
            }
        }
    }

    func saveStatistics(statistics: Statistics) {
        do {
            try storage.set(JSONEncoder().encode(statistics), forKey: Data.STATISTICS)
        } catch {
            // TODO error handling
        }
    }

    func loadStatistics() -> Statistics {
        let jsonString = storage.data(forKey: Data.STATISTICS)
        if ((jsonString) != nil) {
            do {
                return try JSONDecoder().decode(Statistics.self, from: jsonString!)
            } catch {
                // TODO error handling
            }
        }
        return Statistics()
    }
}
