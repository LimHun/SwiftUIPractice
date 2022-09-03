//
//  ReelsAPIView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/03.
//

import SwiftUI
import AVKit

struct ReelsAPIView: View {

    var player : AVPlayer?

    var body: some View {
        ZStack {
            CustomVideoPlayer(player: player!)

            GeometryReader { proxy -> Color in
                let minY = proxy.frame(in: .global).minY
                let size = proxy.size
                DispatchQueue.main.async {
                    if -minY < (size.height / 2) && minY < (size.height / 2) {
                        player!.play()
                    } else {
                        player!.pause()
                    }
                }
                return Color.clear
            }
        }
    }
}

//struct ReelsAPIView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReelsAPIView()
//    }
//}
