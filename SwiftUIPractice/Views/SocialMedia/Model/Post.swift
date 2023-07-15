////
////  Post.swift
////  SwiftUIPractice
////
////  Created by 임훈 on 2022/12/26.
////
//
//import SwiftUI
//import FirebaseFirestoreSwift
//
//struct Post: Identifiable, Equatable, Hashable, Codable {
//    @DocumentID var id: String?
//    var text: String
//    var imageURL: URL?
//    var imageReferenceID: String = ""
//    var publishedDate: Date = Date()
//    var likedIDs: [String] = []
//    var dislikedIDs: [String] = []
//    // MARK: Basic User Info
//    var userName: String
//    var userUID: String
//    var userProfileURL: URL
//    
//    enum CodingKeys: CodingKey {
//        case id
//        case text
//        case imageURL
//        case imageReferenceID
//        case publishedDate
//        case likedIDs
//        case dislikedIDs
//        case userName
//        case userUID
//        case userProfileURL
//    }
//}
