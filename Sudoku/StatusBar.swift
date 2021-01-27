//
//  SwiftUIView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct StatusBar: View {
    
    @EnvironmentObject var main: MainModel
    
    var body: some View {
        VStack {
            HStack {
                Button("New", action: {
                    self.main.visibleView = Views.NewGame
                })
                Button("Share", action: {})
                Spacer()
                Text(main.time)
                Spacer()
                Button("Stats", action: {})
                Button("Settings", action: {})
            }.padding().background(Color.yellow)
            HStack {
                Spacer()
                Text(String(main.errorCheck!.overallErrors))
                Text(" /   3 Errors")
                Spacer()
            }
        }
    }
}

struct StatusBar_Previews: PreviewProvider {
    static var previews: some View {
        StatusBar()
    }
}
