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
            .default(Text(Difficulty.BEGINNER.asString)) {self.main.startNewGame(difficulty: Difficulty.BEGINNER)},
            .default(Text(Difficulty.ADVANCED.asString)) {self.main.startNewGame(difficulty: Difficulty.ADVANCED)},
            .default(Text(Difficulty.EXPERT.asString)) {self.main.startNewGame(difficulty: Difficulty.EXPERT)},
            .cancel()
        ])
    }
    
    var optionSheet: ActionSheet {
        ActionSheet(title: Text("More"), buttons: [
            .default(Text("Share")) {
                // TODO hier noch den richtigen link und das richtige share-verhalten einfügen!
                // let data = ShareClass.generateShareLink(main: main, sudoku: main.sudoku)
                // if data == nil {
                    // TODO show error
                /*
                let av = UIActivityViewController(activityItems: [data!], applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil) */
            },
            .default(Text("Statistics")) { statistics = true },
            .default(Text("Rate")) {
                // TODO link to appstore
            },
            .default(Text("Settings")) { settings = true },
            .cancel()
        ])
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    actionSheet = true
                    options = false
                }) { Image(systemName: "plus").font(.title) }
                Spacer()
                Text(main.showTime ? main.time : "--:--").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                Button(action: {
                    actionSheet = true
                    options = true
                }) { Image(systemName: "ellipsis").font(.title) }
                NavigationLink("", destination: SettingsView(), isActive: $settings)
                NavigationLink("", destination: StatisticsView(), isActive: $statistics)
            }.padding()
            HStack {
                Spacer()
                Text(main.difficulty.asString).foregroundColor(.black)
                Spacer()
                // TODO show errors
                Text(main.showErrors ? "0 / 3 Errors" : "- / 3 Errors")
                Spacer()
            }.padding(.top, 3).padding(.bottom, 3).border(Color.black, width: 1).padding(EdgeInsets(top: 0, leading: 3, bottom: 3, trailing: 3))
        }.actionSheet(isPresented: $actionSheet) {
            options ? optionSheet : newGameSheet
        }.background(main.appColor)
    }
}

struct StatusBar_Previews: PreviewProvider {
    static var previews: some View {
        StatusBar().environmentObject(MainModel())
    }
}
