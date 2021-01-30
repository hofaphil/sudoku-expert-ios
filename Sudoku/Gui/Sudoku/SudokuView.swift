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
            if (main.numberCount.finished && main.errorCheck!.activeErrors == 0) ||
                   (main.errorCheck!.overallErrors >= 3 && UserDefaults.standard.bool(forKey: Data.GAME_SHOW_ERRORS)) {
                NavigationLink("", destination: EndCardView(won: main.errorCheck!.overallErrors < 3).environmentObject(main), isActive: /*@START_MENU_TOKEN@*/.constant(true)/*@END_MENU_TOKEN@*/)
            } else {
                VStack {
                    StatusBar()
                    SudokuGridView(sudoku: main.sudoku)
                    Spacer()
                    Keyboard()
                    Spacer()
                }.navigationBarHidden(true)
            }
        }.accentColor(.black)
    }
}

struct SudokuView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuView()
    }
}
