//
//  LoadingView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2022/12/19.
//

import SwiftUI

// 전역적으로 사용되는 로딩 프로그래스 뷰
struct LoadingView: View {
    @Binding var show: Bool
    var body: some View {
        ZStack {
            if show {
                Group {
                    Rectangle()
                        .fill(.black.opacity(0.25))
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .padding(15)
                        .background(.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: show)
    }
}
