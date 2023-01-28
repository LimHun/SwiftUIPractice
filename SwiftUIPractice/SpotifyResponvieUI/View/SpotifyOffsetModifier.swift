//
//  OffsetModifier.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/01/28.
//

import SwiftUI

struct SpotifyOffsetModifier: ViewModifier {
    
    @Binding var offset: CGFloat
    
    // Optional to return value from 0
    var returnFromStart: Bool = true
    @State var startValue: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    //Color.red.opacity(0.1)//clear
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")).minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            if startValue == 0 {
                                startValue = value
                            }
                            offset = (value - (returnFromStart ? startValue : 0))
                        }
                }
            }
    }
} 

// MARK: Preference Key
struct OffsetKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
