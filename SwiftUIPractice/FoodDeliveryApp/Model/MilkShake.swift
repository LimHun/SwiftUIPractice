//
//  MilkShake.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/17.
//

import SwiftUI

// MARK: Model And Semple Data
struct MilkShake: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var price: String
    var image: String
}

var milkShakes: [MilkShake] = [
    .init(title: "Milk Frappe", price: "$26.99", image: "Shake 1"),
    .init(title: "Milk & Chovalate\nFrappe", price: "$29.99", image: "Shake 2"),
    .init(title: "Frappuvvino", price: "$29.99", image: "Shake 3"),
    .init(title: "Espresso", price: "$19.99", image: "Shake 4"),
    .init(title: "Creme Frappuccino", price: "$39.99", image: "Shake 5"),
]
