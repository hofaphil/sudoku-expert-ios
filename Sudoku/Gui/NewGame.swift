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
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("New Game").font(.system(size: 40))
            Spacer()
            Button("Beginner", action: {
                self.main.startNewGame(difficulty: 0)
                show = false
            }).padding()
            Button("Advanced", action: {
                self.main.startNewGame(difficulty: 1)
                show = false
            }).padding()
            Button("Expert", action: {
                self.main.startNewGame(difficulty: 2)
                show = false
            }).padding()
            Spacer()
            Button("Cancel", action: {
                show = false
            }).padding()
            Spacer()
        }
    }
}

struct NewGame_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
    }
}
