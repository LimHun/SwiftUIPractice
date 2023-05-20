//
//  Trending.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/06.
//

import SwiftUI

struct Trending: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var subTitle: String
    var count: Int
    var image: String
}

var trendingDishes: [Trending] = [
    Trending(title: "american Favoruite", subTitle: "Order", count: 120, image: "Hun"),
    Trending(title: "american Favoruite", subTitle: "Order", count: 120, image: "Hun"),
    Trending(title: "american Favoruite", subTitle: "Order", count: 120, image: "Hun"),
    Trending(title: "american Favoruite", subTitle: "Order", count: 120, image: "Hun"),
    Trending(title: "american Favoruite", subTitle: "Order", count: 120, image: "Hun")
]
