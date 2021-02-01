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
    @State var options = false
    
    @State var settings = false
    @State var statistics = false
    
    var newGameSheet: ActionSheet {
        ActionSheet(title: Text("New Game"), message: Text("Select Difficulty"), buttons: [
            .default(Text(Difficulty.BEGINNER.asString)) {self.main.startNewGame(difficulty: Difficulty.BEGINNER)},
            .default(Text(Difficulty.ADVANCED.asString)) {self.main.startNewGame(difficulty: Difficulty.ADVANCED)},
            .default(Text(Difficulty.EXPERT.asString)) {self.main.startNewGame(difficulty: Difficulty.EXPERT)},
            .cancel()
        ])
    }
    
    var optionSheet: ActionSheet {
        ActionSheet(title: Text("More"), buttons: [
            .default(Text("Share")) {},
            .default(Text("Statistics")) { statistics = true },
            .default(Text("Rate")) {},
            .default(Text("Settings")) { settings = true },
            .cancel()
        ])
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("+", action: {newGame = true})
                Spacer()
                Text(main.showTime ? main.time : "--:--")
                Spacer()
                Button("...", action: {options = true})
                NavigationLink("", destination: SettingsView(), isActive: $settings)
                NavigationLink("", destination: StatisticsView(), isActive: $statistics)
            }.padding()
            HStack {
                Spacer()
                Text(main.difficulty.asString)
                Spacer()
                Text(main.showErrors ? "\(main.errorCheck!.overallErrors) / 3 Errors" : "- / 3 Errors")
                Spacer()
            }.border(Color.black, width: 1).padding(EdgeInsets(top: 0, leading: 3, bottom: 3, trailing: 3))
        }.actionSheet(isPresented: $newGame, content: {newGameSheet}).actionSheet(isPresented: $options, content: {optionSheet}).background(Color.yellow)
    }
}

struct StatusBar_Previews: PreviewProvider {
    static var previews: some View {
        StatusBar()
    }
}
