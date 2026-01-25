import SwiftUI

struct SudokuView: View {

    @EnvironmentObject var main: MainModel

    @State var animate = true

    var body: some View {
        NavigationView {
            ZStack {
                ZStack {
                    VStack(spacing: 0) {
                        StatusBar()
                        if (main.pause) {
                            Text("").frame(height: UIScreen.main.bounds.width)
                        } else if (main.loading) {
                            ActivityIndicator(shouldAnimate: $animate).frame(height: UIScreen.main.bounds.width)
                        } else {
                            SudokuGridView(sudoku: main.game)
                        }
                        Keyboard()
                    }
                    if (main.wonGame || main.lostGame) {
                        EndCardView(won: main.wonGame, time: main.timeInt, difficulty: main.difficulty)
                        .onDisappear(perform: {
                            main.timerRun = true
                        })
                        .onAppear(perform: {
                            main.timerRun = false
                        })
                    }
                }
                .navigationBarHidden(true)
                .onDisappear(perform: {
                    main.timerRun = false
                })
                .onAppear(perform: {
                    main.timerRun = true
                })
            }
        }
    }
}

struct SudokuView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuView().environmentObject(MainModel())
    }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var shouldAnimate: Bool

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
