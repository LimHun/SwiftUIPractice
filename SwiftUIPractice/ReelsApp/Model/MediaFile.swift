//
//  MediaFile.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/02.
//

import Foundation

struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
}

var mediaFileJSON = [
    MediaFile(url: "video1", title: "video1"),
    MediaFile(url: "video2", title: "video2"),
    MediaFile(url: "video3", title: "video3"),
    MediaFile(url: "video4", title: "video4"),
    MediaFile(url: "video5", title: "video5"),
    MediaFile(url: "video6", title: "video6")
]
