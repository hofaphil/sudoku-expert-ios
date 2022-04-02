//
//  Position.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

class Position: Equatable {

    var row: Int, column: Int, block: Int

    init(block: Int, row: Int, column: Int) {
        self.row = row
        self.column = column
        self.block = block
    }

    static func ==(a: Position, b: Position) -> Bool {
        return a.row == b.row && a.column == b.column && a.block == b.block
    }
}
