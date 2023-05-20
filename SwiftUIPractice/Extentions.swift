//
//  Extentions.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/01/31.
//

import SwiftUI

// 우선 View를 확정한다.
// .overlay를 통해서 부모뷰에 추가 되는 형태이다.
// 여기서 중요한건 아래 GeometryReader를 사용한다 즉. 부모뷰만큼 채우겠단 소리다.
// 다음으로 let minX를 통해 글로절 좌표상 MinX 값을 얻어온다.
// Color는 부모 뷰를 다 채우는 특징이 있다. 즉 Color로 다 채우고
// Preference를 통해 해당 키값을 가진 변수가 달라질떄마다 이벤트를 호출한다.
// 여기서 이벤트는 completion 함수 클로저이다.
// .onPreferenceChange를 통해서 value 값이 변경되는지 체크하는 것이다.
 
extension View {
    @ViewBuilder
    func offsetX(completion: @escaping (CGFloat) -> Void) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    Color.clear
                        .preference(key: DynamicOffsetKey.self, value: minX)
                        .onPreferenceChange(DynamicOffsetKey.self) { value in
                            completion(value)
                        }
                }
            }
    }
}

struct DynamicOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
