//
//  SudokuField.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SudokuFieldView: View {
    
    @EnvironmentObject var main: MainModel
        
    var position: Position
    
    var body: some View {
        ZStack {
            Button(action: {
                self.main.select(position: self.position)
            }, label: {
                Text(main.get(position).number == 0 ? " " : String(main.get(position).number))
            }).frame(width: 35, height: 35).border(Color.black).background(main.get(position).color)
        }
    }
}

struct SudokuFieldView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World!")
        //SudokuFieldView(selectedModel: nil, number: 0, position: Position(row: 0, column: 0, parent: 0))
    }
}


extension Color {
    public static let yellow = Color("Yellow")
    public static let gray = Color("Gray")
}
