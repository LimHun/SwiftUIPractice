//
//  OnBoardingSlideView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2023/03/05.
//

import SwiftUI

struct OnBoardingSlideView: View {
     
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            OnBoardingContentView(screenSize: size)
                .preferredColorScheme(.dark)
        }
    }
}

struct OnBoardingSlideView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingSlideView()
    }
}
