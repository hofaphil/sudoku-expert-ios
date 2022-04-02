//
//  SettingsButton.swift
//  Sudoku
//
//  Created by Philipp Hofer on 29.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SettingsButton: View {

    let title: String
    let action: () -> Void

    @State var state: Bool = false

    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(action: { action() }, label: {
            Text(title).foregroundColor(Color.black)
        })
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(title: "TestTitle", action: { print("hello world") })
    }
}
