//
//  Album.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/01/28.
//

import SwiftUI

struct Album: Identifiable {
    var id = UUID().uuidString
    var albumName: String
    var albumImage: String
    var isLiked: Bool = false
}

var albums: [Album] = [
    Album(albumName: "Hun", albumImage: "Album1"),
    Album(albumName: "Hun", albumImage: "Album2"),
    Album(albumName: "Hun", albumImage: "Album3"),
    Album(albumName: "Hun", albumImage: "Album4"),
    Album(albumName: "Hun", albumImage: "Album5"),
    Album(albumName: "Hun", albumImage: "Album6"),
    Album(albumName: "Hun", albumImage: "Album4"),
    Album(albumName: "Hun", albumImage: "Album5"),
    Album(albumName: "Hun", albumImage: "Album6"),
    Album(albumName: "Hun", albumImage: "Album4"),
    Album(albumName: "Hun", albumImage: "Album5"),
    Album(albumName: "Hun", albumImage: "Album6"),
    Album(albumName: "Hun", albumImage: "Album4"),
    Album(albumName: "Hun", albumImage: "Album5"),
    Album(albumName: "Hun", albumImage: "Album6"),
    Album(albumName: "Hun", albumImage: "Album7")
]
