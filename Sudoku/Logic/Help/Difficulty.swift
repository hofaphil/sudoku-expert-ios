//
//  Difficulty.swift
//  Sudoku
//
//  Created by Philipp Hofer on 30.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import Foundation

enum Difficulty: Int {

    case BEGINNER = 0, ADVANCED = 1, EXPERT = 2

    var asString: String {
        switch self {
        case .BEGINNER:
            return "Beginner"
        case .ADVANCED:
            return "Advanced"
        case .EXPERT:
            return "Expert"
        }
    }

    static func getDifficutly(intVal: Int) -> Difficulty {
        switch intVal {
        case 0:
            return Difficulty.BEGINNER
        case 2:
            return Difficulty.EXPERT
        default:
            return Difficulty.ADVANCED
        }
    }

    static func getFreeFields(difficulty: Difficulty) -> Int {
        switch difficulty {
        case .BEGINNER:
            return 42
        case .ADVANCED:
            return 49
        case .EXPERT:
            return 56
        }
    }
}
