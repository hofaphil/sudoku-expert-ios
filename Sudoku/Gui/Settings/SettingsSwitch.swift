import SwiftUI

struct SettingsSwitch: View {

    @EnvironmentObject var main: MainModel

    var title: LocalizedStringKey
    var key: String

    var state: Binding<Bool>

    init(title: LocalizedStringKey, key: String) {
        self.title = title
        self.key = key
        state = Binding<Bool>(
            get: { UserDefaults.standard.bool(forKey: key) },
            set: { UserDefaults.standard.set($0, forKey: key) }
        )
    }

    var body: some View {
        Toggle(title, isOn: state).toggleStyle(SwitchToggleStyle(tint: Color.primary))
    }
}

struct SettingsSwitch_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSwitch(title: "Test Title", key: Data.SETTINGS_CHECK_NOTES)
    }
}
