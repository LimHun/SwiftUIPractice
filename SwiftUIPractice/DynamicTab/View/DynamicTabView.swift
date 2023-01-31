//
//  DynamicTabView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/01/31.
//

import SwiftUI

// 화면 전체를 GeometryReader로 감싼다.
// 그안에 있는 proxy 데이터를 통해 screenSize를 알아낸다.
// .offsetX 라는 모디파이어를 만든다.
// .offsetX 모디파이어 확인하러 가라

struct DynamicTabView: View {
    //MARK: View Properties
    @State var offset: CGFloat = 0
    @State var currentTab: DynamicTabModel = sampleTabs.first!
    
    var body: some View {
        GeometryReader { proxy in
            let screenSize = proxy.size
            ZStack(alignment: .top) {
                // MARK: Building Custom Header With Dynamic Tabs
                
                // MARK: Page Tab View
                TabView(selection: $currentTab) {
                    ForEach(sampleTabs) { tab in
                        VStack {
                            GeometryReader { proxy in
                                let size = proxy.size
                                
                                Image(tab.sampleImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: size.width, height: size.height)
                                    .clipped()
                            }
                        }
                        .ignoresSafeArea()
                        .offsetX { value in
                            // To Keep Track of Total Offset
                            // Hear is a trick Simply Multiply Offset with (Width Of the tab View * Current Index)
                            if currentTab == tab {
                                // (screenSize.width * CGFloat(indexOf(tab: tab)))
                                // 이코드 추가하고 offset 값이 페이지 별로 늘어났음
                                offset = value - (screenSize.width * CGFloat(indexOf(tab: tab)))
                            }
                        }
                        .tag(tab)
                    }
                }
                .ignoresSafeArea()
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                Text("\(offset)")
                    .offset(y: 400)
                
                DynamicTabHeader(size: screenSize)
            }
            .frame(width: screenSize.width, height: screenSize.height)
        }
    }
    
    @ViewBuilder
    func DynamicTabHeader(size: CGSize) -> some View {
        VStack(alignment: .leading, spacing: 22) {
            Text("Dynamic Tabs")
                .font(.title.bold())
                .foregroundColor(.white)
            
            // MARK: I'm Going to Show Two Types of Dynamic Tabs
            // Type 1:
            HStack(spacing: 0) {
                ForEach(sampleTabs) { tab in
                    Text(tab.tabName)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
            }
            .background(alignment: .bottomLeading) {
                Capsule()
                    .fill(.white)
                    // MARK: Don't forgot to remove your padding in screen Width
                    .frame(width: (size.width - 30) / CGFloat(sampleTabs.count), height: 4)
                    .offset(y: 12)
                    .offset(x: tabOffset(size: size, padding: 30))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
                .ignoresSafeArea()
        }
    }
    
    func tabOffset(size : CGSize, padding: CGFloat) -> CGFloat {
        return (-offset / size.width) * ((size.width - padding) / CGFloat(sampleTabs.count))
    }
    
    // MARK: Tab Index
    func indexOf(tab: DynamicTabModel) -> Int {
        let index = sampleTabs.firstIndex { CTab in
            CTab == tab
        } ?? 0
        return index
    }
}

struct DynamicTabView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicTabView()
    }
}
