//
//  TouchAnimationView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/28.
//

import SwiftUI

struct TouchAnimationView: View {

    @GestureState var location: CGPoint = .zero

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            // MARK: To Fit Into Whole View
            // Calculating Item

            let width = (size.width / 10)
            // Multiplaying Each Row Count
            let itemCount = Int((size.height / width).rounded()) * 10

            // MARK: For Solid Linear Gradient
            // We'ro going to use Mask
            LinearGradient(colors: [.cyan, .yellow, .mint, .pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                .mask {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 10), spacing: 0) {
                        ForEach(0..<itemCount, id: \.self) { _ in
                            GeometryReader { innerProxy in
                                let rect = innerProxy.frame(in: .named("GESTURE"))
                                let scale = itemScale(rect: rect, size: size)

                                // MARK: Instead Of Manual Calculation
                                // We're going to use UIKit's CGAffineTransform

                                let transformedRect = rect.applying(.init(scaleX: scale, y: scale))

                                // MARK: Transforming Location TOO
                                let transformedLocation = location.applying(.init(scaleX: scale, y: scale))

                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.orange)
                                    .scaleEffect(scale)

                                    // MARK: For Effect 1
                                    // We Need to Re-Locate Event Item To Currently Draging Postion
                                    .offset(x: (transformedRect.midX - rect.midX), y: (transformedRect.midY - rect.midY))
                                    .offset(x: location.x - transformedLocation.x, y: location.y - transformedLocation.y)

                                    // MARK: For Effect 2
                                    //.scaleEffect(scale)

                            }
                            .padding(5)
                            .frame(height: width)
                        }
                    }
                }
        }
        .padding(15)
        .gesture(
            DragGesture(minimumDistance: 0)
                .updating($location, body: { value, out, _ in
                    out = value.location
                })
        )
        .coordinateSpace(name: "GESTURE") // 화면을 기준으로 한 좌표 집합의 컨텍스트(또는 공간)를 나타냅니다.
        .preferredColorScheme(.dark)
        .animation(.easeInOut, value: location == .zero)
    }

    // MARK: Calculationg Scale For Each Item With the Help Of Pythagorean Theorem
    func itemScale(rect: CGRect, size: CGSize) -> CGFloat {
        let a = location.x - rect.midX
        let b = location.y - rect.midY

        let root = sqrt((a * a) + (b * b))
        let diagonalValue = sqrt((size.width * size.width) + (size.height * size.height))

        // MARK: Main Grid Magnifiction Effect
        // Simply Give Any Number (This will be the Circle Size)
        // For the Video I'm Giving 150
        let scale = (root - 150) / 150
        // MARK : For More Detail Divide Digonal Value
        //let scale = root / (diagonalValue / 2)
        let modifiedScale = location == .zero ? 1 : (1 - scale)

        return modifiedScale > 0 ? modifiedScale : 0.001
    }
}

struct TouchAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TouchAnimationView()
    }
}
