//
//  Number.swift
//  Sudoku
//
//  Created by Philipp Hofer on 11.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation

class Number: Equatable {
    
    var block, number: Int
    
    init(block: Int, number: Int) {
        self.block = block
        self.number = number
    }
    
    
    static func ==(a: Number, b: Number) -> Bool {
        return a.number == b.number && a.number == b.number;
    }
}
