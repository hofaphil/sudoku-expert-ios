//
//  NewGame.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.06.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct NewGame: View {
    
    @EnvironmentObject var main: MainModel
    
    var body: some View {
        VStack {
            Spacer()
            Text("New Game").font(.system(size: 40))
            Spacer()
            Button("Beginner", action: {
                self.main.startNewGame(difficulty: 0)
                self.main.visibleView = Views.Game
            }).padding()
            Button("Advanced", action: {
                self.main.startNewGame(difficulty: 1)
                self.main.visibleView = Views.Game
            }).padding()
            Button("Expert", action: {
                self.main.startNewGame(difficulty: 2)
                self.main.visibleView = Views.Game
            }).padding()
            Spacer()
            Button("Cancel", action: {
                self.main.visibleView = Views.Game
            }).padding()
            Spacer()
        }
    }
}

struct NewGame_Previews: PreviewProvider {
    static var previews: some View {
        NewGame()
    }
}
