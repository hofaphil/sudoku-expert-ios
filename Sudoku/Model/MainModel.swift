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
    
    @Published var difficulty = 0 // 0 = Beginner, 1 = Advanced, 2 = Expert
    
    @Published var errorCheck: ErrorCheck?
    var numberCount = NumberCount()
    
    var timer = Timer()
    var timeInt = 0
    @Published var time = "00:00"
    
    static let unSelectedColor = Color.white
    static let lightSelectedColor = Color.gray
    static let selectedColor = Color.yellow
    static let errorColor = Color.red
    
    var sudoku = SudokuClass(threads: 1)
    
    init(difficulty: Int = 0) {
        if (UserDefaults.standard.bool(forKey: Data.LOAD_MODE)) {
            Data.instance.loadGame(main: self)
        } else {
            startNewGame()
        }
    }
    
    func startNewGame(difficulty: Int = 0) {
        sudoku = SudokuClass(threads: 1)
        sudoku.create(difficulty: self.difficulty)
        
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
        start(time: 0)
        UserDefaults.standard.set(true, forKey: Data.LOAD_MODE)
    }
    
    func select(model: SudokuFieldModel) {
        selected = model
        setFieldColors(position: model.position)
    }
}
