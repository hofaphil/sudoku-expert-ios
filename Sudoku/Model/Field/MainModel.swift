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
    
    @Published var selected: Position?
    @Published var fields = [[[SudokuField]]]()
    
    @Published var errorCheck: ErrorCheck
    @Published var numberCount = NumberCount()
    
    static let unSelectedColor = Color.white
    static let lightSelectedColor = Color.gray
    static let selectedColor = Color.yellow
    static let errorColor = Color.red
    
    let sudoku: SudokuClass
    
    init(sudoku: SudokuClass) {
        self.sudoku = sudoku
        errorCheck = ErrorCheck(sudoku: sudoku)
        
        for i in 0...8 {
            fields.append([[SudokuField]]())
            for j in 0...2 {
                fields[i].append([SudokuField]())
                for k in 0...2 {
                    fields[i][j].append(SudokuField(number: sudoku.getSudoku()[i].getNumbers()[j][k], error: false))
                    if sudoku.getSudoku()[i].getNumbers()[j][k] != 0 {
                        numberCount.add(sudoku.getSudoku()[i].getNumbers()[j][k])
                    }
                }
            }
        }
    }
    
    func get(_ position: Position) -> SudokuField {
        return fields[position.parent][position.row][position.column]
    }
    
    func select(position: Position) {
        selected = position
        setFieldColors(position: selected!)
    }
}
