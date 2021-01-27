//
//  SudokuGrid.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SudokuGridView: View {
    
    let sudoku: SudokuClass
    var blocks: [SudokuBlockView]
    
    init(sudoku: SudokuClass) {
        self.sudoku = sudoku
        blocks = [SudokuBlockView]()
        for i in 0...8 {
            blocks.append(SudokuBlockView(parent: i, block: sudoku.getSudoku()[i]))
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                blocks[0]
                blocks[1]
                blocks[2]
            }
            HStack(spacing: 0) {
                blocks[3]
                blocks[4]
                blocks[5]
            }
            HStack(spacing: 0) {
                blocks[6]
                blocks[7]
                blocks[8]
            }
        }
    }
}

struct SudokuGrid_Previews: PreviewProvider {
    static var previews: some View {
        SudokuGridView(sudoku: SudokuClass(threads: 1))
    }
}
