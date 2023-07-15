//
//  HomeScreen.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/02.
//

import SwiftUI

struct HomeScreen: View {
    
    @State private var sheetPresented = false
//    @Binding var homeScreenPresentedState : Bool
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
//                homeScreenPresentedState.toggle()
            }
            Button("Go to Promotions Screen") {
                sheetPresented.toggle()
            }.sheet(isPresented: $sheetPresented) {
//                PromotionsScreen(homeScreenPresentedState: $homeScreenPresentedState)
                PromotionsScreen()
            }
            let loadCount = LoadCounterViewModel.loadCounterViewModel.increaseAndGetCount(for: .homeScreen)
            Text("Load count \(loadCount)")
        }.navigationTitle("Home Screen")
    }
}

// struct HomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeScreen(homeScreenPresentedState: .constant(false))
//    }
// }
