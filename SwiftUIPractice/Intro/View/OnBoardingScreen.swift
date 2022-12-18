//
//  OnBoardingScreen.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2022/12/18.
//

import SwiftUI
import Lottie

struct OnBoardingScreen: View {
    
    @State var onboardingItems: [OnBoardingItem] = [
        .init(title: "Request Pickup", subTitle: "Tell us who you're sending it to, what you're sending and when it's best to pickup the package and we will pick it up at the most convenient time", lottieView: .init(name: "bikerider", bundle: .main)),
        .init(title: "Request Pickup2", subTitle: "Tell us who you're sending it to, what you're sending and when it's best to pickup the package and we will pick it up at the most convenient time", lottieView: .init(name: "businessconcept", bundle: .main)),
        .init(title: "Request Pickup3", subTitle: "Tell us who you're sending it to, what you're sending and when it's best to pickup the package and we will pick it up at the most convenient time", lottieView: .init(name: "cyclerider", bundle: .main)),
        .init(title: "Request Pickup4", subTitle: "Tell us who you're sending it to, what you're sending and when it's best to pickup the package and we will pick it up at the most convenient time", lottieView: .init(name: "meditatingman", bundle: .main))
    ]
    
    // MARK: current Slide Index
    @State var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            HStack(spacing: 0) {
                ForEach($onboardingItems) { $item in
                    let isLastSlide = (currentIndex == onboardingItems.count - 1)
                    VStack {
                        // MARK: Top Nav Bar
                        HStack {
                            Button("Back") {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                    playAnimation()
                                }
                            }
                            .opacity(currentIndex > 0 ? 1 : 0)
                            
                            Spacer(minLength: 0)
                            Button("Skip") {
                                currentIndex = onboardingItems.count - 1
                                playAnimation()
                            }
                            .opacity(isLastSlide ? 0 : 1)
                        }
                        .tint(Color("Green"))
                        .fontWeight(.bold)
                        
                        // MARK: Movable Slides
                        VStack(spacing: 15) {
                            let offset = -CGFloat(currentIndex) * size.width
                            
                            // MARK: Resizable Lottie View
                            ResizableLottieView(onboardingItem: $item)
                                .frame(height: size.width)
                                .onAppear {
                                    // MARK: Intially Playing First Slide Animation
                                    if currentIndex == indexOf(item) {
                                        item.lottieView.play(toProgress: 0.7)
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5), value: currentIndex)
                            
                            Text(item.title)
                                .font(.title.bold())
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.1), value: currentIndex)
                            
                            Text(item.subTitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 15)
                                .foregroundColor(.gray)
                                .offset(x: offset)
                                .animation(.easeInOut(duration: 0.5).delay(0.2), value: currentIndex)
                        }
                        
                        // MARK: Next / Login Button
                        VStack(spacing: 15) {
                            Text(isLastSlide ? "Login" : "Next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, isLastSlide ? 13 : 12)
                                .frame(maxWidth: .infinity)
                                .background {
                                    Capsule()
                                        .fill(Color("Green"))
                                }
                                .padding(.horizontal, isLastSlide ? 30 : 100)
                                .onTapGesture {
                                    //MARK: Updating to Next Index
                                    if currentIndex < onboardingItems.count - 1 {
                                        // MARK: pausing previous animation
                                        let currentProgress = onboardingItems[currentIndex].lottieView.currentProgress
                                        onboardingItems[currentIndex].lottieView.currentProgress = (currentProgress == 0 ? 0.7 : currentProgress)
                                        currentIndex += 1
                                        
                                        //MARK: playing next animation from start
                                        playAnimation()
                                    }
                                }
                        }
                        
                        Spacer(minLength: 0)
                        
                        HStack {
                            Text("Terma of Service")
                            Text("Privacy Policy")
                        }
                        .font(.caption2)
                        .underline(true, color: .primary)
                        .offset(y : 5)
                    }
                    .animation(.easeInOut, value: isLastSlide)
                    .padding(15)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(onboardingItems.count), alignment: .leading)
        }
    }
    
    // MARK: Retreving Index of the Item in the Array
    func indexOf(_ item: OnBoardingItem) -> Int {
        if let index = onboardingItems.firstIndex(of: item) {
            return index
        }
        
        return 0
    }
    
    func playAnimation() {
        onboardingItems[currentIndex].lottieView.currentProgress = 0
        onboardingItems[currentIndex].lottieView.play(toProgress: 0.7)
    }
}

struct OnBoardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

// MARK: Resizable Lottie View Without Background
struct ResizableLottieView: UIViewRepresentable {
    
    @Binding var onboardingItem: OnBoardingItem
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func setupLottieView(_ to: UIView) {
        let lottieView = onboardingItem.lottieView
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor)
        ]
        
        to.addSubview(lottieView)
        to.addConstraints(constraints)
    }
}
