//
//  PostsView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2022/12/26.
//

import SwiftUI

struct PostsView: View {
    
    @State private var createNewPost: Bool = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .hAlign(.center).vAlign(.center)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    createNewPost.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(13)
                        .background(.black, in: Circle())
                }
                .padding(15)
            }
            .fullScreenCover(isPresented: $createNewPost) {
                CreateNewPost { post in
                    
                }
            }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
