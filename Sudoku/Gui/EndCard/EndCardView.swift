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
    
    //var won: Bool
    //var time: Int
    //var difficulty: Difficulty
    
    let title: String
    let description: String
    
    init(won: Bool, time: String, difficulty: Difficulty) {
        if won {
            title = "You won!"
            description = "It took you \(time) to solve this Sudoku."
        } else {
            title = "You lost..."
            description = "You did not solve this one, try again!"
        }
        
    }
    
    var body: some View {
        HStack{Text(description)}.navigationBarTitle(title).onDisappear(perform: {
            main.startNewGame(difficulty: main.difficulty)
        })
    }
    
}

struct EndCardView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
    }
}
