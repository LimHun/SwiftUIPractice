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

struct ParallaxScrollEffectView2: View {
    var body: some View {
        NavigationStack {
            ParallaxScrollEffectContentView2()
                .navigationTitle("Parallax Scroll")
        }
    }
}

#Preview {
    ParallaxScrollEffectView()
}
