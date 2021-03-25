//
//  NotesCheck.swift
//  Sudoku
//
//  Created by Philipp Hofer on 25.03.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import Foundation

extension MainModel {
    
    func checkNotes(sudokuField: SudokuFieldModel, number: Int) {
        
        if UserDefaults.standard.bool(forKey: Data.SETTINGS_CHECK_NOTES) && !isNotes {
            for i in 0..<3 {
                for j in 0..<3 {
                    fields[sudokuField.position.parent][i][j].checkNotes(number: number)
                }
            }

            switch sudokuField.position.parent {
            case 0:
                for i in 0..<3 {
                    fields[1][sudokuField.position.row][i].checkNotes(number: number);
                    fields[2][sudokuField.position.row][i].checkNotes(number: number);
                    fields[3][i][sudokuField.position.column].checkNotes(number: number);
                    fields[6][i][sudokuField.position.column].checkNotes(number: number);
                }
                break;
            case 1:
                for i in 0..<3 {
                    fields[0][sudokuField.position.row][i].checkNotes(number: number);
                    fields[2][sudokuField.position.row][i].checkNotes(number: number);
                    fields[4][i][sudokuField.position.column].checkNotes(number: number);
                    fields[7][i][sudokuField.position.column].checkNotes(number: number);
                }
                break;
            case 2:
                for i in 0..<3 {
                    fields[0][sudokuField.position.row][i].checkNotes(number: number);
                    fields[1][sudokuField.position.row][i].checkNotes(number: number);
                    fields[5][i][sudokuField.position.column].checkNotes(number: number);
                    fields[8][i][sudokuField.position.column].checkNotes(number: number);
                }
                break;
            case 3:
                for i in 0..<3 {
                    fields[4][sudokuField.position.row][i].checkNotes(number: number);
                    fields[5][sudokuField.position.row][i].checkNotes(number: number);
                    fields[0][i][sudokuField.position.column].checkNotes(number: number);
                    fields[6][i][sudokuField.position.column].checkNotes(number: number);
                }
                break;
            case 4:
                for i in 0..<3 {
                    fields[3][sudokuField.position.row][i].checkNotes(number: number);
                    fields[5][sudokuField.position.row][i].checkNotes(number: number);
                    fields[1][i][sudokuField.position.column].checkNotes(number: number);
                    fields[7][i][sudokuField.position.column].checkNotes(number: number);
                }
                break;
            case 5:
                for i in 0..<3 {
                    fields[3][sudokuField.position.row][i].checkNotes(number: number);
                    fields[4][sudokuField.position.row][i].checkNotes(number: number);
                    fields[2][i][sudokuField.position.column].checkNotes(number: number);
                    fields[8][i][sudokuField.position.column].checkNotes(number: number);
                }
                break;
            case 6:
                for i in 0..<3 {
                    fields[7][sudokuField.position.row][i].checkNotes(number: number);
                    fields[8][sudokuField.position.row][i].checkNotes(number: number);
                    fields[0][i][sudokuField.position.column].checkNotes(number: number);
                    fields[3][i][sudokuField.position.column].checkNotes(number: number);
                }
                break;
            case 7:
                for i in 0..<3 {
                    fields[6][sudokuField.position.row][i].checkNotes(number: number);
                    fields[8][sudokuField.position.row][i].checkNotes(number: number);
                    fields[1][i][sudokuField.position.column].checkNotes(number: number);
                    fields[4][i][sudokuField.position.column].checkNotes(number: number);
                }
                break;
            case 8:
                for i in 0..<3 {
                    fields[6][sudokuField.position.row][i].checkNotes(number: number);
                    fields[7][sudokuField.position.row][i].checkNotes(number: number);
                    fields[2][i][sudokuField.position.column].checkNotes(number: number);
                    fields[5][i][sudokuField.position.column].checkNotes(number: number);
                }
                break;
            default:
                break;
            }
        }
    }
}
