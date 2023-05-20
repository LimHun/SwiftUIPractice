//
//  LandingScreenView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/02.
//

import SwiftUI

struct LandingScreenView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    
//    let dismissClosure: () -> Void
//    @State private var homeScreenPresentedState = false
    
    var body: some View {
        NavigationLink(destination: HomeScreen()) {
            VStack(spacing: 16) {
                Button("Exit") {
                    presentationMode.wrappedValue.dismiss()
                }
                Text("Go to Home Screen")
                    .onTapGesture {
                        
                }
                let loadCount = LoadCounterViewModel.loadCounterViewModel.increaseAndGetCount(for: .loadingScreen)
                Text("Load count \(loadCount)")
            }
        }
    }
}
