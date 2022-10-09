//
//  PromotionsScreen.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/02.
//

import SwiftUI

struct PromotionsScreen: View {
    
//    @Binding var homeScreenPresentedState : Bool
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
      
    var body: some View {
        VStack(spacing: 16) {
            Button("Dismiss") {
//                homeScreenPresentedState.toggle()
                presentationMode.wrappedValue.dismiss()
            }
            Text("Welcome to Promotions Screen")
            let loadCount = LoadCounterViewModel.loadCounterViewModel.increaseAndGetCount(for: .promotionsScreen)
            Text("Load count \(loadCount)")
        }
    }
}

//struct PromotionsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PromotionsScreen(homeScreenPresentedState: .constant(false))
//    }
//}
