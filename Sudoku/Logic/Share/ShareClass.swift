//
//  ShareClass.swift
//  Sudoku
//
//  Created by Philipp Hofer on 23.03.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import Foundation

class ShareClass {

    static let websiteURL = "https://philipphofer.de/"

    static func generateShareLink(sudoku: Sudoku, difficulty: Difficulty) -> URL? {
        var gameString = ""
        gameString.append(String(difficulty.rawValue))

        for b in 0..<9 {
            for r in 0..<3 {
                for c in 0..<3 {
                    let pos = Position(block: b, row: r, column: c)
                    let number = sudoku.getNumber(position: pos)
                    gameString.append(number.isChangeable ? "0" : String(number.number))
                }
            }
        }

        return URL(string: websiteURL + "share?id=" + LinkShortener.getLink(id: gameString))
    }

    static func load(url: URL) throws -> (Sudoku, Difficulty) {
        var sudoku = Sudoku()

        let urlComponents = URLComponents(string: url.absoluteString)
        guard let link = urlComponents?.queryItems?.first(where: { $0.name == "id" })?.value else {
            throw ShareError.SharingError
        }

        let gameString = LinkShortener.getId(link: link)

        guard let difficultyInt = gameString.first else {
            throw ShareError.SharingError
        }

        guard let difficulty = Int(String(difficultyInt)) else {
            throw ShareError.SharingError
        }

        if difficulty < 0 || difficulty > 3 {
            throw ShareError.SharingError
        }

        var k = 1
        for b in 0..<9 {
            for r in 0..<3 {
                for c in 0..<3 {
                    guard let number = Int(String(gameString[k])) else {
                        throw ShareError.SharingError
                    }

                    let p = Position(block: b, row: r, column: c);
                    let n = Number(number: number, solution: number, isChangeable: number == 0)
                    sudoku.setNumber(position: p, number: n)

                    k += 1
                }
            }
        }

        Generator.solveSudoku(sudoku: &sudoku)

        return (sudoku, Difficulty(rawValue: difficulty) ?? Difficulty.BEGINNER)
    }
}

enum ShareError: Error {
    case SharingError
}

extension String {
    subscript(i: Int) -> String {
        String(self[index(startIndex, offsetBy: i)])
    }
}
