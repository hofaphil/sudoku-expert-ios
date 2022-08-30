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
    let borderWidth: CGFloat = 2
    let spacing: CGFloat = 4

    init() {
        width = (UIScreen.main.bounds.width - (6 * (padding + borderWidth))) / 3
    }

    var body: some View {
        VStack(spacing: 0) {
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
            }.padding().padding(.top, 10).padding(.bottom, 10)
            HStack(spacing: spacing) {
                HStack {
                    Image(systemName: "pencil").imageScale(.small)
                    Text("test").bold()
                }
                .onTapGesture(perform: { main.isNotes = !main.isNotes })
                .frame(width: width).padding(padding).border(Color.black, width: borderWidth)
                .background(main.isNotes ? main.appColor : MainModel.unSelectedColor)

                HStack {
                    Image(systemName: "delete.left").imageScale(.small)
                    Text("Delete").bold()
                }
                .onTapGesture(perform: { main.delete() })
                .frame(width: width).padding(padding).border(Color.black, width: borderWidth)

                HStack {
                    Image(systemName: "pause").imageScale(.small)
                    Text("Pause").bold()
                }
                .onTapGesture(perform: { main.pause = !main.pause })
                .frame(width: width).padding(padding).border(Color.black, width: borderWidth)
                .background(main.pause ? main.appColor : MainModel.unSelectedColor)
            }
            Spacer()
        }
    }

    private func button(_ number: Int) -> some View {
        Button(action: { insert(number) }) {
            Text(String(number)).font(.system(size: 30)).bold()
        }
    }

    private func insert(_ number: Int) {
        main.insert(number: number)
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard().environmentObject(MainModel())
    }
}
