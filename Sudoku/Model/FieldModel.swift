//
//  FieldModel.swift
//  Sudoku
//
//  Created by Philipp Hofer on 27.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation
import SwiftUI

struct SudokuField {
    
    var number: Int
    var color = Color.white
    var error: Bool
    var changeable = false
    
    init(number: Int, error: Bool) {
        self.number = number
        self.error = error
        if number == 0 {
            self.changeable = true
        }
    }
}

extension MainModel {
    
    func insert(number: Int) {
        if selected == nil {
            return
        }
        if get(selected!).changeable {
            if number == get(selected!).number {
                delete()
            } else {
                fields[selected!.parent][selected!.row][selected!.column].number = number
                numberCount.add(number)
                fields[selected!.parent][selected!.row][selected!.column].error = errorCheck.check(position: selected!, number: number, wasError: get(selected!).error)
            }
            select(position: selected!)
        }
    }
    
    func delete() {
        if selected == nil {
            return
        }
        if get(selected!).changeable {
            if get(selected!).error {
                errorCheck.removeError()
                fields[selected!.parent][selected!.row][selected!.column].error = false
            }
            fields[selected!.parent][selected!.row][selected!.column].number = 0
        }
        select(position: selected!)
    }
}
