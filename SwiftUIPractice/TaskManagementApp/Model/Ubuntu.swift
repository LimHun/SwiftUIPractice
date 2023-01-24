//
//  Ubuntu.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/01/06.
//

import SwiftUI

// MARK: Custom Font Extension
enum Ubunut {
    case light
    case bold
    case medium
    case regular
    
    var weight : Font.Weight {
        switch self {
        case .light:
            return .light
        case .bold:
            return .bold
        case .medium:
            return .medium
        case .regular:
            return .regular
        }
    }
}

extension View {
    func ubuntu(_ size: CGFloat, _ weight: Ubunut) -> some View {
        self.font(.custom("Ubuntu", size: size))
            .fontWeight(weight.weight)
    }
}
