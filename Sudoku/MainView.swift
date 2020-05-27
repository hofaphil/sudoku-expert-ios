//
//  ContentView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 11.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct MainView: View {
                
    var statusBar = StatusBar()
    var sudokuGrid: SudokuGridView
    var keyboard: Keyboard
    
    init(sudoku: SudokuClass) {
        sudokuGrid = SudokuGridView(sudoku: sudoku)
        keyboard = Keyboard()
    }
    
    var body: some View {
        VStack {
            statusBar
            sudokuGrid
            Spacer()
            keyboard
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(sudoku: SudokuClass(threads: 1))
    }
}
