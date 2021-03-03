//
//  SudokuField.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SudokuFieldView: View {
    
    @ObservedObject var model: SudokuFieldModel
    @EnvironmentObject var main: MainModel
    
    var position: Position
    
    let fontSize: CGFloat = 12
    
    var fieldSize: CGFloat
    var noteSize: CGFloat
    
    init(model: SudokuFieldModel, parentPadding: CGFloat) {
        self.model = model
        self.position = model.position
        self.fieldSize = (UIScreen.main.bounds.width - (6 * parentPadding)) / 9
        self.noteSize = fieldSize / 3
    }
    
    var body: some View {
        ZStack {
            Button(action: {
                self.main.select(model: self.model)
            }, label: {
                if self.model.isNotes {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            note(1)
                            note(2)
                            note(3)
                        }
                        HStack(spacing: 0) {
                            note(4)
                            note(5)
                            note(6)
                        }
                        HStack(spacing: 0) {
                            note(7)
                            note(8)
                            note(9)
                        }
                    }
                } else {
                    if (model.changeable) {
                        Text(model.number == 0 ? " " : String(model.number))
                            .font(.system(size: 22))
                            .italic()
                    } else {
                        Text(model.number == 0 ? " " : String(model.number))
                            .font(.system(size: 22))
                    }
                    
                }
            }).frame(width: fieldSize, height: fieldSize).border(Color.black, width: 0.5).background(model.color).padding(0)
        }
    }
    
    func note(_ number: Int) -> some View {
        return Text(self.model.notes[number - 1] ? String(number) : "").font(.system(size: fontSize)).frame(width: noteSize, height: noteSize)

    }
}

struct SudokuFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuFieldView(model: SudokuFieldModel(main: MainModel(), position: Position(row: 0, column: 0, parent: 0), number: 1, error: false), parentPadding: 2)
    }
}
