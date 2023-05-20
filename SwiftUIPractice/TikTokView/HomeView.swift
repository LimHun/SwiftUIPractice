//
//  HomeView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/29.
//

import SwiftUI
import AVKit

struct Player: UIViewControllerRepresentable, Identifiable {
    let id: UUID = .init()
    let player: AVPlayer
    let update: () -> Void

    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = AVPlayerViewController()
        vc.player = player
        vc.showsPlaybackControls = false
        vc.videoGravity = .resizeAspectFill
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        update()
    }
}

struct HomeView: View {

    @State var videos: [TikTokVideo] = TikTokVideo.videos
    @State var selection: Int = 0

    @StateObject var videoManager = VideoManager()

    var body: some View {
        GeometryReader { proxy in
            TabView(selection: $selection) {
                ForEach(Array(videos.enumerated()), id: \.offset) { index, video in
                    Player(player: video.player) {
                        if index == selection {
                            video.player.play()
                        } else {
                            video.player.pause()
                            video.player.seek(to: .zero)
                        }
                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                .rotationEffect(.degrees(-90))
            }
            .frame(width: proxy.size.height, height: proxy.size.width)
            .rotationEffect(.degrees(90), anchor: .topLeading)
            .offset(x: proxy.size.width)
            .tabViewStyle(PageTabViewStyle())
        }
        .onAppear {

        }
        .onDisappear {
            for video in videos {
                video.player.pause()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
