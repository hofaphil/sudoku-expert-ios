//
//  FieldColor.swift
//  Sudoku
//
//  Created by Philipp Hofer on 26.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import Foundation
import SwiftUI

extension MainModel {
    
    func setFieldColors(position: Position) {
        
        for a in 0...8 {
            for i in 0...2 {
                for j in 0...2 {
                    // unselect
                    fields[a][i][j].color = MainModel.unSelectedColor
                    
                    // mark same numbers
                    if UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_NUMBERS) && fields[a][i][j].number == selected!.number && selected!.number != 0 {
                        fields[a][i][j].color = MainModel.lightSelectedColor
                    }
                }
            }
        }
        
        
        if UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_LINES) {
            for i in 0...2 {
                if i != position.column {
                    fields[position.parent][position.row][i].color = MainModel.lightSelectedColor
                }
                if i != position.row {
                    fields[position.parent][i][position.column].color = MainModel.lightSelectedColor
                }
            }
            
            switch position.parent {
            case 0:
                for i in 0...2 {
                    fields[1][position.row][i].color = MainModel.lightSelectedColor
                    fields[2][position.row][i].color = MainModel.lightSelectedColor
                    fields[3][i][position.column].color = MainModel.lightSelectedColor
                    fields[6][i][position.column].color = MainModel.lightSelectedColor
                }
                break
            case 1:
                for i in 0...2 {
                    fields[0][position.row][i].color = MainModel.lightSelectedColor
                    fields[2][position.row][i].color = MainModel.lightSelectedColor
                    fields[4][i][position.column].color = MainModel.lightSelectedColor
                    fields[7][i][position.column].color = MainModel.lightSelectedColor
                }
                break
            case 2:
                for i in 0...2 {
                    fields[0][position.row][i].color = MainModel.lightSelectedColor
                    fields[1][position.row][i].color = MainModel.lightSelectedColor
                    fields[5][i][position.column].color = MainModel.lightSelectedColor
                    fields[8][i][position.column].color = MainModel.lightSelectedColor
                }
                break
            case 3:
                for i in 0...2 {
                    fields[4][position.row][i].color = MainModel.lightSelectedColor
                    fields[5][position.row][i].color = MainModel.lightSelectedColor
                    fields[0][i][position.column].color = MainModel.lightSelectedColor
                    fields[6][i][position.column].color = MainModel.lightSelectedColor
                }
                break
            case 4:
                for i in 0...2 {
                    fields[3][position.row][i].color = MainModel.lightSelectedColor
                    fields[5][position.row][i].color = MainModel.lightSelectedColor
                    fields[1][i][position.column].color = MainModel.lightSelectedColor
                    fields[7][i][position.column].color = MainModel.lightSelectedColor
                }
                break
            case 5:
                for i in 0...2 {
                    fields[3][position.row][i].color = MainModel.lightSelectedColor
                    fields[4][position.row][i].color = MainModel.lightSelectedColor
                    fields[2][i][position.column].color = MainModel.lightSelectedColor
                    fields[8][i][position.column].color = MainModel.lightSelectedColor
                }
                break
            case 6:
                for i in 0...2 {
                    fields[7][position.row][i].color = MainModel.lightSelectedColor
                    fields[8][position.row][i].color = MainModel.lightSelectedColor
                    fields[0][i][position.column].color = MainModel.lightSelectedColor
                    fields[3][i][position.column].color = MainModel.lightSelectedColor
                }
                break
            case 7:
                for i in 0...2 {
                    fields[6][position.row][i].color = MainModel.lightSelectedColor
                    fields[8][position.row][i].color = MainModel.lightSelectedColor
                    fields[1][i][position.column].color = MainModel.lightSelectedColor
                    fields[4][i][position.column].color = MainModel.lightSelectedColor
                }
                break
            case 8:
                for i in 0...2 {
                    fields[6][position.row][i].color = MainModel.lightSelectedColor
                    fields[7][position.row][i].color = MainModel.lightSelectedColor
                    fields[2][i][position.column].color = MainModel.lightSelectedColor
                    fields[5][i][position.column].color = MainModel.lightSelectedColor
                }
                break
            default:
                break
            }
        }
        
        // mark selected field
        fields[position.parent][position.row][position.column].color = MainModel.selectedColor
        
        for a in 0...8 {
            for i in 0...2 {
                for j in 0...2 {
                    // mark errors
                    if fields[a][i][j].error && UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_ERRORS){
                        fields[a][i][j].color = MainModel.errorColor
                    }
                }
            }
        }
    }
}
