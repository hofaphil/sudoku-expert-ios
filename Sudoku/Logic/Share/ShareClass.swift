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
    
    static func load(main: MainModel, url: URL) throws -> SudokuClass{
        let sudoku = SudokuClass(threads: 4)

        
        let link = url.query;
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
        var numbers = [[Int]]()
        
        var k = 1
        
        for i in 0..<9 {
            for a in 0..<9 {
                for b in 0..<9 {
                    numbers[a][b] = Int(String(id[id.index(id.startIndex, offsetBy: k)]))!
                    k += 1
                }
            }
            block[i] = Block();
            block[i].setNumbers(numbers: numbers);
        }
        sudoku.setSudoku(blocks: block)
        let solution = try sudoku.solve(blocks: sudoku.getSudoku())
        sudoku.setSolution(blocks: solution)
        
        return sudoku
    }
}
