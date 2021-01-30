//
//  FieldModel.swift
//  Sudoku
//
//  Created by Philipp Hofer on 27.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation
import SwiftUI

class SudokuFieldModel: ObservableObject {
    
    var main: MainModel
    
    @Published var number: Int
    @Published var position: Position
    @Published var color = Color.white
    @Published var error: Bool
    
    @Published var changeable = false
    @Published var isNotes = false
    
    @Published var notes = [Bool](repeating: false, count: 9)
    
    init(main: MainModel, position: Position, number: Int, error: Bool) {
        self.main = main
        self.number = number
        self.position = position
        self.error = error
        if number == 0 {
            self.changeable = true
        }
    }
    
    func insert(_ number: Int) {
        if !changeable {
            return
        }
        isNotes = main.isNotes
        if isNotes {
            notes[number - 1] = !notes[number - 1]
        } else {
            if number == self.number {
                delete()
            } else {
                self.number = number
                main.numberCount.add(number)
                if main.errorCheck!.check(model: self) {
                    setError()
                }
            }
            // TODO: Anzahl der freien Felder verringern
        }
    }
    
    func delete() {
        if !changeable {
            return
        }
        if error {
            unError()
        }
        isNotes = main.isNotes
        if isNotes {
            notes = [Bool](repeating: false, count: 9)
        } else {
            number = 0
            main.numberCount.delete(number)
        }
        // TODO: Anzahl der freien Felder erhöhen
    }
    
    func setError() {
        main.errorCheck!.setError(model: self)
        error = true
        color = MainModel.errorColor
    }
    
    func unError() {
        main.errorCheck!.unError()
        error = false
        color = MainModel.selectedColor
    }
}
