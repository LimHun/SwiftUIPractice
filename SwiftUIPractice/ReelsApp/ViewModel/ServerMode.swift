//
//  ServerMode.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/09.
//

import Foundation

enum ServerMode {
    case Main
    case Test
}

struct WeegleServer {
    
    static var mode: ServerMode = .Test
    
    static var url: String {
        return mode == .Main
        ? "http://3.34.65.237:3456"
        : "http://52.78.124.248:3456"
    }
    static var convertedAWS: String {
        return mode == .Main
        ? "https://main-server-weggle-bucket-media-convert.s3.ap-northeast-2.amazonaws.com"
        : "https://weggle-bucket-media-convert.s3.ap-northeast-2.amazonaws.com"
    }
    static var AWS: String {
        return mode == .Main
        ? "https://main-server-weggle-bucket.s3.ap-northeast-2.amazonaws.com"
        : "https://weggle-bucket.s3.ap-northeast-2.amazonaws.com"
    }
}
