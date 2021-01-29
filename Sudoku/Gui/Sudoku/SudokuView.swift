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
        NavigationView {
            VStack {
                StatusBar()
                SudokuGridView(sudoku: main.sudoku)
                Spacer()
                Keyboard()
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct SudokuView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuView()
    }
}
