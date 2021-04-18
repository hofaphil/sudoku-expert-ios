//
//  Block.swift
//  Sudoku
//
//  Created by Philipp Hofer on 11.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

class Block {
    
    private var numbers: [[Int32]] = Array(repeating: Array(repeating: 0, count: 3), count: 3)
    
    init() {}
    
    init(numbers: [[Int32]]) {
        setNumbers(numbers: numbers)
    }
    
    init(block: block) {
        self.numbers[0][0] = block.numbers.0.0
        self.numbers[0][1] = block.numbers.0.1
        self.numbers[0][2] = block.numbers.0.2
        self.numbers[1][0] = block.numbers.1.0
        self.numbers[1][1] = block.numbers.1.1
        self.numbers[1][2] = block.numbers.1.2
        self.numbers[2][0] = block.numbers.2.0
        self.numbers[2][1] = block.numbers.2.1
        self.numbers[2][2] = block.numbers.2.2
    }
    
    func getNumbers() -> [[Int32]] {
        return self.numbers
    }
    
    func setNumbers(numbers: [[Int32]]) {
        for i in 0..<3 {
            for j in 0..<3 {
                self.numbers[i][j] = numbers[i][j]
            }
        }
    }
    
    static func blockToC(block: Block) -> block {
        var block_c = new_block()
        
        let numbersInt: [[Int32]] = block.getNumbers()

        var t = numbersInt.reduce([]) { (r, row) -> [(Int32, Int32, Int32)] in
            var r = r
            r.append((row[0], row[1], row[2]))
            return r
        }

        t.withUnsafeMutableBufferPointer { (buffer) -> () in
            let p = buffer.baseAddress
            set_numbers(&block_c, p)
        }
        
        return block_c
    }
}
