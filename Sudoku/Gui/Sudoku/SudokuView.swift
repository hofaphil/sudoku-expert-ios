//
//  SudokuView.swift
//  Sudoku
//
//  Created by Philipp Hofer on 27.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct SudokuView: View {
    
    @EnvironmentObject var main: MainModel
    
    @State var animate = true
        
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle().frame(maxHeight: .infinity, alignment: .topLeading).foregroundColor(main.appColor).edgesIgnoringSafeArea(.top)
                /* if (main.errorCheck != nil && ((main.numberCount.finished && main.errorCheck!.activeErrors == 0) ||
                    (main.errorCheck!.overallErrors >= 3 && main.showErrors))) {
                    NavigationLink("", destination: EndCardView(won: main.errorCheck!.overallErrors < 3, time: main.timeInt, difficulty: main.difficulty).environmentObject(main), isActive: /*@START_MENU_TOKEN@*/.constant(true)/*@END_MENU_TOKEN@*/)
                } else { */
                    VStack(spacing: 0){
                        StatusBar()
                        if(main.pause) {
                            Text("").frame(height: UIScreen.main.bounds.width)
                        } else if (main.loading){
                            ActivityIndicator(shouldAnimate: $animate).frame(height: UIScreen.main.bounds.width)
                        } else {
                            SudokuGridView(sudoku: main.game)
                        }
                        Spacer()
                        Keyboard()
                        Spacer()
                    }.navigationBarHidden(true).onDisappear(perform: {
                        main.timerRun = false
                    }).onAppear(perform: {
                        main.timerRun = true
                    }).background(MainModel.unSelectedColor)
                // }
            }
        }.accentColor(.black)
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
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
