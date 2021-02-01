//
//  EndCardView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 30.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct EndCardView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var main: MainModel
    
    let won: Bool
    let time: Int
    let difficulty: Difficulty
    
    let title: String
    let description: String
    
    init(won: Bool, time: Int, difficulty: Difficulty) {
        self.time = time
        self.difficulty = difficulty
        self.won = won
        
        if won {
            title = "You won!"
            description = "It took you \(time) to solve this Sudoku."
            UserDefaults.standard.set(time + UserDefaults.standard.integer(forKey: Data.STATISTICS_TIMEOVERALL + "\(difficulty.rawValue)"), forKey: Data.STATISTICS_TIMEOVERALL + "\(difficulty.rawValue)")
            UserDefaults.standard.set(1 + UserDefaults.standard.integer(forKey: Data.STATISTICS_TIMESPLAYED + "\(difficulty.rawValue)"), forKey: Data.STATISTICS_TIMESPLAYED + "\(difficulty.rawValue)")
            if time < UserDefaults.standard.integer(forKey: Data.STATISTICS_BESTTIME + "\(difficulty.rawValue)") || UserDefaults.standard.integer(forKey: Data.STATISTICS_BESTTIME + "\(difficulty.rawValue)") == 0 {
                UserDefaults.standard.set(time, forKey: Data.STATISTICS_BESTTIME + "\(difficulty.rawValue)")
            }
        } else {
            title = "You lost..."
            description = "You did not solve this one, try again!"
        }
        
    }
    
    var body: some View {
        VStack {
            Text(description).padding().font(.system(size: 30))
            EndCardStatistics(time: won ? MainModel.timeToString(time) : "--:--", difficulty: difficulty)
            Spacer()
        }.navigationBarTitle(title).onDisappear(perform: {
            main.startNewGame(difficulty: main.difficulty)
        })
    }
    
}

struct EndCardView_Previews: PreviewProvider {
    static var previews: some View {
        EndCardView(won: false, time: 0, difficulty: Difficulty.BEGINNER)
    }
}
