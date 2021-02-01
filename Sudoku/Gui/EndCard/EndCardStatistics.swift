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
    let width = UIScreen.main.bounds.width - 8

    init(time: String, difficulty: Difficulty) {
        self.time = time
        self.difficulty = difficulty
        self.bestTime = MainModel.timeToString(UserDefaults.standard.integer(forKey: Data.STATISTICS_BESTTIME + "\(difficulty.rawValue)"))
    }
    
    var body: some View {
        VStack {
            Text("Difficulty: \(difficulty.asString)").frame(maxWidth: .infinity, alignment: .leading).padding()
            Text("Your Time: \(time)").frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
            Text("Best time: \(bestTime)").frame(maxWidth: .infinity, alignment: .leading).padding()
        }.frame(width: width).border(Color.black, width: 2)
    }
}

struct EndCardStatistics_Previews: PreviewProvider {
    static var previews: some View {
        EndCardStatistics(time: "00:00", difficulty: Difficulty.BEGINNER)
    }
}
