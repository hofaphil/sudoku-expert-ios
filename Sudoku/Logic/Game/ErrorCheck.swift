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
    
    init(solution: [Block]) {
        self.solution = solution
    }
    
    mutating func check(model: SudokuFieldModel) -> Bool {
        return  solution[model.position.parent].getNumbers()[model.position.row][model.position.column]
            != model.number
    }
    
    mutating func unError() {
        activeErrors -= 1
        // print("active \(activeErrors) errors \(overallErrors)")
    }
    
    mutating func setError(model: SudokuFieldModel) {
        activeErrors += model.error ? 0 : 1
        overallErrors += 1
        // print("active \(activeErrors) errors \(overallErrors)")
    }
}
