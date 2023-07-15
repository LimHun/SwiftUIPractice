//
//  VideoPlayerTest.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/21.
//

import SwiftUI
import AVKit

struct VideoPlayerTest: View {
    
    @State var player = AVPlayer()
    @State var toggle: Bool = true
    
    var videoUrl: String = "https://player.vimeo.com/external/291648067.sd.mp4?s=7f9ee1f8ec1e5376027e4a6d1d05d5738b2fbb29&profile_id=164&oauth2_token_id=57447761"
    
    var body: some View {
        VStack {
            Button {
                toggle.toggle()
            } label: {
                Text("toggle")
            }
            toggle ? AnyView(videoView()) : AnyView(EmptyView())
        }
        .navigationBarHidden(true)
    }
}

extension VideoPlayerTest {
    
    @ViewBuilder
    func videoView() -> some View {
        VStack {
            HStack {
                Spacer()
                VideoPlayer(player: player)
                    .onAppear {
                        player = AVPlayer(url: URL(string: videoUrl)!)
                    }
                Spacer()
            }
        }
    }
    
    struct CustomPlayer: UIViewControllerRepresentable {
        let urlString: String
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<CustomPlayer>) -> AVPlayerViewController {
            let controller = AVPlayerViewController()
            let player = AVPlayer(url: URL(string: urlString)!)
            controller.player = player
            player.play()
            return controller
        }
        
        func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<CustomPlayer>) { }
    }

}

struct VideoPlayerTest_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerTest()
    }
}
