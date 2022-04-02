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
    let padding: CGFloat = 2

    @EnvironmentObject var main: MainModel

    init(parent: Int, block: Block) {
        self.parent = parent
        self.block = block
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                SudokuFieldView(Position(block: parent, row: 0, column: 0), padding)
                SudokuFieldView(Position(block: parent, row: 0, column: 1), padding)
                SudokuFieldView(Position(block: parent, row: 0, column: 2), padding)
            }
            HStack(spacing: 0) {
                SudokuFieldView(Position(block: parent, row: 1, column: 0), padding)
                SudokuFieldView(Position(block: parent, row: 1, column: 1), padding)
                SudokuFieldView(Position(block: parent, row: 1, column: 2), padding)
            }
            HStack(spacing: 0) {
                SudokuFieldView(Position(block: parent, row: 2, column: 0), padding)
                SudokuFieldView(Position(block: parent, row: 2, column: 1), padding)
                SudokuFieldView(Position(block: parent, row: 2, column: 2), padding)
            }
        }.border(Color.black, width: 2).padding(padding)
    }
}


struct SudokuBlock_Previews: PreviewProvider {
    static var previews: some View {
        SudokuBlockView(parent: 0, block: Block()).environmentObject(MainModel())
    }
}
