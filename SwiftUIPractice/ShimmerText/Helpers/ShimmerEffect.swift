//
//  ShimmerEffect.swift
//  SwiftUIPractice
//
//  Created by tunko on 2023/04/26.
//

import SwiftUI

struct ShimmerConfig {
    var tint: Color
    var highlight: Color
    var blur: CGFloat = 0
    var highlightOpacity: CGFloat = 1
    var speed: CGFloat = 2
}

// Shimmer Effect Helper
fileprivate struct ShimmerEffectHelper: ViewModifier {
    // Shimmer Config
    var config: ShimmerConfig
    // Animvation Properties
    @State private var moveTo: CGFloat = -0.7
    
    func body(content: Content) -> some View {
        // adding shimmer Animation with The help of masking Modifier
        // Hiding the Normal one and adding shimmer one instead
        content
            .hidden()
            .overlay {
                // Changing Tint Color
                Rectangle()
                    .fill(config.tint)
                    .mask {
                        content
                    }
                    .overlay {
                        // Shimmer
                        GeometryReader {
                            let size = $0.size
                            let extraOffset = size.height / 2.5
                            
                            Rectangle()
                                .fill(config.highlight)
                                .mask {
                                    Rectangle()
                                        .fill(
                                            .linearGradient(colors: [
                                                .white.opacity(0),
                                                config.highlight.opacity(config.highlightOpacity),
                                                .white.opacity(0)
                                            ], startPoint: .top, endPoint: .bottom)
                                        )
                                        // Adding Blur
                                        .blur(radius: config.blur)
                                        // Rotating (Degree: Your Choice of Wish)
                                        .rotationEffect(.init(degrees: -70))
                                        // Moving to the start
                                        .offset(x: moveTo > 0 ? extraOffset : -extraOffset)
                                        .offset(x: size.width * moveTo)
                                }
                                /* you can add another property in the config for blend mode and use it after the mask if you need more customisation
                                 EG: .mask{}.blendMode() */
                                
                        }
                        // Mask with the content
                        .mask {
                            content
                        }
                    }
                    // animating movement
                    .onAppear {
                        /* Sometimes a forever animaiton called inside onAppear will cause animation glitches, especially when using inside NavigationView; to avoid that, simply wrap it inside the DispatchQueue. */
                        DispatchQueue.main.async {
                            moveTo = 0.7
                        }
                    }
                    .animation(.linear(duration: config.speed).repeatForever(autoreverses: false), value: moveTo)
            }
    }
}

extension View {
    @ViewBuilder
    func shimmer(_ config: ShimmerConfig) -> some View {
        self.modifier(ShimmerEffectHelper(config: config))
    }
}

struct ShimmerEffect_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerView()
    }
} 
