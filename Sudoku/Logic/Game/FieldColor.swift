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

    func initColorArray() {
        for b in 0...8 {
            colors.append([])
            for r in 0...2 {
                colors[b].append([])
                for _ in 0...2 {
                    colors[b][r].append(MainModel.unSelectedColor)
                }
            }
        }
    }

    func setFieldColors() {
        if (selected == nil) {
            return;
        }

        for b in 0...8 {
            for r in 0...2 {
                for c in 0...2 {
                    let pos = Position(block: b, row: r, column: c)

                    if (UserDefaults.standard.bool(forKey: Data.GAME_SHOW_ERRORS)) {
                        if (game.getNumber(position: pos).isError()) {
                            colors[b][r][c] = MainModel.errorColor;
                            continue
                        }
                    }

                    if (selected == pos) {
                        colors[b][r][c] = Color.yellow
                        continue
                    }

                    if (game.getNumber(position: pos).number != 0) {
                        if (UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_NUMBERS)) {
                            if (game.getNumber(position: pos).number == game.getNumber(position: selected!).number) {
                                colors[b][r][c] = MainModel.lightSelectedColor
                                continue
                            }
                        }

                        if (UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_LINES)) {
                            if (game.getNumber(position: pos).number == game.getNumber(position: selected!).number) {
                                // TODO fieldColor = MainModel.lightSelectedColor
                            }
                        }
                    }

                    colors[b][r][c] = MainModel.unSelectedColor
                }
            }
        }
    }
}
