//
//  StatisticsCard.swift
//  Sudoku
//
//  Created by Philipp Hofer on 01.02.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct StatisticsCard: View {

    let difficulty: Difficulty
    let width = UIScreen.main.bounds.width - 8

    // TODO: l d from userdefaults
    var averageTime: Int = 0
    let bestTime: Int
    let numberOfGames: Int

    init(difficulty: Difficulty) {
        self.difficulty = difficulty
        bestTime = UserDefaults.standard.integer(forKey: Data.STATISTICS_BEST_TIME + "\(difficulty.rawValue)")
        numberOfGames = UserDefaults.standard.integer(forKey: Data.STATISTICS_TIMES_PLAYED + "\(difficulty.rawValue)")
        if numberOfGames != 0 {
            averageTime = UserDefaults.standard.integer(forKey: Data.STATISTICS_TIME_OVERALL + "\(difficulty.rawValue)") / numberOfGames
        }
    }

    var body: some View {

        Section(header: Text(difficulty.asString)) {
            VStack {
                Text("Average: \(MainModel.timeToString(averageTime))").frame(maxWidth: .infinity, alignment: .leading).padding()
                Text("Best time: \(MainModel.timeToString(bestTime))").frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
                Text("Number of games: \(numberOfGames)").frame(maxWidth: .infinity, alignment: .leading).padding()
            }
        }
    }
}

struct StatisticsCard_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsCard(difficulty: Difficulty.ADVANCED)
    }
}
