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

    var newGameMenu: some View {
        Menu {
            Button(action: { main.startNewGame(difficulty: Difficulty.BEGINNER) }) {
                Label(Difficulty.BEGINNER.asString, systemImage: "1.square.fill")
            }
            Button(action: { main.startNewGame(difficulty: Difficulty.ADVANCED) }) {
                Label(Difficulty.ADVANCED.asString, systemImage: "2.square.fill")
            }
            Button(action: { main.startNewGame(difficulty: Difficulty.EXPERT) }) {
                Label(Difficulty.EXPERT.asString, systemImage: "3.square.fill")
            }
        } label: {
            Image(systemName: "plus").font(.title)
        }
    }

    var optionMenu: some View {
        Menu {
            Button(action: {
                let data = ShareClass.generateShareLink(sudoku: main.game, difficulty: main.difficulty)
                if data != nil {
                    let av = UIActivityViewController(activityItems: [data!], applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                }
            }) {
                Label("Challenge", systemImage: "person.2.fill")
            }
            Button(action: { statistics = true }) {
                Label("Statistics", systemImage: "chart.bar.xaxis")
            }
            Button(action: {
                // TODO link to appstore
                UIApplication.shared.open(URL(string: "https://philipphofer.de/")!)
            }) {
                Label("Rate", systemImage: "star.fill")
            }
            Button(action: {
                settings = true
            }) {
                Label("Settings", systemImage: "gearshape.fill")
            }
        } label: {
            Image(systemName: "ellipsis").font(.title)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                NavigationLink("", destination: SettingsView(), isActive: $settings)
                newGameMenu
                Spacer()
                Text(UserDefaults.standard.bool(forKey: Data.GAME_SHOW_TIME) ? main.time : "--:--").font(.title)
                Spacer()
                optionMenu
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
            .padding(.top, 6).padding(.bottom, 6).border(Color.black, width: 2).padding(EdgeInsets(top: 0, leading: 2, bottom: 2, trailing: 2))
        }
        .background(main.appColor)
    }
}

struct StatusBar_Previews: PreviewProvider {
    static var previews: some View {
        StatusBar().environmentObject(MainModel())
    }
}
