//
//  Keyboard.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct Keyboard: View {
    
    @EnvironmentObject var main: MainModel
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    Button("1", action: { self.insert(1) })
                    Spacer()
                    Button("2", action: { self.insert(2) })
                    Spacer()
                    Button("3", action: { self.insert(3) })
                    Spacer()
                    Button("4", action: { self.insert(4) })
                }
                Spacer()
                Group {
                    Button("5", action: { self.insert(5) })
                    Spacer()
                    Button("6", action: { self.insert(6) })
                    Spacer()
                    Button("7", action: { self.insert(7) })
                    Spacer()
                    Button("8", action: { self.insert(8) })
                    Spacer()
                    Button("9", action: { self.insert(9) })
                }
                
            }.padding()
            HStack {
                Button("Notes", action: {
                    self.main.isNotes = !self.main.isNotes
                })
                Spacer()
                Button("Delete", action: { self.main.selected?.delete() })
                Spacer()
                Button("Pause", action: {})
            }.padding()
        }.padding()
    }
    
    private func insert(_ number: Int) {
        main.selected?.insert(number)
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello World")
        //Keyboard()
    }
}
