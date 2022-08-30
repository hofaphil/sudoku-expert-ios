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
        let list = List {
            StatisticsCard(difficulty: Difficulty.BEGINNER)
            StatisticsCard(difficulty: Difficulty.ADVANCED)
            StatisticsCard(difficulty: Difficulty.EXPERT)
        }
        .navigationBarTitle(LocalizedStringKey("statistics"))
        list.listStyle(.insetGrouped)
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
