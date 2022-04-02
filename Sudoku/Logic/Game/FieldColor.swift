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

    func getFieldColor(position: Position) -> Color {
        var fieldColor: Color = Color.white

        if (UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_NUMBERS)) {
            if (game.getNumber(position: position) == game.getNumber(position: selected!)) {
                fieldColor = MainModel.lightSelectedColor
            }
        }

        if (UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_LINES)) {
            if (game.getNumber(position: position) == game.getNumber(position: selected!)) {
                // TODO fieldColor = MainModel.lightSelectedColor
            }
        }

        if (selected == position) {
            fieldColor = Color.yellow
        }

        if (UserDefaults.standard.bool(forKey: Data.GAME_SHOW_ERRORS)) {
            if (game.getNumber(position: position).isError()) {
                fieldColor = MainModel.errorColor;
            }
        }

        return fieldColor
    }
}
