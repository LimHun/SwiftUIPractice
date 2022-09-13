//
//  Info.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/06.
//

import SwiftUI

struct Info : Identifiable {
    var id : String = UUID().uuidString
    var title : String
    var amount: String
    var percentage : Int
    var loss: Bool = false
    var icon : String
    var iconColor : Color
}

var infos: [Info] = [
    Info(title: "Revenue", amount: "$2.047", percentage: 10, loss: true, icon: "arrow.up.right", iconColor: .pink),
    Info(title: "Orders", amount: "356", percentage: 20, loss: true, icon: "cart", iconColor: .green),
    Info(title: "Dine in", amount: "220", percentage: 10, loss: true, icon: "fork.knife", iconColor: .red),
    Info(title: "Take away", amount: "135", percentage: 5, loss: true, icon: "takeoutbag.and.cup.and.straw.fill", iconColor: .yellow),
]
