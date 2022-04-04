//
//  EndCardStatistics.swift
//  Sudoku
//
//  Created by Philipp Hofer on 01.02.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct EndCardStatistics: View {

    let time: String
    let difficulty: Difficulty

    let bestTime: String

    init(time: String, difficulty: Difficulty) {
        self.time = time
        self.difficulty = difficulty
        bestTime = MainModel.timeToString(Data().loadStatistics().getBestTime(difficulty: difficulty))
    }
    
    func textItem(_ first: String, _ second: String) -> some View {
        HStack {
            Text("\(first):")
            Text(second).fontWeight(.light)
        }.frame(maxWidth: .infinity, alignment: .leading).padding(5).padding(.leading)
    }

    var body: some View {
        VStack(spacing: 0) {
            textItem("Difficulty", difficulty.asString)
            textItem("Your Time", time)
            textItem("Best Time", bestTime)
        }
    }
}

struct EndCardStatistics_Previews: PreviewProvider {
    static var previews: some View {
        EndCardStatistics(time: "00:00", difficulty: Difficulty.BEGINNER)
    }
}
