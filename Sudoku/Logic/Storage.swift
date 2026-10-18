import Foundation

class Storage {

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

    static let instance = Storage()

    let storage = UserDefaults.standard

    func saveGame(main: MainModel) {
        storage.set(main.difficulty.rawValue, forKey: Storage.GAME_DIFFICULTY)
        storage.set(main.timeInt, forKey: Storage.GAME_TIME)
        storage.set(storage.bool(forKey: Storage.SETTINGS_SHOW_TIME), forKey: Storage.GAME_SHOW_TIME)
        storage.set(storage.bool(forKey: Storage.SETTINGS_SHOW_ERRORS), forKey: Storage.GAME_SHOW_ERRORS)

        // save the game itself
        do {
            try storage.set(JSONEncoder().encode(main.game), forKey: Storage.GAME)
        } catch {
            // TODO error handling
        }
    }

    func loadGame(main: MainModel) {
        main.difficulty = Difficulty.getDifficulty(intVal: storage.integer(forKey: Storage.GAME_DIFFICULTY))
        main.timeInt = storage.integer(forKey: Storage.GAME_TIME)

        // load the game itself
        if let json = storage.data(forKey: Storage.GAME) {
            do {
                main.game = try JSONDecoder().decode(Sudoku.self, from: json)
            } catch {
                // TODO error handling
            }
        }
    }

    func saveStatistics(statistics: Statistics) {
        do {
            try storage.set(JSONEncoder().encode(statistics), forKey: Storage.STATISTICS)
        } catch {
            // TODO error handling
        }
    }

    func loadStatistics() -> Statistics {
        if let json = storage.data(forKey: Storage.STATISTICS) {
            do {
                return try JSONDecoder().decode(Statistics.self, from: json)
            } catch {
                // TODO error handling
            }
        }
        return Statistics()
    }
}
