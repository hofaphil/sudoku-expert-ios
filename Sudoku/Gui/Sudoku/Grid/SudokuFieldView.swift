//
//  SudokuField.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SudokuFieldView: View {
    
    @ObservedObject var model: Number = Number()
    @EnvironmentObject var main: MainModel
    var color: Color {
        main.getFieldColor(position: position)
    }

    var position: Position

    let fontSize: CGFloat = 12
    
    var fieldSize: CGFloat
    var noteSize: CGFloat
    
    init(_ model: Number, _ position: Position, _ parentPadding: CGFloat) {
        self.position = position
        self.model = model
        fieldSize = (UIScreen.main.bounds.size.width - (6 * parentPadding)) / 9
        noteSize = fieldSize / 3
    }
    
    var body: some View {
        ZStack {
            Button(action: {
                main.select(position: position)
            }, label: {
                if model.isNotes {
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
                    if (model.isChangeable) {
                        Text(model.number == 0 ? " " : String(model.number))
                            .font(.system(size: 22))
                            .italic()
                            .fontWeight(.light)
                    } else {
                        Text(model.number == 0 ? " " : String(model.number))
                            .font(.system(size: 22))
                            .bold()
                    }
                    
                }
            }).frame(width: fieldSize, height: fieldSize).border(Color.black, width: 0.5).background(color).padding(0)
        }
    }
    
    func note(_ number: Int) -> some View {
        Text(model.notes[number - 1] ? String(number) : "").font(.system(size: fontSize)).frame(width: noteSize, height: noteSize)
    }
}

struct SudokuFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuFieldView(Number(), Position(block: 0, row: 0, column: 0), 2)
    }
}
