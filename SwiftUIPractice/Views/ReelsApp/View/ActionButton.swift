//
//  ActionButton.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/08.
//

import SwiftUI

struct ActionButton: View {
   var reel: Reel
   var body: some View {
       VStack(spacing: 25) {
           Button {

           } label: {
               VStack(spacing: 10) {
                   Image(systemName: "suit.heart")
                       .font(.title)
                   Text("223K")
                       .font(.caption.bold())
               }
           }
           Button {

           } label: {
               VStack(spacing: 10) {
                   Image(systemName: "bubble.right")
                       .font(.title)
                   Text("120")
                       .font(.caption.bold())
               }
           }
           Button {

           } label: {
               VStack(spacing: 10) {
                   Image(systemName: "paperplane")
                       .font(.title)
               }
           }
       }
   }
}
 
struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ReelsApp()
    }
}
