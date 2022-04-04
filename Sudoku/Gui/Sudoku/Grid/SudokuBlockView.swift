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
                SudokuFieldView(getModel(p(parent, 0, 0)), p(parent, 0, 0), padding)
                SudokuFieldView(getModel(p(parent, 0, 1)), p(parent, 0, 1), padding)
                SudokuFieldView(getModel(p(parent, 0, 2)), p(parent, 0, 2), padding)
            }
            HStack(spacing: 0) {
                SudokuFieldView(getModel(p(parent, 1, 0)), p(parent, 1, 0), padding)
                SudokuFieldView(getModel(p(parent, 1, 1)), p(parent, 1, 1), padding)
                SudokuFieldView(getModel(p(parent, 1, 2)), p(parent, 1, 2), padding)
            }
            HStack(spacing: 0) {
                SudokuFieldView(getModel(p(parent, 2, 0)), p(parent, 2, 0), padding)
                SudokuFieldView(getModel(p(parent, 2, 1)), p(parent, 2, 1), padding)
                SudokuFieldView(getModel(p(parent, 2, 2)), p(parent, 2, 2), padding)
            }
        }.border(Color.black, width: 2).padding(padding)
    }

    private func getModel(_ position: Position) -> Number {
        main.game.getNumber(position: position)
    }

    private func p(_ block: Int, _ row: Int, _ col: Int) -> Position {
        Position(block: block, row: row, column: col)
    }
}

struct SudokuBlock_Previews: PreviewProvider {
    static var previews: some View {
        SudokuBlockView(parent: 0, block: Block()).environmentObject(MainModel())
    }
}
