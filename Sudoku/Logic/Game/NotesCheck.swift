//
//  NotesCheck.swift
//  Sudoku
//
//  Created by Philipp Hofer on 25.03.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import Foundation

extension MainModel {

    static let partnerBlockLookup: [[Int]] = [
        [1, 2, 3, 6],
        [0, 2, 4, 7],
        [0, 1, 5, 8],
        [4, 5, 0, 6],
        [3, 5, 1, 7],
        [3, 4, 2, 8],
        [7, 8, 0, 3],
        [6, 8, 1, 4],
        [6, 7, 2, 5],
    ];

    func checkNotes(position: Position, number: Int) {
        if UserDefaults.standard.bool(forKey: Data.SETTINGS_CHECK_NOTES) && !isNotes {
            let gameBlock: [Block] = game.getSudoku()
            for i in 0..<3 {
                for j in 0..<3 {
                    gameBlock[position.block].getNumbers()[i][j].checkNote(number: number)
                }
            }

            for i in 0..<3 {
                gameBlock[MainModel.partnerBlockLookup[position.block][0]].getNumbers()[position.row][i].checkNote(number: number)
                gameBlock[MainModel.partnerBlockLookup[position.block][1]].getNumbers()[position.row][i].checkNote(number: number);
                gameBlock[MainModel.partnerBlockLookup[position.block][2]].getNumbers()[i][position.column].checkNote(number: number);
                gameBlock[MainModel.partnerBlockLookup[position.block][3]].getNumbers()[i][position.column].checkNote(number: number);
            }
        }
    }
}
