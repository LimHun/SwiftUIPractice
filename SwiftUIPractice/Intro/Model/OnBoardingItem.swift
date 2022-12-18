//
//  OnBoardingItem.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2022/12/18.
//

import SwiftUI
import Lottie

struct OnBoardingItem: Identifiable, Equatable {
    var id: UUID = .init()
    var title: String
    var subTitle: String
    var lottieView: LottieAnimationView = .init()
}
