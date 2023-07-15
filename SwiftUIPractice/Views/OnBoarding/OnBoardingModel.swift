//
//  OnBoardingModel.swift
//  SwiftUIPractice
//
//  Created by tunko on 2023/03/05.
//

import SwiftUI

struct OnBoardingModel: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var desription: String
    var color: Color
}

var intros: [OnBoardingModel] = [
    OnBoardingModel(image: "Movie1", title: "title1", desription: "description", color: Color.red),
    OnBoardingModel(image: "Movie2", title: "title1", desription: "description", color: Color.red),
    OnBoardingModel(image: "Movie3", title: "title1", desription: "description", color: Color.red),
    OnBoardingModel(image: "Movie4", title: "title1", desription: "description", color: Color.red)
]
