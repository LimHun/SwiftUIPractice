//
//  MyStudy.swift
//  Liberopia
//
//  Created by tunko on 2022/07/26.
//

import SwiftUI

struct VideoGridView: View {

    @StateObject var videoManager = VideoManager()
    var colum = [GridItem(.adaptive(minimum: 160, maximum: 300), spacing: 20)]

    var body: some View {
        //NavigationView {
            VStack {
                HStack {
                    ForEach(Query.allCases, id: \.self) { searchQuery in
                        QureyTag(query: searchQuery, isSelected: videoManager.selectedQuery == searchQuery)
                            .onTapGesture {
                                videoManager.selectedQuery = searchQuery
                            }
                    }
                }

                ScrollView {
                    if videoManager.videos.isEmpty {
                        ProgressView()
                    } else {
                        LazyVGrid(columns: colum, spacing: 20) {
                            ForEach(videoManager.videos, id: \.id) { video in
                                NavigationLink {
                                    VideoView(video: video)
                                } label: {
                                    VideoCard(video: video)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .frame(width: .infinity)
            }
            .background(Color("AccentColor"))
          //  .navigationBarHidden(true)
        //}
    }
}

struct MyStudy_Previews: PreviewProvider {
    static var previews: some View {
        VideoGridView()
    }
}
