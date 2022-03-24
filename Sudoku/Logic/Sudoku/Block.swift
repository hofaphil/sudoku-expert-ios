//
//  Block.swift
//  Sudoku
//
//  Created by Philipp Hofer on 24.03.22.
//  Copyright © 2022 Philipp Hofer. All rights reserved.
//

import Foundation

class Block: Equatable {

    private var numbers: [[Number]];

    init() {
        numbers = Array(repeating: Array(repeating: Number(), count: 3), count: 3)
    }

    func insert(number: Int, position: Position, note: Bool) -> Bool {
        return numbers[position.row][position.column].insert(number: number, note: note)
    }

    func delete(position: Position) {
        numbers[position.row][position.column].delete()
    }

    func getNumbers() -> [[Number]] {
        return numbers;
    }

    func getNumber(row: Int, column: Int) -> Number {
        return numbers[row][column]
    }

    func setNumber(row: Int, column: Int, number: Number) {
        numbers[row][column] = number;
    }
    
    static func ==(a: Block, b: Block) -> Bool {
        for i in Range(0...3) {
            for j in Range(0...3) {
                if (!(a.numbers[i][j] == b.numbers[i][j])) {
                    return false
                }
            }
        }
        return true;
    }
}
