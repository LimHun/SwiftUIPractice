//
//  ParallaxScrollEffectView.swift
//  SwiftUIPractice
//
//  Created by tunko on 1/7/24.
//

import SwiftUI

struct ParallaxScrollEffectView: View {
    var body: some View {
        NavigationStack {
            ParallaxScrollEffectContentView()
                .navigationTitle("Parallax Scroll")
        }
    }
}

#Preview {
    ParallaxScrollEffectView()
}
