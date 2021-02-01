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
    @State var state: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        Button(action: {}, label: {
            Text(title).foregroundColor(Color.black)
        })
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(title: "TestTitle")
    }
}
