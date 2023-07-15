//
//  SwiftUIPracticeApp.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/07/17.
//

import SwiftUI

@main
struct SwiftUIPracticeApp: App { 
    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }
    }
}

struct MyView: View {
    var body: some View {
        VStack {
            Text("This is My View")
            NavigationLink(destination: MyView()) {
                Text("Go to My View")
            }
        }
        .navigationBarTitle("My View")
    }
}
