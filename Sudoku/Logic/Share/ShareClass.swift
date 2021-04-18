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
    
    static func generateShareLink(main: MainModel, sudoku: SudokuClass) -> URL? {
        
        var id = ""
        id.append(String(main.difficulty.rawValue))
        
        for i in 0..<9 {
            for a in 0..<3 {
                for b in 0..<3 {
                    id.append(String(sudoku.getSudoku()[i].getNumbers()[a][b]))
                }
            }
        }
        
        return URL(string: websiteURL + "share?id=" + LinkShorter.getLink(id: id))
    }
    
    static func load(main: MainModel, url: URL) throws {
        main.sudoku = SudokuClass()

        let urlComponents = URLComponents(string: url.absoluteString)
        let link = urlComponents?.queryItems?.first(where: { $0.name == "id" })?.value
        
        if link == nil {
            // TODO throw exception
        }
        
        let id = LinkShorter.getId(link: link!)
        let difficulty = Int(String(id.first!))
        
        if difficulty == nil {
            // TODO throw exception
        }
        
        if difficulty! < 0 || difficulty! > 3 {
            // TODO throw exception
        }

        main.difficulty = Difficulty(rawValue: difficulty!)!

        var block = [Block]()
        var numbers = [[Int32]](repeating: [Int32](repeating: 0, count: 3), count: 3)
        
        var k = 1
        
        for _ in 0..<9 {
            for a in 0..<3 {
                for b in 0..<3 {
                    numbers[a][b] = Int32(String(id[k]))!
                    k += 1
                }
            }
            block.append(Block(numbers: numbers));
        }
        main.sudoku.setSudoku(blocks: block)
        let solution = SudokuClass.solve(blocks: main.sudoku.getSudoku())
        main.sudoku.setSolution(blocks: solution)
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
