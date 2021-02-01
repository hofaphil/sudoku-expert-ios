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
            Section(header: Text("Game settings")) {
                SettingsSwitch(title: "Mark same numbers", key: Data.SETTINGS_MARK_NUMBERS)
                SettingsSwitch(title: "Highlight lines", key: Data.SETTINGS_MARK_LINES)
                SettingsSwitch(title: "Check Notes", key: Data.SETTINGS_CHECK_NOTES)
            }
            Section(footer: Text("Changes at your next game")) {
                SettingsSwitch(title: "Show Errors", key: Data.SETTINGS_MARK_ERRORS)
                SettingsSwitch(title: "Play with Timer", key: Data.SETTINGS_SHOW_TIME)
            }
            // SettingsSwitch(title: "Low Power Mode", description: "Activate this mode when your battery is low", key: Data.SETTINGS_POWERMODE)
            Section(header: Text("Support"), footer: Text("Support the developer to unlock different colors and never see any ads again")) {
                SettingsButton(title: "Color of the app")
                SettingsButton(title: "Make support")
            }
            Section(header: Text("More")) {
                SettingsButton(title: "Reset your statistics")
                SettingsButton(title: "Contact")
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text("Settings"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
