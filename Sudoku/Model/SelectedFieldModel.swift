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
    
    @Published var selected: SudokuFieldView?
    @Published var fields: [[[SudokuField]]]
        
    static let unSelectedColor = Color.white
    static let lightSelectedColor = Color.gray
    static let selectedColor = Color.yellow
    
    
    /*
     func insert(number: Int) {
     if !selected.changeable {
     return
     }
     // TODO
     //        if (mainActivity.isNotes() != isNotes) {
     //            delete();
     //            isNotes = !isNotes;
     //            switchLayout(isNotes);
     //        }
     if isNotes() {
     if notes[number - 1] {
     deleteNote(number: number)
     } else {
     addNote(number: number)
     }
     } else {
     if self.number == number {
     delete()
     }
     if !checkNumber(number: number) {
     setError()
     }
     setNumber(number: number)
     }
     }
     
     func delete() {
     
     }*/
    
    func select(sudokuFieldView: SudokuFieldView) {
        self.selected = sudokuFieldView
        setFieldColors()
    }
}

struct SudokuField {
    
    var number = 0
    var color = Color.white
    var error = false
    var changeable = false
    
}
