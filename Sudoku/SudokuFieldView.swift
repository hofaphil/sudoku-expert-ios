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
    
    var screenWidth: CGFloat = (UIScreen.main.bounds.width - 18) / 9
    
    init(model: SudokuFieldModel) {
        self.model = model
        self.position = model.position
    }
    
    var body: some View {
        ZStack {
            Button(action: {
                self.main.select(model: self.model)
            }, label: {
                if self.model.isNotes {
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text(self.model.notes[0] ? "1" : "").font(.system(size: fontSize))
                            Text(self.model.notes[1] ? "2" : "").font(.system(size: fontSize))
                            Text(self.model.notes[2] ? "3" : "").font(.system(size: fontSize))
                        }
                        HStack(spacing: 0) {
                            Text(self.model.notes[3] ? "4" : "").font(.system(size: fontSize))
                            Text(self.model.notes[4] ? "5" : "").font(.system(size: fontSize))
                            Text(self.model.notes[5] ? "6" : "").font(.system(size: fontSize))
                        }
                        HStack(spacing: 0) {
                            Text(self.model.notes[6] ? "7" : "").font(.system(size: fontSize))
                            Text(self.model.notes[7] ? "8" : "").font(.system(size: fontSize))
                            Text(self.model.notes[8] ? "9" : "").font(.system(size: fontSize))
                        }
                    }
                } else {
                    Text(model.number == 0 ? " " : String(model.number)).font(.system(size: 22))
                }
            }).frame(width: screenWidth, height: screenWidth).border(Color.black).background(model.color).padding(0)
        }
    }
}

struct SudokuFieldView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World!")
    }
}
