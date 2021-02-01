//
//  SettingsSwitch.swift
//  Sudoku
//
//  Created by Philipp Hofer on 29.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SettingsSwitch: View {
    
    var title: String
    var description: String
    var key: String
    
    var state: Binding<Bool>
    
    init(title: String, description: String, key: String) {
        self.title = title
        self.description = description
        self.key = key
        self.state = Binding<Bool>(
            get: { UserDefaults.standard.bool(forKey: key) },
            set: { UserDefaults.standard.set($0, forKey: key) })
    }
    
    var body: some View {
        Section(footer: Text(description)) {
            if #available(iOS 14.0, *) {
                Toggle(title, isOn: state).toggleStyle(SwitchToggleStyle(tint: Color.yellow))
            }
        }
    }
}

struct SettingsSwitch_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSwitch(title: "Test Title", description: "This is a test description", key: Data.FIELD_IS_NOTES)
    }
}
