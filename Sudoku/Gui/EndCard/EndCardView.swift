//
//  EndCardView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 30.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct EndCardView: View {

    @EnvironmentObject var main: MainModel

    let won: Bool
    let time: Int
    let difficulty: Difficulty

    let title: String

    init(won: Bool, time: Int, difficulty: Difficulty) {
        self.time = time
        self.difficulty = difficulty
        self.won = won

        title = won ? "You Won" : "You Lost"
    }

    var body: some View {
        ZStack {
            Rectangle().foregroundColor(Color.black.opacity(0.6))
            VStack {
                HStack {
                    Text(title).padding()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .background(Color.yellow)

                EndCardStatistics(time: won ? MainModel.timeToString(time) : "--:--", difficulty: difficulty)

                Button(action: okButtonAction) {
                    HStack {
                        Text("Ok").foregroundColor(Color.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .contentShape(Rectangle())
                }
                .padding().background(Color.yellow)
            }
            .background(Rectangle().foregroundColor(.white)).padding()
        }
        .edgesIgnoringSafeArea([.top, .bottom])
    }

    func okButtonAction() {
        main.startNewGame(difficulty: Difficulty.getDifficulty(intVal: UserDefaults.standard.integer(forKey: Data.GAME_DIFFICULTY)))
    }
}

struct EndCardView_Previews: PreviewProvider {
    static var previews: some View {
        EndCardView(won: false, time: 0, difficulty: Difficulty.BEGINNER)
    }
}
