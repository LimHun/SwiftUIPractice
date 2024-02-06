//
//  TEst.swift
//  SwiftUIPractice
//
//  Created by tunko on 1/15/24.
//

import SwiftUI

struct Test: View {
    var body: some View {
        ZStack {
            Color.blue
            VStack(spacing: 0) {
                ScrollView {
                    Color.green
//                    VStack {
//                        Rectangle().fill(.red).frame(width: 200, height: 100)
//                        Spacer() // 10
//                        
//                        Color.green
//                        
//                        
//                        
//                    }
                }
                .border(1, .red)
                
                // GNB
                Rectangle().fill(.red).frame(height: 60)
            }
        }
    }
}

#Preview {
    Test()
}
