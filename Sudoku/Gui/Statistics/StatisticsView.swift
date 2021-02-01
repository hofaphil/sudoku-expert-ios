//
//  StatisticsView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 27.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
    var body: some View {
        ScrollView {
            VStack {
                StatisticsCard(difficulty: Difficulty.BEGINNER)
                StatisticsCard(difficulty: Difficulty.ADVANCED)
                StatisticsCard(difficulty: Difficulty.EXPERT)
                Spacer()
            }.padding(0)
        }.navigationBarTitle("Statistics")
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
