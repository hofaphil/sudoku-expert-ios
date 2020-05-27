//
//  ErrorCheck.swift
//  Sudoku
//
//  Created by Philipp Hofer on 27.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

struct ErrorCheck {
    
    var activeErrors = 0
    var overallErrors = 0
    var solution: [Block]
    
    init(sudoku: SudokuClass) {
        self.solution = sudoku.getSolution()
    }
    
    mutating func check(position: Position, number: Int, wasError: Bool) -> Bool {
        if solution[position.parent].getNumbers()[position.row][position.column] == number {
            activeErrors -= wasError ? 1 : 0
            return false
        } else {
            activeErrors += wasError ? 0 : 1
            overallErrors += 1
            return true
        }
    }
    
    mutating func removeError() {
        activeErrors -= 1
    }
}
