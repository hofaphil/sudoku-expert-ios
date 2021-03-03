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
    
    let padding: CGFloat = 10
    let width: CGFloat
    let borderWidth: CGFloat = 1
    let spacing: CGFloat = 5
    
    init() {
        width = (UIScreen.main.bounds.width - (6 * (padding + borderWidth) + 2 * spacing)) / 3
    }
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    button(1)
                    Spacer()
                    button(2)
                    Spacer()
                    button(3)
                    Spacer()
                    button(4)
                    Spacer()
                }
                Group {
                    button(5)
                    Spacer()
                    button(6)
                    Spacer()
                    button(7)
                    Spacer()
                    button(8)
                    Spacer()
                    button(9)
                }
            }.padding()
            HStack (spacing: spacing){
                Button(action: {
                    main.isNotes = !main.isNotes
                }) {
                    HStack {
                        Image(systemName: "pencil").imageScale(.small)
                        Text("Notes").bold()
                    }
                }.frame(width: width).padding(padding).border(Color.black, width: borderWidth).background(main.isNotes ? Color.yellow : Color.white)
                Button(action: {
                        main.selected?.delete()
                }) {
                    HStack {
                        Image(systemName: "delete.left").imageScale(.small)
                        Text("Delete").bold()
                    }
                }.frame(width: width).padding(padding).border(Color.black, width: borderWidth)
                Button(action: {
                    main.pause = !main.pause
                }) {
                    HStack {
                        Image(systemName: "pause").imageScale(.small)
                        Text("Pause").bold()
                    }
                }.frame(width: width).padding(padding).border(Color.black, width: borderWidth).background(main.pause ? Color.yellow : Color.white)
            }
        }
    }
    
    private func button(_ number: Int) -> some View {
        return Button(action: { self.insert(number) })
            { Text(String(number)).font(.system(size: 30)).bold() }
            .disabled(main.numberCount.numberCount[number] >= 9)
            .foregroundColor(main.numberCount.numberCount[number] >= 9 ? Color.white : .black)
    }
    
    private func insert(_ number: Int) {
        main.selected?.insert(number)
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard().environmentObject(MainModel())
    }
}
