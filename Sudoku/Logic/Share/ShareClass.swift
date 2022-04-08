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

    static func generateShareLink(main: MainModel, sudoku: Sudoku) -> URL? {
        var id = ""
        id.append(String(main.difficulty.rawValue))

        for b in 0..<9 {
            for r in 0..<3 {
                for c in 0..<3 {
                    let pos = Position(block: b, row: r, column: c)
                    id.append(String(sudoku.getNumber(position: pos).number))
                }
            }
        }

        return URL(string: websiteURL + "share?id=" + LinkShorter.getLink(id: id))
    }

    static func load(main: MainModel, url: URL) throws {
        main.game = Sudoku()

        let urlComponents = URLComponents(string: url.absoluteString)
        let link = urlComponents?.queryItems?.first(where: { $0.name == "id" })?.value

        if link == nil {
            // TODO error handling
        }

        let id = LinkShorter.getId(link: link!)
        let difficulty = Int(String(id.first!))

        if difficulty == nil {
            // TODO error handling
        }

        if difficulty! < 0 || difficulty! > 3 {
            // TODO error handling
        }

        main.difficulty = Difficulty(rawValue: difficulty!)!

        var k = 1

        for b in 0..<9 {
            for r in 0..<3 {
                for c in 0..<3 {
                    var p = Position(block: b, row: r, column: c);
                    let number = Int(String(id[k]))!
                    // TODO error handling if number cannot be parsed

                    k += 1

                    let n = Number(number: number, solution: number, isChangeable: number == 0)
                    main.game.setNumber(position: p, number: n)
                }
            }
        }

        Generator.solveSudoku(sudoku: &main.game)
    }
}

extension String {
    subscript(i: Int) -> String {
        String(self[index(startIndex, offsetBy: i)])
    }
}
