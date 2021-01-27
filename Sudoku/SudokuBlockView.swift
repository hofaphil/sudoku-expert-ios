//
//  SudokuBlock.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SudokuBlockView: View {
    
    var parent: Int
    var block: Block
        
    @EnvironmentObject var main: MainModel
    
    init(parent: Int, block: Block) {
        self.parent = parent
        self.block = block
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                SudokuFieldView(model: main.fields[parent][0][0])
                SudokuFieldView(model: main.fields[parent][0][1])
                SudokuFieldView(model: main.fields[parent][0][2])
            }
            HStack(spacing: 0) {
                SudokuFieldView(model: main.fields[parent][1][0])
                SudokuFieldView(model: main.fields[parent][1][1])
                SudokuFieldView(model: main.fields[parent][1][2])
            }
            HStack(spacing: 0) {
                SudokuFieldView(model: main.fields[parent][2][0])
                SudokuFieldView(model: main.fields[parent][2][1])
                SudokuFieldView(model: main.fields[parent][2][2])
            }
        }.padding(3)
    }
}


struct SudokuBlock_Previews: PreviewProvider {
    static var previews: some View {
        SudokuBlockView(parent: 0, block: Block())
    }
}
