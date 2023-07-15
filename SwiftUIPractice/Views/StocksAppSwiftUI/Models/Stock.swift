//
//  Stock.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/28.
//

import Foundation

struct Stock: Decodable {
    let symbol: String
    let description: String
    let price: Double
    let change: String
}
