//
//  QureyTag.swift
//  Liberopia
//
//  Created by tunko on 2022/08/24.
//

import SwiftUI

struct QureyTag: View {
    var query: Query = .food
    var isSelected: Bool = false

    var body: some View {
        Text(query.rawValue)
            .font(.caption)
            .bold()
            .foregroundColor(isSelected ? .black : .gray)
            .padding(10)
            .background(.thinMaterial)
            .cornerRadius(10)
    }
}

struct QureyTag_Previews: PreviewProvider {
    static var previews: some View {
        QureyTag(query: Query.food, isSelected: false)
    }
}
