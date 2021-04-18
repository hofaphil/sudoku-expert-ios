//
//  Sudoku.swift
//  Sudoku
//
//  Created by Philipp Hofer on 11.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

class SudokuClass: ObservableObject {
    
    private var blocks = [Block]()
    private var solution = [Block]()
    
    init() {}
    
    func generate(difficulty: Int) {
        let sudoku_c = new_sudoku()
        print("Free fields: \(create(sudoku_c, Int32(difficulty)))")
                
        blocks = [Block]()
        blocks.append(Block(block: (sudoku_c?.pointee.blocks.0)!))
        solution.append(Block(block: (sudoku_c?.pointee.blocks.0)!))
        blocks.append(Block(block: (sudoku_c?.pointee.blocks.1)!))
        solution.append(Block(block: (sudoku_c?.pointee.blocks.1)!))
        blocks.append(Block(block: (sudoku_c?.pointee.blocks.2)!))
        solution.append(Block(block: (sudoku_c?.pointee.blocks.2)!))
        blocks.append(Block(block: (sudoku_c?.pointee.blocks.3)!))
        solution.append(Block(block: (sudoku_c?.pointee.blocks.3)!))
        blocks.append(Block(block: (sudoku_c?.pointee.blocks.4)!))
        solution.append(Block(block: (sudoku_c?.pointee.blocks.4)!))
        blocks.append(Block(block: (sudoku_c?.pointee.blocks.5)!))
        solution.append(Block(block: (sudoku_c?.pointee.blocks.5)!))
        blocks.append(Block(block: (sudoku_c?.pointee.blocks.6)!))
        solution.append(Block(block: (sudoku_c?.pointee.blocks.6)!))
        blocks.append(Block(block: (sudoku_c?.pointee.blocks.7)!))
        solution.append(Block(block: (sudoku_c?.pointee.blocks.7)!))
        blocks.append(Block(block: (sudoku_c?.pointee.blocks.8)!))
        solution.append(Block(block: (sudoku_c?.pointee.blocks.8)!))
        
        sudoku_c?.deallocate()
    }
    
    func getSolution() -> [Block] {
        return solution
    }
    
    func setSolution(blocks: [Block]) {
        solution = blocks
    }

    func getSudoku() -> [Block] {
        return blocks
    }

    func setSudoku(blocks: [Block]) {
        self.blocks = blocks
    }
    
    static func solve(blocks: [Block]) -> [Block] {
        var solution = [Block]()
                       
        let blocks_c = UnsafeMutablePointer<block>.allocate(capacity: 9)
        
        for i in 0..<9 {
            blocks_c[i] = Block.blockToC(block: blocks[i]);
        }
        
        let solution_c = get_solution(blocks_c)

        for i in 0..<9 {
            solution.append(Block(block: solution_c![i]));
        }
        
        solution_c?.deallocate()
        return solution
    }
    
    static func printBlocks(blocks: [Block]) {
        for i in stride(from: 0, to: 8, by: 3) {
            for k in 0...2 {
                for j in i..<i + 3 {
                    for a in 0...2 {
                        print(blocks[j].getNumbers()[k][a], terminator:"");
                    }
                    print(" ", terminator:"");
                }
                print("\n", terminator:"");
            }
            print("\n", terminator:"");
        }
    }
}
