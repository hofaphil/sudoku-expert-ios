import SwiftUI

struct StatusBar: View {

    @EnvironmentObject var main: MainModel

    @State var actionSheet = false
    @State var options = false

    @State var settings = false
    @State var statistics = false

    var newGameMenu: some View {
        Menu {
            Button(action: { main.startNewGame(difficulty: Difficulty.BEGINNER) }) {
                Label(Difficulty.BEGINNER.asString, systemImage: "1.square.fill")
            }
            Button(action: { main.startNewGame(difficulty: Difficulty.ADVANCED) }) {
                Label(Difficulty.ADVANCED.asString, systemImage: "2.square.fill")
            }
            Button(action: { main.startNewGame(difficulty: Difficulty.EXPERT) }) {
                Label(Difficulty.EXPERT.asString, systemImage: "3.square.fill")
            }
        } label: {
            Image(systemName: "plus").font(.title).frame(width: 40, height: 40).foregroundStyle(Color.tertiary)
        }
    }

    var optionMenu: some View {
        Menu {
            Button(action: {
                if let link = ShareClass.generateShareLink(sudoku: main.game, difficulty: main.difficulty) {
                    let av = UIActivityViewController(activityItems: [link], applicationActivities: nil)
                    let window = UIApplication.shared.connectedScenes
                        .compactMap { $0 as? UIWindowScene }
                        .flatMap { $0.windows }
                        .first { $0.isKeyWindow }
                    window?.rootViewController?.present(av, animated: true, completion: nil)
                }
            }) {
                Label("challenge", systemImage: "person.2.fill")
            }
            Button(action: { statistics = true }) {
                Label("statistics", systemImage: "chart.bar.xaxis")
            }
            Button(action: {
                UIApplication.shared.open(URL(string: "https://apps.apple.com/app/sudoku-expert/id1641677021")!)
            }) {
                Label("rate", systemImage: "star.fill")
            }
            Button(action: {
                settings = true
            }) {
                Label("settings", systemImage: "gearshape.fill")
            }
        } label: {
            Image(systemName: "ellipsis").font(.title).frame(width: 40, height: 40).foregroundStyle(Color.tertiary)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                newGameMenu
                Spacer()
                Text(UserDefaults.standard.bool(forKey: Storage.GAME_SHOW_TIME) ? main.time : "--:--").font(.largeTitle).bold().foregroundStyle(Color.statusBarText)
                Spacer()
                optionMenu
            }
            .padding()
            HStack {
                Spacer()
                Text(main.difficulty.asString)
                Spacer()
                Text(UserDefaults.standard.bool(forKey: Storage.GAME_SHOW_ERRORS) ? "\(main.game.overallErrors) / 3 Errors" : "- / 3 Errors")
                Spacer()
            }
            .padding(.top, 6).padding(.bottom, 6).border(Color.border, width: 2).padding(EdgeInsets(top: 0, leading: 2, bottom: 2, trailing: 2))
        }
        .background(Color.statusBarBackground)
        .navigationDestination(isPresented: $settings) { SettingsView() }
        .navigationDestination(isPresented: $statistics) { StatisticsView() }
    }
}

struct StatusBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StatusBar().environmentObject(MainModel())
        }
    }
}
