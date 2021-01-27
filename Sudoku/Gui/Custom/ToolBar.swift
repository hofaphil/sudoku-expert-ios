//
//  ToolBar.swift
//  Sudoku
//
//  Created by Philipp Hofer on 27.01.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import SwiftUI

struct ToolBar: View {
    
    @EnvironmentObject var main: MainModel
    
    var title: String
    var backView: Views
    
    init(title: String, backView: Views? = Views.Game) {
        self.title = title
        self.backView = backView!
    }
    
    var body: some View {
        HStack {
            Button("<-", action: {
                self.main.visibleView = backView
            })
            Spacer()
            Text(self.title)
            Spacer()
        }.padding().background(Color.yellow)
    }
}

struct ToolBar_Previews: PreviewProvider {
    static var previews: some View {
        Text("TemplateView")
    }
}
