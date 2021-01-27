//
//  ContentView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 11.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var main: MainModel
    
    var body: some View {
        ZStack {
            if main.visibleView == Views.Game {
                VStack {
                    StatusBar()
                    SudokuGridView(sudoku: main.sudoku)
                    Spacer()
                    Keyboard()
                    Spacer()
                }
            } else if main.visibleView == Views.NewGame {
                NewGame()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
