//
//  SwiftUIPracticeApp.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/07/17.
//

import SwiftUI
import Firebase

@main
struct SwiftUIPracticeApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreen()
//            SocialMediaView() // Firebase 앱
        }
    }
}
