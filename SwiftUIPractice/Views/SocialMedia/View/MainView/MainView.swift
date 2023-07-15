////
////  MainView.swift
////  SwiftUIPractice
////
////  Created by 임훈 on 2022/12/20.
////
//
//import SwiftUI
//
//struct MainView: View {
//    var body: some View {
//        NavigationView { 
//            TabView {
//                PostsView()
//                    .tabItem {
//                        Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
//                        Text("Post's")
//                    }
//                ProfileView()
//                    .tabItem {
//                        Image(systemName: "gear")
//                        Text("Profile")
//                    }
//            }
//            // Changing Tab Lable Tint to Black
//            .tint(.black)
//        }
//    }
//}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
