import SwiftUI

struct EndCardView: View {

    @EnvironmentObject var main: MainModel

    let won: Bool
    let time: Int
    let difficulty: Difficulty

    let title: LocalizedStringKey

    init(won: Bool, time: Int, difficulty: Difficulty) {
        self.time = time
        self.difficulty = difficulty
        self.won = won

        title = won ? "endcard-win" : "endcard-lose"
    }

    var body: some View {
        ZStack {
            Rectangle().foregroundColor(Color.black.opacity(0.6))
            VStack {
                VStack {
                    Image(systemName: "gamecontroller.fill").font(.title).padding().foregroundStyle(Color.tertiary)
                    Text(title).font(.title2).padding(.bottom)
                }
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .background(Color.statusBarBackground)

                EndCardStatistics(time: won ? MainModel.timeToString(time) : "--:--", difficulty: difficulty)

                Button(action: okButtonAction) {
                    HStack {
                        Text("OK").foregroundStyle(Color.foreground)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .contentShape(Rectangle())
                    .padding()
                    .border(Color.foreground, width: 2)
                }
                .padding().background(Color.statusBarBackground)
            }
            .background(Color.background).foregroundStyle(Color.foreground).padding()
        }
        .edgesIgnoringSafeArea([.top, .bottom])
    }

    func okButtonAction() {
        main.startNewGame(difficulty: main.difficulty)
    }
}

struct EndCardView_Previews: PreviewProvider {
    static var previews: some View {
        EndCardView(won: false, time: 0, difficulty: Difficulty.BEGINNER)
    }
}
