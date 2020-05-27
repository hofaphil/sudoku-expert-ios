//
//  SwiftUIView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 19.05.20.
//  Copyright © 2020 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct StatusBar: View {
    var body: some View {
        HStack {
            Button("New", action: {})
            Button("Share", action: {})
            Spacer()
            Text("00:00")
            Spacer()
            Button("Stats", action: {})
            Button("Settings", action: {})
        }.padding().background(Color.yellow)
    }
}

struct StatusBar_Previews: PreviewProvider {
    static var previews: some View {
        StatusBar()
    }
}
