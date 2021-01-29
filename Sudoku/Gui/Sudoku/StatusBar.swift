//
//  SwiftUIView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct StatusBar: View {
    
    @EnvironmentObject var main: MainModel
    @State var isActive = false
    @State var newGame = false
    
    var newGameSheet: ActionSheet {
        ActionSheet(title: Text("New Game"), message: Text("Select Difficulty"), buttons: [
            .default(Text("Beginner")) {self.main.startNewGame(difficulty: 0)},
            .default(Text("Advanced")) {self.main.startNewGame(difficulty: 1)},
            .default(Text("Expert")) {self.main.startNewGame(difficulty: 2)},
            .cancel()
        ])
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("New", action: {newGame = true})
                Button("Share", action: {})
                Spacer()
                Text(main.time)
                Spacer()
                NavigationLink("Statis", destination: StatisticsView())
                NavigationLink("Settings", destination: SettingsView())
            }.padding().background(Color.yellow)
            HStack {
                Spacer()
                Text(String(main.errorCheck!.overallErrors))
                Text(" /   3 Errors")
                Spacer()
            }
        }.actionSheet(isPresented: $newGame, content: {newGameSheet})
    }
}

struct StatusBar_Previews: PreviewProvider {
    static var previews: some View {
        StatusBar()
    }
}
