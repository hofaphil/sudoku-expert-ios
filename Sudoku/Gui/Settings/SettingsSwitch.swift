//
//  SettingsSwitch.swift
//  Sudoku
//
//  Created by Philipp Hofer on 29.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SettingsSwitch: View {

    @EnvironmentObject var main: MainModel

    var title: String
    var key: String

    var state: Binding<Bool>

    init(title: String, key: String) {
        self.title = title
        self.key = key
        state = Binding<Bool>(
            get: { UserDefaults.standard.bool(forKey: key) },
            set: { UserDefaults.standard.set($0, forKey: key) }
        )
    }

    var body: some View {
        if #available(iOS 14.0, *) {
            Toggle(title, isOn: state).toggleStyle(SwitchToggleStyle(tint: main.appColor))
        } else {
            Toggle(title, isOn: state)
        }

    }
}

struct SettingsSwitch_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSwitch(title: "Test Title", key: Data.SETTINGS_CHECK_NOTES)
    }
}
