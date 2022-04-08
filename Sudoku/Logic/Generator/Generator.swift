//
//  Generator.swift
//  Sudoku
//
//  Created by Philipp Hofer on 24.03.22.
//  Copyright © 2022 Philipp Hofer. All rights reserved.
//

import Foundation

class Generator {

    static func createSudoku(freeFields: Int32) -> Sudoku {
        let s = new_sudoku()
        create(s, freeFields)

        let game = Sudoku()

        let blocks = getBlockArray(block: s!.pointee.blocks)
        let solution = getBlockArray(block: s!.pointee.solution)

        for b in 0..<9 {
            let numbers = getNumberArray(number: blocks[b].numbers)
            let solutions = getNumberArray(number: solution[b].numbers)
            for r in 0..<3 {
                for c in 0..<3 {
                    let number = numbers[r][c]
                    let solution = solutions[r][c]
                    let changeable = number == 0
                    let n = Number(number: Int(number), solution: Int(solution), isChangeable: changeable)
                    game.setNumber(position: Position(block: b, row: r, column: c), number: n)
                }
            }
        }

        return game
    }

    static func solveSudoku(sudoku: inout Sudoku) {
        let s = new_sudoku()

        var blocks = getBlockArray(block: s!.pointee.blocks)

        blocks.withUnsafeMutableBufferPointer({ (cBlocks: inout UnsafeMutableBufferPointer<block>) -> () in
            for b in 0..<9 {
                var numbers = Array(repeating: Array(repeating: Int32(0), count: 3), count: 3)
                for r in 0..<3 {
                    for c in 0..<3 {
                        numbers[r][c] = Int32(sudoku.getNumber(position: Position(block: b, row: r, column: c)).number)
                    }
                }
                cBlocks[b].numbers = getNumberTuple(numbers: numbers);
            }
            set_sudoku(s, cBlocks.baseAddress)
        })

        solve(s);

        let solution = getBlockArray(block: s!.pointee.blocks)

        for b in 0..<9 {
            let solutions = getNumberArray(number: solution[b].numbers)
            for r in 0..<3 {
                for c in 0..<3 {
                    let solution = solutions[r][c]
                    let n = sudoku.getNumber(position: Position(block: b, row: r, column: c))
                    n.solution = Int(solution)
                }
            }
        }
    }

    private static func getNumberArray(number: ((Int32, Int32, Int32), (Int32, Int32, Int32), (Int32, Int32, Int32))) -> [[Int32]] {
        [[number.0.0, number.0.1, number.0.2], [number.1.0, number.1.1, number.1.2], [number.2.0, number.2.1, number.2.2]]
    }

    private static func getNumberTuple(numbers: [[Int32]]) -> ((Int32, Int32, Int32), (Int32, Int32, Int32), (Int32, Int32, Int32)) {
        ((numbers[0][0], numbers[0][1], numbers[0][2]), (numbers[1][0], numbers[1][1], numbers[1][2]), (numbers[2][0], numbers[2][1], numbers[2][2]))
    }

    private static func getBlockArray(block: (block, block, block, block, block, block, block, block, block)) -> [block] {
        [block.0, block.1, block.2, block.3, block.4, block.5, block.6, block.7, block.8]
    }

}
