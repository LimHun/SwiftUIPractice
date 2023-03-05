//
//  OnBoardingContentView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2023/03/05.
//

import SwiftUI

struct OnBoardingContentView: View {
    
    var screenSize: CGSize
    @State var offset: CGFloat = 0
    
    var body: some View {
        VStack {
            OffsetPageTabView(offset: $offset) {
                HStack(spacing: 0) {
                    ForEach(intros) { intro in
                        VStack {
                            Image(intro.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: screenSize.height / 3)
                                
                            
                            VStack(alignment: .leading, spacing: 22) {
                                Text(intro.title)
                                    .font(.largeTitle.bold())
                                
                                Text(intro.desription)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                            }
                            .foregroundColor(.white)
                            .padding(.top, 50)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .frame(width: screenSize.width)
                        .border(.blue)
                    }
                }
                .border(.red)
            }
            
            // Animated Indicator...
            HStack(alignment: .bottom) {
                
                HStack(spacing: 12) {
                    ForEach(intros.indices, id: \.self) { index in
                        Capsule()
                            .fill(.white)
                            // increasing width for only current index...
                            .frame(width: getIndex() == index ? 20 : 7, height: 7)
                    }
                }
                .overlay (
                    Capsule()
                        .fill(.white)
                        .frame(width: 20, height: 7)
                        .offset(x: getIndicatorOffset())
                    ,alignment: .leading
                )
                .offset(x: 10, y: -15)
                
                Spacer()
                Button {
                    let index = min(getIndex() + 1, intros.count - 1)
                    offset = CGFloat(index) * screenSize.width
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(20)
                        .background(
                            intros[getIndex()].color,
                            in: Circle()
                        )
                }
                
                Button {
                    let index = intros.count - 1//min(getIndex() + 1, intros.count - 1)
                    offset = CGFloat(index) * screenSize.width
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(20)
                        .background(
                            .blue,
                            in: Circle()
                        )
                }
            }
            .padding()
            .offset(y: -20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .animation(.easeInOut, value: getIndex())
        .onChange(of: offset) { _ in
            print("offset : \(offset) | getIndex: \(getIndex())")
        }
    }
    
    func getIndicatorOffset() -> CGFloat {
        let progress = offset / screenSize.width
        
        // 12 = spacing
        // 7 = Circle size...
        
        let maxWidth: CGFloat = 12 + 7
        return progress * maxWidth
    }
    
    func getIndex() -> Int {
        let progress = round(offset / screenSize.width)
        let index = min(Int(progress), intros.count - 1)
        return index
    }
}

struct OnBoardingContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingSlideView()
    }
}
