//
//  SwiftUIView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/29.
//

import SwiftUI
import AVFoundation



struct TikTokView: View {

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("First")
                }
            Text("Another Tab")
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("First")
                }
            Text("The Last Tab")
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Third")
                }
        }
        .font(.headline)
//        .accentColor(.white)
    }
}

struct TikTokView_Previews: PreviewProvider {
    static var previews: some View {
        TikTokView()
    }
}
