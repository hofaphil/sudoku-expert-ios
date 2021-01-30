//
//  NumberCount.swift
//  Sudoku
//
//  Created by Philipp Hofer on 27.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

struct NumberCount {
    
    var numberCount = Array(repeating: 0, count: 10)
    var finished = false
    
    mutating func add(_ number: Int) {
        numberCount[number] += 1
        print(numberCount)
        if numberCount[number] == 9 {
            check()
        }
    }
    
    mutating func delete(_ number: Int) {
        numberCount[number] -= 1
    }
    
    private mutating func check() {
        for i in 1...9 {
            if numberCount[i] != 9 {
                return
            }
        }
        finished = true
    }
}
