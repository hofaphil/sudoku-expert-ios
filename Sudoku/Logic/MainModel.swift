import Foundation
import SwiftUI

class MainModel: ObservableObject {

    @Published var game = Sudoku()

    @Published var selected: Position?
    @Published var isNotes: Bool = false
    @Published var pause = false
    @Published var fieldTypes: [[[FieldType]]] = []

    @Published var difficulty = Difficulty.ADVANCED

    var timer = Timer()
    var timeInt = 0
    var timerRun = true
    @Published var time = "00:00"

    @Published var wonGame = false
    @Published var lostGame = false

    @Published var loading = false
    
    init(difficulty: Int = 0) {
        if UserDefaults.standard.bool(forKey: Storage.LOAD_MODE) {
            Storage.instance.loadGame(main: self)
            startTimer(time: timeInt)
        } else {
            startNewGame(difficulty: Difficulty.ADVANCED)
        }
        initFieldTypes()
    }

    func startNewGame(difficulty: Difficulty) {
        if loading {
            return
        }
        loading = true
        wonGame = false
        lostGame = false

        DispatchQueue.main.async {
            self.difficulty = difficulty

            self.game = Generator.createSudoku(freeFields: Int32(Difficulty.getFreeFields(difficulty: difficulty)))

            self.startNewGame()
            self.loading = false
        }
    }

    private func startNewGame() {
        UserDefaults.standard.set(UserDefaults.standard.bool(forKey: Storage.SETTINGS_SHOW_TIME), forKey: Storage.GAME_SHOW_TIME)
        UserDefaults.standard.set(UserDefaults.standard.bool(forKey: Storage.SETTINGS_SHOW_ERRORS), forKey: Storage.GAME_SHOW_ERRORS)

        selected = nil
        setFieldTypes()

        startTimer(time: 0)
        UserDefaults.standard.set(true, forKey: Storage.LOAD_MODE)
    }

    func select(position: Position) {
        selected = position
        setFieldTypes()
    }

    func insert(number: Int) {
        guard let selected = selected else {
            return
        }
        let field = game.getNumber(position: selected)
        let canClearNotes = field.isChangeable && number != field.number
        game.insert(number: number, position: selected, note: isNotes)
        // only clear notes of related fields once the correct number was placed
        if canClearNotes && field.number == number && !field.isError() {
            checkNotes(position: selected, number: number)
        }
        checkGameStatus()
        setFieldTypes()
    }

    func delete() {
        guard let selected = selected else {
            return
        }
        game.delete(position: selected)
        setFieldTypes()
    }

    func checkGameStatus() {
        if game.freeFields() == 0 && game.currentErrors() == 0 {
            wonGame = true
            let stats = Storage.instance.loadStatistics()
            stats.addGame(difficulty: difficulty, time: timeInt)
            Storage.instance.saveStatistics(statistics: stats)
        }
        if UserDefaults.standard.bool(forKey: Storage.GAME_SHOW_ERRORS) && game.overallErrors >= 3 {
            lostGame = true
        }
    }
}
