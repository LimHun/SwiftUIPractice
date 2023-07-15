//
//  DynamicTabModel.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/01/31.
//

import SwiftUI

struct DynamicTabModel: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var tabName: String
    var sampleImage: String
}

var sampleTabs: [DynamicTabModel] = [
    .init(tabName: "첫번쨰탭", sampleImage: "Movie1"),
    .init(tabName: "두번쨰탭", sampleImage: "Movie2"),
    .init(tabName: "세번쨰탭", sampleImage: "Movie3")
]
