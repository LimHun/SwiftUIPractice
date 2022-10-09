//
//  ReelsModel.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/08.
//

import Foundation
import AVFoundation
 
struct  ReelsBody : Codable {
    var type: Int
    var method : String
    var url : String
    var item : [ReelsItem]
}

struct ReelsItem : Codable, Hashable {
    let uid, isDeleted: Int
    let createdTime, updatedTime: String
    let userUid, productUid, type: Int
    let content: String
    let haveReward, countShared, countComment, countLike: Int
    let countView, isAuthorize: Int
    let authorizeTime: String
    let requestedFilename: String?
    let isRecommend: Int
    let videoFilename, videoThumbnail: String
    let productUidNotInVideo, category: Int
    let productName: String
    let productUserUid, productPriceOriginal, productDiscountRate, productDiscountPrice: Int
    let nickname: String
    let address: String?
    let latitude, longitude: Double
    let profileFilename, imageFilename: String
    let isLiked, isFollow, productCount, distance: Int
    let blockVideoTargetUid, blockUserTargetUid: String?
    var avPlayer: AVPlayer?
    
    enum CodingKeys: String, CodingKey {
        case uid
        case isDeleted
        case createdTime
        case updatedTime
        case userUid
        case productUid
        case type, content
        case haveReward
        case countShared
        case countComment
        case countLike
        case countView
        case isAuthorize
        case authorizeTime
        case requestedFilename
        case isRecommend
        case videoFilename
        case videoThumbnail
        case productUidNotInVideo
        case category
        case productName
        case productUserUid
        case productPriceOriginal
        case productDiscountRate
        case productDiscountPrice
        case nickname, address, latitude, longitude
        case profileFilename
        case imageFilename
        case isLiked
        case isFollow
        case productCount
        case distance
        case blockVideoTargetUid
        case blockUserTargetUid
    }
}
