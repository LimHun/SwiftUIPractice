//
//  TikTokVideo.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/29.
//

import Foundation 
import AVKit

struct TikTokVideo {
    struct Profile {
        let img : String
    }
    struct Sound {
        let name : String
    }
    let id: UUID = UUID()
    let player: AVPlayer
    let title: String
    let caption: String
    let profile: Profile
    let sound: Sound

    static let videos = (1...6)
        .compactMap {
            Bundle.main.url(forResource: "video\($0)", withExtension: "MOV")
        }
        .map(AVPlayer.init(url:))
        .enumerated()
        .map { offset, video in
            TikTokVideo(
                player: video,
                title: "video\(offset)",
                caption: "Video # \(offset)",
                profile: .init(img: "me"),
                sound: .init(name: "sound"))
        }
}
