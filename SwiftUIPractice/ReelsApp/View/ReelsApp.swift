//
//  ReelsApp.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/02.
//

import SwiftUI

struct ReelsApp: View {

    init() {
        UITabBar.appearance().isHidden = true
    }

    @StateObject var videoManager = VideoManager()
    @State var currentTab = "house.fill"

    var body: some View {

        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Text("Home")
                    .tag("house.fill")
                Text("Search")
                    .tag("magnifyingglass")

                ReelsView(videos: $videoManager.videos)
                    .tag("Profile")
//                ReelsApiView(videos: $videoManager.videos)
//                    .tag("Profile")

                Text("Liked")
                    .tag("suit.heart")
                Text("Profile")
                    .tag("person.circle")
            }

            HStack(spacing: 0){
                ForEach(["house.fill", "magnifyingglass", "Profile", "suit.heart", "person.circle"], id: \.self) { image in
                    ReelsTabBarButton(image: image, isSystemImage: image != "Profile", currentTab: $currentTab)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)

            .overlay(Divider(), alignment: .top)
            .background(currentTab == "Profile" ? .black : .clear)
        }
    }
}

struct ReelsApp_Previews: PreviewProvider {
    static var previews: some View {
        ReelsApp()
    }
} 
