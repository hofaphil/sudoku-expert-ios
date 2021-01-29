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
            SettingsSwitch(title: "Mark Numbers", description: "Mark the same numbers as the number you have selected", key: Data.SETTINGS_MARK_NUMBERS)
            SettingsSwitch(title: "Mark Lines", description: "Highlight the row and the column your selected number is in", key: Data.SETTINGS_MARK_LINES)
            SettingsSwitch(title: "Show Errors", description: "Mark wrong numbers and count them, will change in the next game you start", key: Data.SETTINGS_MARK_ERRORS)
            SettingsSwitch(title: "Check Notes", description: "Delete your conflicting notes when you insert a new number", key: Data.SETTINGS_CHECK_NOTES)
            SettingsSwitch(title: "Play with Timer", description: "See how much time you need for a Sudoku and save it in your statistics, will change in the next game you start", key: Data.SETTINGS_SHOW_TIME)
            SettingsSwitch(title: "Low Power Mode", description: "Activate this mode when your battery is low", key: Data.SETTINGS_POWERMODE)
            SettingsButton(title: "Color", description: "Change the color of the app")
            SettingsButton(title: "Support", description: "Support the developer, never have any Ads shown again and unlock color options!")
            SettingsButton(title: "Reset", description: "Delete all your statistics and reset the app")
            SettingsButton(title: "Contact")
        }.listStyle(GroupedListStyle()).navigationBarTitle(Text("Settings"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
