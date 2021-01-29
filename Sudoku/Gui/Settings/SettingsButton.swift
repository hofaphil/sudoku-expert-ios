//
//  SettingsButton.swift
//  Sudoku
//
//  Created by Philipp Hofer on 29.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SettingsButton: View {
    
    var title: String
    var description: String
    @State var state: Bool = false
    
    init(title: String, description: String = "") {
        self.title = title
        self.description = description
    }
    
    var body: some View {
        Section(footer: Text(description)) {
            Button(action: {}, label: {
                Text(title).foregroundColor(Color.black)
            })
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello world")
    }
}
