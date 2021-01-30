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
    @EnvironmentObject var main: MainModel
    
    var won: Bool
    var title: String
    
    init(won: Bool) {
        self.won = won
        self.title = won ? "You won!" : "You lost..."
    }
    
    var body: some View {
        HStack{Text("...")}.navigationBarTitle(title).onDisappear(perform: {
            main.startNewGame(difficulty: main.difficulty)
        })
    }

}

struct EndCardView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
    }
}
