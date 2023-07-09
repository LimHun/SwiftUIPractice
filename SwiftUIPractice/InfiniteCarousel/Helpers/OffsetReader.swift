//
//  OffsetReader.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/07/09.
//

import SwiftUI

struct InfinitiyOffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func offsetX(_ addObserver: Bool, completion: @escaping (CGRect) -> ()) -> some View {
        self
            .frame(maxWidth: .infinity)
            .overlay {
                if addObserver {
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        
                        Color.clear
                            .preference(key: InfinitiyOffsetKey.self, value: rect)
                            .onPreferenceChange(InfinitiyOffsetKey.self, perform: completion)
                    }
                }
            }
    }
}


struct ValueKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
