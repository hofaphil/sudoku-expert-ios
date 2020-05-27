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
    var fields: [[SudokuFieldView]]
        
    init(parent: Int, block: Block) {
        self.parent = parent
        self.block = block
        
        fields = [[SudokuFieldView]]()
        for i in 0...2 {
            fields.append([SudokuFieldView]())
            for j in 0...2 {
                fields[i].append(SudokuFieldView(position: Position(row: i, column: j, parent: parent)))
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                //Text(selectedFieldModel.s)
                fields[0][0]
                fields[0][1]
                fields[0][2]
            }
            HStack {
                fields[1][0]
                fields[1][1]
                fields[1][2]
            }
            HStack {
                fields[2][0]
                fields[2][1]
                fields[2][2]
            }
        }.border(Color.black)
    }
}


struct SudokuBlock_Previews: PreviewProvider {
    static var previews: some View {
        SudokuBlockView(parent: 0, block: Block())
    }
}
