//
//  Sale.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/06.
//

import SwiftUI

struct Sale: Identifiable {
    var id : String = UUID().uuidString
    var sales : Int
    var title : String
}

var dialySales: [Sale] = [
    .init(sales: 20, title: "11:00"),
    .init(sales: 40, title: "12:00"),
    .init(sales: 40, title: "1:00"),
    .init(sales: 150, title: "2:00"),
    .init(sales: 260, title: "3:00"),
    .init(sales: 80, title: "4:00"),
    .init(sales: 120, title: "5:00"),
    .init(sales: 50, title: "6:00"),
    .init(sales: 30, title: "7:00"),
]

