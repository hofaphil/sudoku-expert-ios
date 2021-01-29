//
//  Sudoku.swift
//  Sudoku
//
//  Created by Philipp Hofer on 11.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

class SudokuClass: ObservableObject {
    
    private let THREADCOUNT: Int
    private var blocks = [Block]()
    private var solution = [Block]()
    private var threadBlocks = [[Block]]()
    private var solutionFlag: Int
    
    init(threads: Int) {
        THREADCOUNT = threads
        solutionFlag = -1
        
        for _ in 0...8 {
            blocks.append(Block())
            solution.append(Block())
        }
        
        for i in 0...THREADCOUNT {
            var arr = [Block]()
            for _ in 0...8 {
                arr.append(Block())
            }
            threadBlocks.append(arr)
            initBlock(block: &threadBlocks[i])
        }
        
        initBlock(block: &blocks)
    }
    
    func create(difficulty: Int) {
        blocks[0].generateRandom()
        blocks[4].generateRandom()
        blocks[8].generateRandom()
                
        var _ = generate(number: 1, block: 1)
        
        for i in 0...8 {
            solution[i] = Block(block: blocks[i])
        }
        
        for j in 0...THREADCOUNT-1 {
            for i in 0...8 {
                threadBlocks[j][i].setNumbers(numbers: blocks[i].getNumbers())
            }
        }
        
        solutionFlag = -1;
        
        deleteNumbers(threadNumber: 0, difficulty: difficulty, threadHolder: threadBlocks[0])
            
        for i in 0...8 {
            blocks[i].setNumbers(numbers: threadBlocks[0][i].getNumbers())
        }
        
        
        /* THREADS LATER
         for i in 0...THREADCOUNT-1 {
         DispatchQueue.global(qos: .background).async {
         deleteNumbers(i, difficulty, threadBlocks[i])
         }
         }*/
    }
    
    func deleteNumbers(threadNumber: Int, difficulty: Int, threadHolder: [Block]) {
        var b = 0
        
        //let diff = difficulty * 7 + 40
        let diff = 2

        var numbers = [Number]()
        for i in 0...8 {
            for j in 0...2 {
                for k in 0...2 {
                    numbers.append(Number(block: i,  number: threadHolder[i].getNumbers()[j][k]))
                }
            }
        }
        numbers.shuffle()
        while solutionFlag == -1 {
            while (b < diff && !numbers.isEmpty) && solutionFlag == -1 {
                let index: Int = numbers[0].block
                let number: Int = numbers[0].number
                numbers.remove(at: 0);
                
                let holder: Block = Block(block: threadHolder[index])
                if threadHolder[index].delete(number: number) && solutionFlag == -1 {
                    b += 1;
                    if (!checkSolutions(index: index, x: threadHolder[index].latestDelIndexX, z: threadHolder[index].latestDelIndexZ, number: number, holderNum: threadHolder)) {
                        threadHolder[index].setNumbers(numbers: holder.getNumbers())
                        b  -= 1;
                    }
                }
            }
            if solutionFlag == -1 {
                solutionFlag = threadNumber
            }
        }
    }
    
    func initBlock(block: inout [Block]) {
        block[0].setRowPartner(block1: block[1], block2: block[2])
        block[0].setColumnPartner(block1: block[3], block2: block[6])
        
        block[1].setRowPartner(block1: block[0], block2: block[2])
        block[1].setColumnPartner(block1: block[4], block2: block[7])
        
        block[2].setRowPartner(block1: block[0], block2: block[1])
        block[2].setColumnPartner(block1: block[5], block2: block[8])
        
        block[3].setRowPartner(block1: block[4], block2: block[5])
        block[3].setColumnPartner(block1: block[0], block2: block[6])
        
        block[4].setRowPartner(block1: block[3], block2: block[5])
        block[4].setColumnPartner(block1: block[1], block2: block[7])
        
        block[5].setRowPartner(block1: block[3], block2: block[4])
        block[5].setColumnPartner(block1: block[2], block2: block[8])
        
        block[6].setRowPartner(block1: block[7], block2: block[8])
        block[6].setColumnPartner(block1: block[0], block2: block[3])
        
        block[7].setRowPartner(block1: block[6], block2: block[8])
        block[7].setColumnPartner(block1: block[1], block2: block[4])
        
        block[8].setRowPartner(block1: block[6], block2: block[7])
        block[8].setColumnPartner(block1: block[2], block2: block[5])
    }
    
    func checkSolutions(index: Int, x: Int, z: Int, number: Int, holderNum: [Block]) -> Bool {
        var holder = [Block]()
        for i in 0...8 {
            holder.append(Block(block: holderNum[i]))
        }
        
        for j in 1...9 {
            if solutionFlag != -1 {
                return true
            }
            if j == number {
                continue
            }
            if holderNum[index].insert(number: j, row: x, column: z) {
                if solve(blocks: holderNum, number: 1, block: 0) {
                    for i in 0...8 {
                        holderNum[i].setNumbers(numbers: holder[i].getNumbers())
                    }
                    return false
                }
                holderNum[index].setNumbers(numbers: holder[index].getNumbers());
            }
        }
        return true;
    }
    
    func solve(blocks: [Block], number: Int, block: Int) -> Bool {
        print("new run \(number)")
        SudokuClass.printBlocks(blocks: blocks)
        if number == 10 || solutionFlag != -1 {
            return true
        }
        
        if blocks[block].contains(number: number) {
            return solve(blocks: blocks, number: block == 8 ? number + 1 : number, block: block == 8 ? 0 : block + 1)
        }
        
        var counter: Int = 0
        var ready: Bool
        var r: Int = 0, c: Int = 0
        
        repeat {
            blocks[block].deleteWithPosition(number: number, row: r, column: c)
            c = (c + 1) % 3
            if c == 0 {
                r = (r + 1) % 3
            }
            while !blocks[block].insertWithoutBlockConflict(number: number, row: r, column: c) && counter < 9 {
                counter += 1
                c = (c + 1) % 3
                if c == 0 {
                    r = (r + 1) % 3
                }
            }
            
            if counter >= 9 {
                blocks[block].deleteWithPosition(number: number, row: r, column: c)
                return false
            }
            
            ready = solve(blocks: blocks, number: block == 8 ? number + 1 : number, block: block == 8 ? 0 : block + 1);
        } while !ready && solutionFlag == -1
        return true
    }
    
    func generate(number: Int, block: Int) -> Bool {
        if number == 10 {
            return true
        }
        var counter: Int = 0;
        var ready: Bool
        var r = Int.random(in: 0...2), c = Int.random(in: 0...2);
        
        repeat {
            var _ = blocks[block].delete(number: number);
            c = (c + 1) % 3
            if c == 0 {
                r = (r + 1) % 3
            }
            while !blocks[block].insert(number: number, row: r, column: c) && counter < 9 {
                counter += 1
                c = (c + 1) % 3
                if c == 0 {
                    r = (r + 1) % 3
                }
            }
            if counter >= 9 {
                return false
            }
            if block == 7 {
                ready = generate(number: number + 1, block: 1)
            }
            else if block == 3 {
                ready = generate(number: number, block: block + 2)
            }
            else {
                ready = generate(number: number, block: block + 1)
            }
        } while !ready
        return true
    }
    
    func getSolution() -> [Block] {
        return solution
    }
    
    func getSolution(sudoku: [Block]) throws -> [Block] {
        solutionFlag = -1;
        var solution = [Block]();
        for _ in 0...8 {
            solution.append(Block())
        }
        initBlock(block: &solution)
        for i in 0...8 {
            solution[i].setNumbers(numbers: sudoku[i].getNumbers())
        }

        if !solve(blocks: solution, number: 1, block: 0) {
            throw SudokuError.MoreThanOneSolution
        }

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
