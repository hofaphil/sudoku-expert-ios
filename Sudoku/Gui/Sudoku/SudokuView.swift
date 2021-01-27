//
//  SudokuView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 27.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SudokuView: View {
    @EnvironmentObject var main: MainModel
    
    var body: some View {
        VStack {
            StatusBar()
            SudokuGridView(sudoku: main.sudoku)
            Spacer()
            Keyboard()
            Spacer()
        }
    }
}

struct SudokuView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuView()
    }
}
