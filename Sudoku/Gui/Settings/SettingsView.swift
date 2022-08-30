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
        ActionSheet(title: Text(LocalizedStringKey("choose-your-color")), message: Text(LocalizedStringKey("choose-your-color-details")), buttons: [
            .default(Text(LocalizedStringKey("green"))) {
                main.appColor = Color("Green")
                UserDefaults.standard.set("Green", forKey: Data.SETTINGS_COLOR)
            },
            .default(Text(LocalizedStringKey("yellow"))) {
                main.appColor = Color("Yellow")
                UserDefaults.standard.set("Yellow", forKey: Data.SETTINGS_COLOR)
            },
            .default(Text(LocalizedStringKey("blue"))) {
                main.appColor = Color("Blue")
                UserDefaults.standard.set("Blue", forKey: Data.SETTINGS_COLOR)
            },
            .default(Text(LocalizedStringKey("orange"))) {
                main.appColor = Color("Orange")
                UserDefaults.standard.set("Orange", forKey: Data.SETTINGS_COLOR)
            },
            .cancel()
        ])
    }

    var body: some View {
        let list = List {
            Section(header: Text(LocalizedStringKey("game-settings"))) {
                SettingsSwitch(title: "mark-same-numbers", key: Data.SETTINGS_MARK_NUMBERS)
                SettingsSwitch(title: "highlight-lines", key: Data.SETTINGS_MARK_LINES)
                SettingsSwitch(title: "check-notes", key: Data.SETTINGS_CHECK_NOTES)
            }
            Section(footer: Text(LocalizedStringKey("changes-on-new-game"))) {
                SettingsSwitch(title: "show-errors", key: Data.SETTINGS_SHOW_ERRORS)
                SettingsSwitch(title: "play-with-timer", key: Data.SETTINGS_SHOW_TIME)
            }
            Section(header: Text(LocalizedStringKey("more"))) {
                SettingsButton(title: "color-of-the-app", action: { colorChooser = true })
                SettingsButton(title: "reset-statistics", action: { alert = true })
                SettingsButton(title: "contact", action: { UIApplication.shared.open(URL(string: "https://philipphofer.de/contact")!) })
            }
            .actionSheet(isPresented: self.$colorChooser) {
                colorChooserActionSheet
            }
            .alert(isPresented: self.$alert) {
                Alert(title: Text(LocalizedStringKey("delete-statistics")),
                    message: Text(LocalizedStringKey("delete-all-statistics")),
                    primaryButton: .destructive(Text(LocalizedStringKey("delete")), action: { UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!) }),
                    secondaryButton: .default(Text(LocalizedStringKey("cancel"))))
            }
        }
        .navigationBarTitle(LocalizedStringKey("settings"))
        list.listStyle(.insetGrouped)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
