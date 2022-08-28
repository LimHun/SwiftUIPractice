//
//  ListColorChange.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/07/17.
//

import SwiftUI

struct CellItemModule : Identifiable {
    let id = UUID()
    let cellColor : Color
    let emoji : String
}

struct ListColorChange: View {

    let cellDatas : [CellItemModule] = [
        CellItemModule(cellColor: Color.red, emoji: "😙"),
        CellItemModule(cellColor: Color.orange, emoji: "😚"),
        CellItemModule(cellColor: Color.yellow, emoji: "😄"),
        CellItemModule(cellColor: Color.green, emoji: "😁"),
        CellItemModule(cellColor: Color.mint, emoji: "😆"),
        CellItemModule(cellColor: Color.teal, emoji: "🥹"),
        CellItemModule(cellColor: Color.cyan, emoji: "😙"),
        CellItemModule(cellColor: Color.blue, emoji: "😚"),
        CellItemModule(cellColor: Color.indigo, emoji: "😄"),
        CellItemModule(cellColor: Color.purple, emoji: "😁"),
        CellItemModule(cellColor: Color.pink, emoji: "😆"),
        CellItemModule(cellColor: Color.brown, emoji: "🥹")
    ]

    @State private var reduction : Bool = false

    var body: some View {
        List(cellDatas) { data in
            GeometryReader { pre in
                HStack(alignment: .center, spacing: 10) {
                    Text(data.emoji)
                        .border(.gray, width: 1)
                        .font(.largeTitle)
                        .scaleEffect(reduction ? 0.7 : 2)
                        .onTapGesture {
                            self.reduction.toggle()
                        } 
                    Text(data.emoji)
                        .border(.gray, width: 1)
                        .font(.largeTitle)
                        .fixedSize()
                    Text(data.emoji)
                        .border(.gray, width: 1)
                        .font(.largeTitle)
                        .fixedSize()
                }

            }
            .frame(height: 100)
            .listRowBackground(data.cellColor)
        }
        .background(Color.black)
    }
}

struct ListColorChange_Previews: PreviewProvider {
    static var previews: some View {
        ListColorChange()
    }
}
