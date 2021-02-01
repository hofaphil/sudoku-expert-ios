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
    let averageTime = "00:00"
    let bestTime = "00:00"
    let numberOfGames = 0
    
    var body: some View {
        VStack {
            Text(difficulty.asString).font(.system(size: 30)).frame(maxWidth: .infinity, alignment: .leading).padding()
            VStack {
                Text("Average: \(averageTime)").frame(maxWidth: .infinity, alignment: .leading).padding()
                Text("Best time: \(bestTime)").frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
                Text("Number of games: \(numberOfGames)").frame(maxWidth: .infinity, alignment: .leading).padding()
            }.frame(width: width).border(Color.black, width: 2)
        }
    }
}

struct StatisticsCard_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsCard(difficulty: Difficulty.ADVANCED)
    }
}
