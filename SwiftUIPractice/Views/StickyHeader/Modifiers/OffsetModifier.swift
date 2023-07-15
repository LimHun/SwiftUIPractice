//
//  OffsetModifier.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/04.
//

import SwiftUI

struct OffsetModifier: ViewModifier {

    @Binding var offset: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .global).minY

                    // getting value for coordinate space called scroll...

                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    
                    return Color.clear
                }
                ,alignment: .top
            )
    }
}
