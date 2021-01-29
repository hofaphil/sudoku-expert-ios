//
//  SettingsView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 27.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        List {
            SettingsSwitch(title: "Test", description: "testDescription testDescription testDescription testDescription testDescription")
        }.listStyle(GroupedListStyle())
        .navigationBarTitle(Text("Settings"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
