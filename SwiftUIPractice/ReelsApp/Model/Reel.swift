//
//  Reel.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/03.
//

import Foundation
import AVFoundation

struct Reel: Identifiable {

    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}
