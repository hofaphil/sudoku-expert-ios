//
//  Sudoku.swift
//  Sudoku
//
//  Created by Philipp Hofer on 24.03.22.
//  Copyright © 2022 Philipp Hofer. All rights reserved.
//

import Foundation

class Sudoku: Equatable, Codable {

    var blocks: [Block]
    var overallErrors: Int = 0

    init() {
        blocks = []
        for _ in 0...8 {
            blocks.append(Block())
        }
    }

    func insert(number: Int, position: Position, note: Bool) {
        if (!blocks[position.block].insert(number: number, position: position, note: note)) {
            overallErrors += 1
        }
    }

    func delete(position: Position) {
        blocks[position.block].delete(position: position)
    }

    func freeFields() -> Int {
        var freeFields = 0;
        for k in 0..<9 {
            for i in 0..<3 {
                for j in 0..<3 {
                    if (getNumber(position: Position(block: k, row: i, column: j)).number == 0) {
                        freeFields += 1
                    }
                }
            }
        }
        return freeFields
    }

    func currentErrors() -> Int {
        var currentErrors = 0;
        for k in 0..<9 {
            for i in 0..<3 {
                for j in 0..<3 {
                    if (getNumber(position: Position(block: k, row: i, column: j)).isError()) {
                        currentErrors += 1
                    }
                }
            }
        }
        return currentErrors
    }

    func getNumber(position: Position) -> Number {
        blocks[position.block].getNumber(row: position.row, column: position.column)
    }

    func setNumber(position: Position, number: Number) {
        blocks[position.block].setNumber(row: position.row, column: position.column, number: number)
    }

    func getSudoku() -> [Block] {
        blocks
    }

    static func ==(a: Sudoku, b: Sudoku) -> Bool {
        for block in 0..<9 {
            if (!(a.blocks[block] == b.blocks[block])) {
                return false
            }
        }
        return a.overallErrors == b.overallErrors
    }
}
