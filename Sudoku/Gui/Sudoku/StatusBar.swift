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

    @State var actionSheet = false
    @State var options = false

    @State var settings = false
    @State var statistics = false

    var newGameSheet: ActionSheet {
        ActionSheet(title: Text("New Game"), message: Text("Select Difficulty"), buttons: [
            .default(Text(Difficulty.BEGINNER.asString)) {
                main.startNewGame(difficulty: Difficulty.BEGINNER)
            },
            .default(Text(Difficulty.ADVANCED.asString)) {
                main.startNewGame(difficulty: Difficulty.ADVANCED)
            },
            .default(Text(Difficulty.EXPERT.asString)) {
                main.startNewGame(difficulty: Difficulty.EXPERT)
            },
            .cancel()
        ])
    }

    var optionSheet: ActionSheet {
        ActionSheet(title: Text("More"), buttons: [
            .default(Text("Share")) {
                let data = ShareClass.generateShareLink(sudoku: main.game, difficulty: main.difficulty)
                if data != nil {
                    let av = UIActivityViewController(activityItems: [data!], applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                }
            },
            .default(Text("Statistics")) {
                statistics = true
            },
            .default(Text("Rate")) {
                // TODO link to appstore
                UIApplication.shared.open(URL(string: "https://philipphofer.de/")!)
            },
            .default(Text("Settings")) {
                settings = true
            },
            .cancel()
        ])
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    actionSheet = true
                    options = false
                }) {
                    Image(systemName: "plus").font(.title)
                }
                Spacer()
                Text(UserDefaults.standard.bool(forKey: Data.GAME_SHOW_TIME) ? main.time : "--:--").font(.title)
                Spacer()
                Button(action: {
                    actionSheet = true
                    options = true
                }) {
                    Image(systemName: "ellipsis").font(.title)
                }
                NavigationLink("", destination: SettingsView(), isActive: $settings)
                NavigationLink("", destination: StatisticsView(), isActive: $statistics)
            }
            .padding()
            HStack {
                Spacer()
                Text(main.difficulty.asString).foregroundColor(.black)
                Spacer()
                Text(UserDefaults.standard.bool(forKey: Data.GAME_SHOW_ERRORS) ? "\(main.game.overallErrors) / 3 Errors" : "- / 3 Errors")
                Spacer()
            }
            .padding(.top, 3).padding(.bottom, 3).border(Color.black, width: 1).padding(EdgeInsets(top: 0, leading: 3, bottom: 3, trailing: 3))
        }
        .actionSheet(isPresented: $actionSheet) {
            options ? optionSheet : newGameSheet
        }
        .background(main.appColor)
    }
}

struct StatusBar_Previews: PreviewProvider {
    static var previews: some View {
        StatusBar().environmentObject(MainModel())
    }
}
