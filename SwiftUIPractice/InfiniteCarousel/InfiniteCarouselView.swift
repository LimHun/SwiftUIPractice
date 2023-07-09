//
//  InfiniteCarouselView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/07/08.
//

import SwiftUI

struct InfiniteCarouselView: View {
    var body: some View {
        NavigationStack {
            InfiniteCarouselHome()
                .navigationTitle("Infinite Carousel")
        }
    }
}

struct InfiniteCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteCarouselView()
    }
}
