//
//  SnapCarouselView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/24.
//

import SwiftUI

struct SnapCarouselView: View {
    
    @State var currentIndex : Int = 0
    
    @State var posts : [SnapCarouselPost] = []
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(alignment: .leading, spacing: 12) {
                Button {
                    
                } label: {
                    Label {
                        Text("Back")
                            .fontWeight(.semibold)
                    } icon: {
                        Image(systemName: "chevron.left")
                            .font(.title2.bold())
                    }
                    .foregroundColor(.primary)
                }

                Text("My Wishes")
                    .font(.title2.bold())
                    .fontWeight(.black)
                
                SnapCarousel(index: $currentIndex, items: posts) { post in
                    GeometryReader{ proxy in
                        let size = proxy.size
                        Image(post.postImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width)
                            .cornerRadius(12)
                        
                    }
                }
                .padding(.vertical, 40)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            for index in 1...5 {
                posts.append(SnapCarouselPost(postImage: "Movie\(index)"))
            }
        }
    }
}

struct SnapCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        SnapCarouselView()
    }
}
