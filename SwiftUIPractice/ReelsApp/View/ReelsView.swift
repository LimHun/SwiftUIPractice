//
//  ReelsView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/02.
//

import SwiftUI
import AVFoundation

struct ReelsView: View {

    @Binding var videos : [Video]
    @ObservedObject var videoManager : VideoManager
    @State var currentReel = ""
    @State var reels = MediaFileJSON.map { item -> Reel in
        let url = Bundle.main.path(forResource: item.url, ofType: "MOV") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        return Reel(player: player, mediaFile: item)
    }

    @State var selectedIndex: Int = 0

    var body: some View {

        GeometryReader { proxy in
            let size = proxy.size

            TabView(selection: $selectedIndex) {

                ForEach(videos) { video in
                    let avPlayer = AVPlayer(url: URL(string: video.videoFiles[0].link)!)
                    ReelsAPIView(player: avPlayer)
                        .frame(width: size.width)
                        .rotationEffect(.init(degrees: -90))
                        .ignoresSafeArea(.all, edges: .top)
                        .tag(video.id)
                }
            }
            .onChange(of: selectedIndex, perform: { index in
                print("index : \(index)")
                if let lastElement = videos.last {
                    if lastElement.id == index {
                        print("lastElement.id == index \(lastElement.id)")
                        videoManager.nextPage()
                    }
                }
            })
            .rotationEffect(.init(degrees: 90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            currentReel = reels.first?.id ?? ""
        }
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsApp()
    }
}
 
