//
//  InfiniteCarouselHome.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/07/09.
//

import SwiftUI

struct InfiniteCarouselHome: View {
    
    /// View Properties
    @State private var currentPage: String = ""
    @State private var listOfPages: [PageModel] = []
    
    /// Infinite Carousel properties
    @State private var fakedPages: [PageModel] = []
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            TabView(selection: $currentPage) {
                ForEach(fakedPages) { page in
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(page.color.gradient)
                        .frame(width: 300, height: size.height)
                        .tag(page.id.uuidString)
                        .offsetX(currentPage == page.id.uuidString) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIndex(page)))
                            let pageProgress = pageOffset / size.width
                            if -pageProgress < 1.0 {
                                /// Moving to the last Page
                                /// Which is Actually the Firest Duplicated Pgae
                                /// Safe Check
                                if fakedPages.indices.contains(fakedPages.count - 1) {
                                    currentPage = fakedPages[fakedPages.count - 1].id.uuidString
                                }
                            }
                            
                            if -pageProgress > CGFloat(fakedPages.count - 1) {
                                /// Moving to the First Page
                                /// Which is Actually the Last Duplicated Pgae
                                /// Safe Check
                                if fakedPages.indices.contains(1) {
                                    currentPage = fakedPages[1].id.uuidString
                                }
                            }
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .frame(height: 400)
        .onAppear {
            guard fakedPages.isEmpty else { return }
            
            for color in [Color.red, Color.blue, Color.yellow, Color.black, Color.brown] {
                listOfPages.append(.init(color: color))
            }
            
            fakedPages.append(contentsOf: listOfPages)
            
            if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
                firstPage.id = .init()
                lastPage.id = .init()
                
                currentPage = firstPage.id.uuidString
                
                fakedPages.append(firstPage)
                fakedPages.insert(lastPage, at: 0)
            }
        }
    }
    
    func fakeIndex(_ of: PageModel) -> Int {
        return fakedPages.firstIndex(of: of) ?? 0
    }
}

struct InfiniteCarouselHome_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteCarouselHome()
    }
}
