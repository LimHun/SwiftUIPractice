//
//  ParallaxScrollEffectContentView.swift
//  SwiftUIPractice
//
//  Created by tunko on 1/7/24.
//

import SwiftUI

struct ParallaxScrollEffectContentView: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                DummySection(title: "Social Media")
                
                DummySection(title: "Sales", isLong: true)
                
                ParallaxImageView(usesFullWidth: true) { size in
                    Image(.movie1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 759)
                
                DummySection(title: "Social Media")
                
                DummySection(title: "Sales", isLong: true)
                
                ParallaxImageView(usesFullWidth: true) { size in
                    Image(.movie2)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 200)
                
                DummySection(title: "Social Media")
                
                DummySection(title: "Sales", isLong: true)
                
                ParallaxImageView(usesFullWidth: true) { size in
                    Image(.movie3)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .frame(height: 400)
                
                DummySection(title: "Social Media")
                
                DummySection(title: "Sales", isLong: true)
                
                
            }
            .padding(15)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func DummySection(title: String, isLong: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title.bold())
            
            Text("Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of  (The Extremes of Good and Evil) by Cicero, written in 45 BC. \(isLong ? "This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, comes from a line in section 1.10.32." : "")")
                .multilineTextAlignment(.leading)
                .kerning(1.2)
        }
    }
}

struct ParallaxImageView<Content: View>: View {
    var maximumMovement: CGFloat = 100
    private var content: (CGSize) -> Content
    var usesFullWidth: Bool = false
    
    @State var offset: CGFloat = 0
    
    init(usesFullWidth: Bool, @ViewBuilder content: @escaping (CGSize) -> Content) {
        self.usesFullWidth = usesFullWidth
        self.content = content
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            /// Movement Animation Properties
            let minY = $0.frame(in: .scrollView(axis: .vertical)).minY
            //  보시다시피 스크롤 뷰 높이를 반환합니다. minY와 함께 높이를 사용하여 0에서 1까지의 진행 범위를 정의할 수 있으며, 이를 통해 이미지를 이동하고 시차 효과를 얻을 수 있습니다.
            let scrollViewHeight = $0.bounds(of: .scrollView)?.size.height ?? 0 // 새로운 이름의 좌표 공간을 사용하면 지오메트리 리더를 사용하지 않고 스크롤 뷰의 높이를 읽을 수 있습니다.
            let maximumMovement = min(maximumMovement, (size.height * 1))//0.35))
            let stretchedSize: CGSize = .init(width: size.width, height: size.height + maximumMovement)
            
            //보시다시피 minY를 사용하여 진행을 계산했기 때문에 상단에 도달하는 순간 진행이 0으로 제한됩니다. 하지만 저의 목표는 영상이 화면을 완전히 벗어날 때까지 움직임을 계속하도록 하는 것이었고, 그래서 이제 0에서 -1로 진행 제한을 제거하여 MinY가 상단에 도달한 후에도 움직임이 계속되도록 할 수 있습니다
            
            let progress = minY / scrollViewHeight
            let cappedProgress = max(min(progress, 1.0), -1.0)
            let movementOffset = cappedProgress * -maximumMovement
            
            content(size)
                .offset(y: movementOffset)
                .frame(width: stretchedSize.width, height: stretchedSize.height)
                .frame(width: size.width, height: size.height)
                .overlay(alignment: .top) {
                    VStack {
                        Text("\(cappedProgress)")
                            .font(.title)
                            .foregroundStyle(.white)
                        Text("\(scrollViewHeight)")
                            .font(.title)
                            .foregroundStyle(.white)
                        Spacer()
                        Text("\(cappedProgress)")
                            .font(.title)
                            .foregroundStyle(.white)
                    }
                }
                .clipped()
        }
        // ios 17 에서 부터 지원 연관된 뷰 크기를 늘려버림. (미쳤당)
        .containerRelativeFrame(usesFullWidth ? [.horizontal] : [])
    }
}

#Preview {
    ParallaxScrollEffectView()
}
