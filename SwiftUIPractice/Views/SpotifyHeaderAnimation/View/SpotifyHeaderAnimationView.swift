//
//  SpotifyHeaderAnimationView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/05/03.
//

import SwiftUI

struct SpotifyHeaderAnimationView: View {
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            SpotifyHeaderAnimationHomeView(safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
        }
        .preferredColorScheme(.dark)
    }
}

struct SpotifyHeaderAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyHeaderAnimationView()
    }
}
