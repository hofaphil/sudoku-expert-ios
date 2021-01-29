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
                startNewGame(0)
            }).padding()
            Button("Advanced", action: {
                startNewGame(1)
            }).padding()
            Button("Expert", action: {
                startNewGame(2)
            }).padding()
            Spacer()
            Button("Cancel", action: {
                show = false
            }).padding()
            Spacer()
        }
    }
    
    func startNewGame(_ difficulty: Int) {
        self.main.startNewGame(difficulty: difficulty)
        show = false
    }
}

struct NewGame_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
    }
}
