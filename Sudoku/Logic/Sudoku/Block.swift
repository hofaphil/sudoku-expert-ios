//
//  Block.swift
//  Sudoku
//
//  Created by Philipp Hofer on 11.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

class Block {
    
    private var numbers = Array(repeating: Array(repeating: 0, count: 3), count: 3)
    private var rowPartner = Array<Block>(), columnPartner = Array<Block>()
    private var containsNumber = Array(repeating: false, count: 10)
    private var row = Array(repeating: Array(repeating: false, count: 10), count: 3)
    private var column = Array(repeating: Array(repeating: false, count: 10), count: 3)
    var latestDelIndexX: Int = -1
    var latestDelIndexZ: Int = -1
    
    init() {
    }
    
    convenience init(block: Block) {
        self.init();
        setNumbers(numbers: block.getNumbers())
    }
    
    func setRowPartner(block1: Block, block2: Block) {
        rowPartner = [Block]()
        rowPartner.append(block1)
        rowPartner.append(block2)
    }
    
    func setColumnPartner(block1: Block, block2: Block) {
        columnPartner = [Block]()
        columnPartner.append(block1)
        columnPartner.append(block2)
    }
    
    func insert(number: Int, row:Int, column: Int) -> Bool {
        if (numbers[row][column] == 0 && !blockConflict(number: number) && !lineConflict(number: number, row: row, column: column)) {
            numbers[row][column] = number
            containsNumber[number] = true
            self.row[row][number] = true
            self.column[column][number] = true
            return true
        }
        return false
    }
    
    func insertWithoutBlockConflict(number: Int, row: Int, column: Int) -> Bool {
        if (numbers[row][column] == 0 && !lineConflict(number: number, row: row, column: column)) {
            numbers[row][column] = number
            containsNumber[number] = true
            self.row[row][number] = true
            self.column[column][number] = true
            return true
        }
        return false
    }
    
    func generateRandom() {
        var row: Int, column: Int
        var i = 1
        while i < 10 {
            row = Int.random(in: 0...2)
            column = Int.random(in: 0...2)
            if (numbers[row][column] == 0) {
                numbers[row][column] = i
                containsNumber[i] = true
                self.row[row][i] = true
                self.column[column][i] = true
                i += 1
            }
        }
    }
    
    func blockConflict(number: Int) -> Bool  {
        return containsNumber[number]
    }
    
    func lineConflict(number: Int, row: Int, column: Int) -> Bool {
        return !(!rowPartner[0].hasInRow(number: number, row: row)
            && !rowPartner[1].hasInRow(number: number, row: row)
            && !columnPartner[0].hasInColumn(number: number, column: column)
            && !columnPartner[1].hasInColumn(number: number, column: column))
    }
    
    func hasInRow(number: Int, row: Int) -> Bool{
        return self.row[row][number]
    }
    
    func hasInColumn(number: Int, column: Int) -> Bool {
        return self.column[column][number]
    }
    
    func delete(number: Int) -> Bool {
        if (containsNumber[number]) {
            containsNumber[number] = false
            for i in 0...3 {
                if (row[i][number]) {
                    for j in 0...3 {
                        if (numbers[i][j] == number) {
                            numbers[i][j] = 0
                            self.row[i][number] = false
                            self.column[j][number] = false
                            latestDelIndexX = i
                            latestDelIndexZ = j
                            return true;
                        }
                    }
                }
            }
        }
        return false
    }
    
    func contains(number: Int) -> Bool{
        return containsNumber[number]
    }
    
    func deleteWithPosition(number: Int, row: Int, column: Int) {
        if (containsNumber[number]) {
            containsNumber[number] = false
            numbers[row][column] = 0
            self.row[row][number] = false
            self.column[column][number] = false
            latestDelIndexX = row
            latestDelIndexZ = column
        }
    }
    
    func getNumbers() -> [[Int]] {
        return self.numbers
    }
    
    func setNumbers(numbers: [[Int]]) {
        containsNumber = Array(repeating: false, count: 10)
        row = Array(repeating: Array(repeating: false, count: 10), count: 3)
        column = Array(repeating: Array(repeating: false, count: 10), count: 3)
        for i in 0...2 {
            for j in 0...2 {
                self.numbers[i][j] = numbers[i][j]
                containsNumber[numbers[i][j]] = true
                self.row[i][numbers[i][j]] = true
                self.column[j][numbers[i][j]] = true
            }
        }
    }
}
