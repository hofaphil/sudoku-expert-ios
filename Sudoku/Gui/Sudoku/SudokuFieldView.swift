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
                            Text(self.model.notes[0] ? "1" : "").font(.system(size: fontSize)).frame(width: noteSize, height: noteSize)
                            Text(self.model.notes[1] ? "2" : "").font(.system(size: fontSize)).frame(width: noteSize, height: noteSize)
                            Text(self.model.notes[2] ? "3" : "").font(.system(size: fontSize)).frame(width: noteSize, height: noteSize)
                        }
                        HStack(spacing: 0) {
                            Text(self.model.notes[3] ? "4" : "").font(.system(size: fontSize)).frame(width: noteSize, height: noteSize)
                            Text(self.model.notes[4] ? "5" : "").font(.system(size: fontSize)).frame(width: noteSize, height: noteSize)
                            Text(self.model.notes[5] ? "6" : "").font(.system(size: fontSize)).frame(width: noteSize, height: noteSize)
                        }
                        HStack(spacing: 0) {
                            Text(self.model.notes[6] ? "7" : "").font(.system(size: fontSize)).frame(width: noteSize, height: noteSize)
                            Text(self.model.notes[7] ? "8" : "").font(.system(size: fontSize)).frame(width: noteSize, height: noteSize)
                            Text(self.model.notes[8] ? "9" : "").font(.system(size: fontSize)).frame(width: noteSize, height: noteSize)
                        }
                    }
                } else {
                    Text(model.number == 0 ? " " : String(model.number)).font(.system(size: 22))
                }
            }).frame(width: fieldSize, height: fieldSize).border(Color.black).background(model.color).padding(0)
        }
    }
}

struct SudokuFieldView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World!")
    }
}
