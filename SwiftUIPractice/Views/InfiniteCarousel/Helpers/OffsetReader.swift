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

struct ValueKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
