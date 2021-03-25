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
    
    @Published var selected: SudokuFieldModel?
    @Published var isNotes: Bool = false
    
    var fields = [[[SudokuFieldModel]]]()
    
    @Published var difficulty = Difficulty.ADVANCED
    
    @Published var numberCount = NumberCount()

    @Published var errorCheck: ErrorCheck?
    @Published var showErrors = UserDefaults.standard.bool(forKey: Data.GAME_SHOW_ERRORS)
    
    var timer = Timer()
    var timeInt = 0
    var timerRun = true
    @Published var time = "00:00"
    @Published var showTime = UserDefaults.standard.bool(forKey: Data.GAME_SHOW_TIME)
    
    @Published var pause = false
    @Published var loading = false
    @Published var appColor = Color(UserDefaults.standard.string(forKey: Data.SETTINGS_COLOR)!)
    
    static let unSelectedColor = Color.white
    static let lightSelectedColor = Color(.systemGray3)
    static let errorColor = Color.red
    
    var sudoku = SudokuClass(threads: 1)
    
    init(difficulty: Int = 0) {
        if (UserDefaults.standard.bool(forKey: Data.LOAD_MODE)) {
            print("load game")
            Data.instance.loadGame(main: self)
            startTimer(time: timeInt)
        } else {
            print("start game")
            startNewGame(difficulty: Difficulty.ADVANCED)
        }
    }
    
    func startNewGame(difficulty: Difficulty) {
        if loading {
            return
        }
        
        self.loading = true
        
        numberCount = NumberCount()
        self.difficulty = difficulty
        
        DispatchQueue.global(qos: .background).async {
            self.sudoku = SudokuClass(threads: 1)
            self.sudoku.create(difficulty: difficulty.rawValue)
            usleep(2000000)
            
            DispatchQueue.main.sync {
                self.startNewGame()
                self.loading = false
            }
        }
        
        /*loading = false
        numberCount = NumberCount()
        sudoku = SudokuClass(threads: 1)
        sudoku.create(difficulty: difficulty.rawValue)
        self.difficulty = difficulty
        
        startNewGame()*/
    }
    
    func startNewGame() {
        numberCount = NumberCount()
        
        errorCheck = ErrorCheck(solution: sudoku.getSolution())
        
        fields = [[[SudokuFieldModel]]]()
        for i in 0...8 {
            fields.append([[SudokuFieldModel]]())
            for j in 0...2 {
                fields[i].append([SudokuFieldModel]())
                for a in 0...2 {
                    fields[i][j].append(SudokuFieldModel(main: self, position: Position(row: j, column: a, parent: i),number: sudoku.getSudoku()[i].getNumbers()[j][a], error: false))
                }
            }
        }
                
        showTime = UserDefaults.standard.bool(forKey: Data.SETTINGS_SHOW_TIME)
        showErrors = UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_ERRORS)
        print(showErrors)
        
        startTimer(time: 0)
        UserDefaults.standard.set(true, forKey: Data.LOAD_MODE)
    }
    
    func select(model: SudokuFieldModel) {
        selected = model
        setFieldColors(position: model.position)
    }
    
    func changeColor(_ color: Color) {
        appColor = color
    }
}
