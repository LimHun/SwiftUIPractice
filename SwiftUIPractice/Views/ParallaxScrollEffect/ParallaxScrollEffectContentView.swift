//
//  ParallaxScrollEffectContentView.swift
//  SwiftUIPractice
//
//  Created by tunko on 1/7/24.
//

import SwiftUI

struct ParallaxScrollEffectContentView: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                DummySection(title: "Social Media")
                
                DummySection(title: "Sales", isLong: true)
                
                ParallaxImageView(usesFullWidth: true) { size in
                    Image(.movie1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 600)
            }
            .padding(15)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func DummySection(title: String, isLong: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title.bold())
            
            Text("Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of  (The Extremes of Good and Evil) by Cicero, written in 45 BC. \(isLong ? "This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, comes from a line in section 1.10.32." : "")")
                .multilineTextAlignment(.leading)
                .kerning(1.2)
        }
    }
}

struct ParallaxImageView<Content: View>: View {
    var maximumMovement: CGFloat = 100
    private var content: (CGSize) -> Content
    var usesFullWidth: Bool = false
    init(usesFullWidth: Bool, @ViewBuilder content: @escaping (CGSize) -> Content) {
        self.usesFullWidth = usesFullWidth
        self.content = content
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            //
            content(size)
                .frame(width: size.width, height: size.height)
                .clipped()
        }
        // ios 17 에서 부터 지원 연관된 뷰 크기를 늘려버림. (미쳤당)
        .containerRelativeFrame(usesFullWidth ? [.horizontal] : [])
    }
}

#Preview {
    ParallaxScrollEffectView()
}
