//
//  CustomCornner.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/04.
//

import SwiftUI

struct CustomCornner: Shape {

    var conners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: conners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
