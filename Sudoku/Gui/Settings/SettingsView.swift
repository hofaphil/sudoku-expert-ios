//
//  SettingsView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 27.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @State var alert = false
    
    var body: some View {
        List {
            Section(header: Text("Game settings")) {
                SettingsSwitch(title: "Mark same numbers", key: Data.SETTINGS_MARK_NUMBERS)
                SettingsSwitch(title: "Highlight lines", key: Data.SETTINGS_MARK_LINES)
                SettingsSwitch(title: "Check notes", key: Data.SETTINGS_CHECK_NOTES)
            }
            Section(footer: Text("Changes when you start a new game")) {
                SettingsSwitch(title: "Show Errors", key: Data.SETTINGS_MARK_ERRORS)
                SettingsSwitch(title: "Play with Timer", key: Data.SETTINGS_SHOW_TIME)
            }
            // SettingsSwitch(title: "Low Power Mode", description: "Activate this mode when your battery is low", key: Data.SETTINGS_POWERMODE)
            Section(header: Text("Support"), footer: Text("Support the developer to unlock different colors and never see any ads again")) {
                SettingsButton(title: "Color of the app")
                SettingsButton(title: "Give support")
            }
            Section(header: Text("More")) {
                SettingsButton(title: "Reset your statistics").onTapGesture {
                    alert = true
                }
                SettingsButton(title: "Contact").onTapGesture {
                    UIApplication.shared.open(URL(string: "https://philipphofer.de/contact")!)
                }
            }.alert(isPresented: self.$alert) {
                Alert(title: Text("Delete Statistics"),
                      message: Text("Do you want to delete all you statistics?"),
                      primaryButton: .destructive(Text("Delete"), action: { UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!) }),
                      secondaryButton: .default(Text("Cancel")))
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
