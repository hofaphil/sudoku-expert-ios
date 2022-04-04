//
//  SudokuModel.swift
//  Sudoku
//
//  Created by Philipp Hofer on 26.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation
import SwiftUI

class MainModel: ObservableObject {

    @Published var game = Sudoku()

    @Published var selected: Position?
    @Published var isNotes: Bool = false
    @Published var pause = false

    @Published var difficulty = Difficulty.ADVANCED

    @Published var showErrors = UserDefaults.standard.bool(forKey: Data.GAME_SHOW_ERRORS)

    var timer = Timer()
    var timeInt = 0
    var timerRun = true
    @Published var time = "00:00"
    @Published var showTime = UserDefaults.standard.bool(forKey: Data.GAME_SHOW_TIME)

    @Published var loading = false
    @Published var appColor = Color(UserDefaults.standard.string(forKey: Data.SETTINGS_COLOR)!)

    static let unSelectedColor = Color.white
    static let lightSelectedColor = Color("DimGray")
    static let errorColor = Color("Red")

    init(difficulty: Int = 0) {
        if (UserDefaults.standard.bool(forKey: Data.LOAD_MODE)) {
            do {
                try Data.instance.loadGame(main: self)
            } catch {
                // TODO error handling
            }
            startTimer(time: timeInt)
        } else {
            startNewGame(difficulty: Difficulty.ADVANCED)
        }
    }

    func startNewGame(difficulty: Difficulty) {
        if loading {
            return
        }
        loading = true

        DispatchQueue.main.async {
            self.difficulty = difficulty

            self.game = Generator.createSudoku(freeFields: Int32(Difficulty.getFreeFields(difficulty: difficulty)))

            self.startNewGame()
            self.loading = false
        }
    }

    private func startNewGame() {
        showTime = UserDefaults.standard.bool(forKey: Data.SETTINGS_SHOW_TIME)
        showErrors = UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_ERRORS)
        print(showErrors)

        startTimer(time: 0)
        UserDefaults.standard.set(true, forKey: Data.LOAD_MODE)
    }

    func select(position: Position) {
        selected = position
        // setFieldColors(position: position)
    }

    func insert(number: Int) {
        if ((selected) != nil) {
            checkNotes(position: selected!, number: number)
            game.insert(number: number, position: selected!, note: isNotes)
            // TODO: check if game is solved
        }
    }

    func delete() {
        if ((selected) != nil) {
            game.delete(position: selected!)
            // TODO: check if error-limit is reached
        }
    }

    func changeColor(_ color: Color) {
        appColor = color
    }
}
