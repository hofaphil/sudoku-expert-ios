//
//  SudokuModel.swift
//  Sudoku
//
//  Created by Philipp Hofer on 26.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation
import SwiftUI

class FieldModel: ObservableObject {
    
    @Published var selected: Position?
    
    @Published var numbers: NumberModel
    @Published var changeable: ChangeabelModel
    @Published var errors: ErrorModel
    @Published var colors: ColorModel
        
    static let unSelectedColor = Color.white
    static let lightSelectedColor = Color.gray
    static let selectedColor = Color.yellow
    static let errorColor = Color.red
    
    let sudoku: SudokuClass
    
    init(sudoku: SudokuClass) {
        self.sudoku = sudoku
        errorCheck = ErrorCheck(sudoku: sudoku)
        
        var numArr: [[[Int]]]
        var errArr: [[[Bool]]]
        
        for i in 0...8 {
            numArr.append([[Int]]())
            errArr.append([[Bool]]())
            for j in 0...2 {
                numArr[i].append([Int]())
                for k in 0...2 {
                    numArr[i][j].append(SudokuField(number: sudoku.getSudoku()[i].getNumbers()[j][k]))
                    if sudoku.getSudoku()[i].getNumbers()[j][k] != 0 {
                        numberCount.add(sudoku.getSudoku()[i].getNumbers()[j][k])
                    }
                }
            }
        }
    }
    
    func select(position: Position) {
        selected = position
        setFieldColors(position: selected!)
    }
}
