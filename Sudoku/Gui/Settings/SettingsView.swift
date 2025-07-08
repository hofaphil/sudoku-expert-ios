import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var main: MainModel

    @State var alert = false

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
                SettingsButton(title: "reset-statistics", action: { alert = true })
                SettingsButton(title: "about", action: { UIApplication.shared.open(URL(string: "https://sudoku-expert.com")!) })
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
