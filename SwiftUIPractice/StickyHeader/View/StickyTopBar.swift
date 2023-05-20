//
//  SwiftUIView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/04.
//

import SwiftUI

struct StickyTopBar: View {

    var topEdge: CGFloat
    @Binding var offset: CGFloat
    var maxHeight: CGFloat

    var body: some View {

        VStack(alignment: .leading, spacing: 15) {

            Image("Hun")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)

            Text("Lim Hun")
                .font(.largeTitle.bold())

            Text("texteworjweorjiweorijweorijweorijweoriwjeroijweroiwjeroiwjreowierjwoeirjwoerijweoirjweorijwoerijwoeirj")
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .padding(.bottom)
        .opacity(getOpacity())
    }

    func getOpacity() -> CGFloat {
        let progress = -offset / 70
        let opacity = 1 - progress
        return offset < 0 ? opacity : 1
    }
}
