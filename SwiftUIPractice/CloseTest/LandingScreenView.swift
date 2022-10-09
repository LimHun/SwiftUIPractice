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
        //NavigationLink(destination: HomeScreen()) {
//        NavigationLink(destination: HomeScreen(homeScreenPresentedState: $homeScreenPresentedState), isActive: $homeScreenPresentedState) {
        NavigationLink(destination: HomeScreen()) {
            VStack(spacing: 16) {
                Button("Exit") {
                    presentationMode.wrappedValue.dismiss()
//                    dismissClosure()
                }
                Text("Go to Home Screen").onTapGesture {
//                    homeScreenPresentedState.toggle()
                }
                let loadCount = LoadCounterViewModel.loadCounterViewModel.increaseAndGetCount(for: .loadingScreen)
                Text("Load count \(loadCount)")
            }
        }
    }
}

//struct LandingScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        LandingScreenView(dismissClosure: {})
//    }
//}
