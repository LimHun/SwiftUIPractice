//
//  StickyContentView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/04.
//

import SwiftUI

struct StickyContentView: View {
    var body: some View {
        GeometryReader { proxy in

            let topEdge = proxy.safeAreaInsets.top
            StickyHeaderView(topEdge: topEdge)
                .ignoresSafeArea(.all, edges: .top)
        }
        .navigationBarHidden(true)
    }
}

struct StickyContentView_Previews: PreviewProvider {
    static var previews: some View {
        StickyContentView()
    }
}
