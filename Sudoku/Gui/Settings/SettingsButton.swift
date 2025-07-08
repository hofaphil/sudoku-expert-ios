import SwiftUI

struct SettingsButton: View {

    let title: LocalizedStringKey
    let action: () -> Void

    @State var state: Bool = false

    init(title: LocalizedStringKey, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(action: { action() }, label: {
            Text(title).foregroundColor(Color.black)
        })
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(title: "TestTitle", action: { print("hello world") })
    }
}
