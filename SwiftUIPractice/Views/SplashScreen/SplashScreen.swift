//
//  SplashScreen.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2022/12/14.
//

import SwiftUI
import SDWebImageSwiftUI

struct SplashScreen: View {
    
    @State var animationStarted: Bool = false
    @State var animationFinished: Bool = false
    @State var removeGIF: Bool = false  // 백그라운드에서 돌고있을 GIF 제거 트리거
    
    let timeLoadingGap = DispatchTimeInterval.seconds(Int(2))    // 로딩 직후 애니메이션 시간
    let timeOneCycleGIF = DispatchTimeInterval.seconds(Int(1.5)) // Gif 애니메이션 시간

    var body: some View {
        ZStack {
            
            // 스플래쉬 스크린 이후 첫 화면
            PracticeList()
            
            ZStack {
                Color("BG")
                    .ignoresSafeArea()
                
                ZStack {
                    if !removeGIF {
                        if animationStarted {
                            if animationFinished {
                                Image("logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } else {
                                AnimatedImage(url: getLogoURL())
                                    .aspectRatio(contentMode: .fit)
                            }
                        } else {
                            Image("logoStarting")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                .animation(.none, value: animationFinished)
            }
            .opacity(animationFinished ? 0 : 1)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + timeLoadingGap) {
                animationStarted = true
                DispatchQueue.main.asyncAfter(deadline: .now() + timeOneCycleGIF) {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        animationFinished = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + timeOneCycleGIF) {
                        removeGIF = true
                    }
                }
            }
        }
    }
    
    func getLogoURL() -> URL {
        let bundle = Bundle.main.path(forResource: "logo", ofType: "gif")
        let url = URL(fileURLWithPath: bundle ?? "")
        
        return url
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
