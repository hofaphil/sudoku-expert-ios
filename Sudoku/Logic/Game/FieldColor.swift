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
        setFieldColors()
    }

    func setFieldColors() {
        for b in 0...8 {
            for r in 0...2 {
                for c in 0...2 {
                    let pos = Position(block: b, row: r, column: c)

                    if (game.getNumber(position: pos).isError() && UserDefaults.standard.bool(forKey: Data.GAME_SHOW_ERRORS)) {
                        colors[b][r][c] = MainModel.errorColor;
                        continue
                    }

                    if (selected != nil) {
                        if (selected == pos) {
                            colors[b][r][c] = appColor
                            continue
                        }

                        if (UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_NUMBERS) && game.getNumber(position: pos).number != 0) {
                            if (game.getNumber(position: pos).number == game.getNumber(position: selected!).number) {
                                colors[b][r][c] = MainModel.lightSelectedColor
                                continue
                            }
                        }

                        if (UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_LINES)) {
                            if (MainModel.partnerBlockLookup[selected!.block].contains(pos.block)) {
                                // it's a col-partner
                                if (pos.block >= selected!.block + 3 || pos.block <= selected!.block - 3) {
                                    if (pos.column == selected!.column) {
                                        colors[b][r][c] = MainModel.lightSelectedColor
                                        continue
                                    }
                                    // its a row-partner
                                } else {
                                    if (pos.row == selected!.row) {
                                        colors[b][r][c] = MainModel.lightSelectedColor
                                        continue
                                    }
                                }
                            } else if (pos.block == selected!.block) {
                                if (pos.column == selected!.column || pos.row == selected!.row) {
                                    colors[b][r][c] = MainModel.lightSelectedColor
                                    continue
                                }
                            }
                        }
                    }

                    colors[b][r][c] = MainModel.unSelectedColor
                }
            }
        }
    }
}
