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

    var averageTime: Int
    let bestTime: Int
    let timesPlayed: Int

    init(difficulty: Difficulty) {
        self.difficulty = difficulty
        let stats = Data().loadStatistics()

        bestTime = stats.getBestTime(difficulty: difficulty)
        timesPlayed = stats.getTimesPlayed(difficulty: difficulty)
        averageTime = stats.getAverageTime(difficulty: difficulty)
    }

    var body: some View {
        Section(header: Text(difficulty.asString)) {
            VStack {
                Text("Average: \(MainModel.timeToString(averageTime))").frame(maxWidth: .infinity, alignment: .leading).padding()
                Text("Best time: \(MainModel.timeToString(bestTime))").frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
                Text("Number of games: \(timesPlayed)").frame(maxWidth: .infinity, alignment: .leading).padding()
            }
        }
    }
}

struct StatisticsCard_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsCard(difficulty: Difficulty.ADVANCED)
    }
}
