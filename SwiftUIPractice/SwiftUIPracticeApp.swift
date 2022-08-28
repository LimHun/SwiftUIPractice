//
//  SwiftUIPracticeApp.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/07/17.
//

import SwiftUI

@main
struct SwiftUIPracticeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PracticeList()
            //ListColorChange()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
