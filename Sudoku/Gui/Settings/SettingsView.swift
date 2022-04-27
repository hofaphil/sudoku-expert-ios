//
//  SettingsView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 27.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var main: MainModel

    @State var alert = false
    @State var colorChooser = false

    var colorChooserActionSheet: ActionSheet {
        ActionSheet(title: Text("Choose your color"), message: Text("Choose your favorite color for the app"), buttons: [
            .default(Text("Green")) {
                main.appColor = Color("Green")
                UserDefaults.standard.set("Green", forKey: Data.SETTINGS_COLOR)
            },
            .default(Text("Yellow")) {
                main.appColor = Color("Yellow")
                UserDefaults.standard.set("Yellow", forKey: Data.SETTINGS_COLOR)
            },
            .default(Text("Blue")) {
                main.appColor = Color("Blue")
                UserDefaults.standard.set("Blue", forKey: Data.SETTINGS_COLOR)
            },
            .default(Text("Orange")) {
                main.appColor = Color("Orange")
                UserDefaults.standard.set("Orange", forKey: Data.SETTINGS_COLOR)
            },
            .cancel()
        ])
    }

    var body: some View {
        let list = List {
            Section(header: Text("Game settings")) {
                SettingsSwitch(title: "Mark same numbers", key: Data.SETTINGS_MARK_NUMBERS)
                SettingsSwitch(title: "Highlight lines", key: Data.SETTINGS_MARK_LINES)
                SettingsSwitch(title: "Check notes", key: Data.SETTINGS_CHECK_NOTES)
            }
            Section(footer: Text("Changes when you start a new game")) {
                SettingsSwitch(title: "Show Errors", key: Data.SETTINGS_SHOW_ERRORS)
                SettingsSwitch(title: "Play with Timer", key: Data.SETTINGS_SHOW_TIME)
            }
            Section(header: Text("More")) {
                SettingsButton(title: "Color of the app", action: { colorChooser = true })
                SettingsButton(title: "Reset your statistics", action: { alert = true })
                SettingsButton(title: "Contact", action: { UIApplication.shared.open(URL(string: "https://philipphofer.de/contact")!) })
            }
            .actionSheet(isPresented: self.$colorChooser) {
                colorChooserActionSheet
            }
            .alert(isPresented: self.$alert) {
                Alert(title: Text("Delete Statistics"),
                    message: Text("Do you want to delete all you statistics?"),
                    primaryButton: .destructive(Text("Delete"), action: { UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!) }),
                    secondaryButton: .default(Text("Cancel")))
            }
        }
        .navigationBarTitle("Settings")

        if #available(iOS 14.0, *) {
            list.listStyle(.insetGrouped)
        } else {
            list.listStyle(.grouped)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
