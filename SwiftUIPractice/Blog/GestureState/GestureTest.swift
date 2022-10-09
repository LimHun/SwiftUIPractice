//
//  GestureTest.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/04.
//

import SwiftUI

struct GestureTest: View {
    @GestureState var dragGestureState = CGSize.zero
    @GestureState var isLongPressed = false
    @State private var tapCount : Int = 0
     
    
    var body: some View {
        
        let longPressedGesture = LongPressGesture(minimumDuration: 0.5, maximumDistance: 3)
            .updating($isLongPressed) { (value, state, transcation) in
                state = value
            }
            
        
        let dragGesture = DragGesture().updating($dragGestureState) { value, state, transaction in
            state = value.translation
            print("value : \(value)")
            print("state : \(state)")
            print("transaction : \(transaction)")
        }
        
        let tapGesture = TapGesture().onEnded({ value in
            print("tapGesture : \(value)")
            tapCount += 1
        })
        
        ZStack{
            VStack{
                Image("Movie1")
//                    .offset(dragGestureState)
//                    .gesture(dragGesture)
//                    .gesture(tapGesture)
                    .gesture(longPressedGesture)
            }
            
            
            if isLongPressed {
                Rectangle()
                    .fill(.ultraThinMaterial)
            }
            
            
            Text("TapCount : \(tapCount)")
                .font(.largeTitle)
                .foregroundColor(isLongPressed ? Color.white : Color.purple)
        }
    }
}

struct GestureTest_Previews: PreviewProvider {
    static var previews: some View {
        GestureTest()
    }
}
