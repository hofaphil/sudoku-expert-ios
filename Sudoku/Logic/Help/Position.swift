//
//  Position.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

class Position: Equatable {
    
    var row: Int, column: Int, parent: Int
    
    init(row: Int, column: Int, parent: Int) {
        self.row = row
        self.column = column
        self.parent = parent
    }
    
    static func ==(a: Position, b: Position) -> Bool {
        return a.row == b.row && a.column == b.column && a.parent == b.parent
    }
}
