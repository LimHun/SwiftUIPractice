//
//  Movie.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/28.
//

import Foundation

struct Movie: Identifiable, Equatable {
    var id = UUID().uuidString
    var moveTitle: String
    var artwork: String
}

var movies: [Movie] = [
    Movie(moveTitle: "Joker", artwork: "Movie1"),
    Movie(moveTitle: "Godzilla", artwork: "Movie2"),
    Movie(moveTitle: "Inception", artwork: "Movie3"),
    Movie(moveTitle: "Star wars", artwork: "Movie4"),
    Movie(moveTitle: "Aliens", artwork: "Movie5"),
    Movie(moveTitle: "Interstellar", artwork: "Movie6")
]
