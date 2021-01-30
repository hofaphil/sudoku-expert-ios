//
//  EndCardView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 30.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct EndCardView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var won: Bool
    var title: String
    var main: MainModel
    
    init(main: MainModel, won: Bool) {
        self.won = won
        self.title = won ? "You won!" : "You lost..."
        self.main = main
    }
    
    var body: some View {
        HStack{}.navigationBarTitle(title)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
                main.startNewGame(difficulty: main.difficulty)
            }){
                Image(systemName: "arrow.left")
            })
    }
}

struct EndCardView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
    }
}
