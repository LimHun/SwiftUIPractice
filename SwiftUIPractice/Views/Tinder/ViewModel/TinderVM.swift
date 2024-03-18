//
//  TinderVM.swift
//  SwiftUIPractice
//
//  Created by tunko on 3/19/24.
//

import SwiftUI

class TinderVM: ObservableObject {
    @Published var fetched_users: [TinderUser] = []
    
    @Published var displaying_users: [TinderUser]?
    
    init() {
        fetched_users = [
            TinderUser(name: "1", place: "aaa", profilePic: "Movie1"),
            TinderUser(name: "2", place: "bbb", profilePic: "Movie2"),
            TinderUser(name: "3", place: "ccc", profilePic: "Movie3"),
            TinderUser(name: "4", place: "ddd", profilePic: "Movie4"),
            TinderUser(name: "5", place: "eee", profilePic: "Movie5"),
            TinderUser(name: "6", place: "aaa", profilePic: "Movie6"),
            TinderUser(name: "7", place: "bbb", profilePic: "Movie7"),
            TinderUser(name: "8", place: "ccc", profilePic: "Movie8"),
            TinderUser(name: "DDD", place: "ddd", profilePic: "Movie9"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie10"),
            TinderUser(name: "AAA", place: "aaa", profilePic: "Movie11"),
            TinderUser(name: "BBB", place: "bbb", profilePic: "Movie12"),
            TinderUser(name: "CCC", place: "ccc", profilePic: "Movie13"),
            TinderUser(name: "DDD", place: "ddd", profilePic: "Movie14"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie15"),
            TinderUser(name: "AAA", place: "aaa", profilePic: "Movie16"),
            TinderUser(name: "BBB", place: "bbb", profilePic: "Movie17"),
            TinderUser(name: "CCC", place: "ccc", profilePic: "Movie18"),
            TinderUser(name: "DDD", place: "ddd", profilePic: "Movie19"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie20"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie21"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie22"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie23"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie24"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie25"),
            TinderUser(name: "1", place: "aaa", profilePic: "Movie1"),
            TinderUser(name: "2", place: "bbb", profilePic: "Movie2"),
            TinderUser(name: "3", place: "ccc", profilePic: "Movie3"),
            TinderUser(name: "4", place: "ddd", profilePic: "Movie4"),
            TinderUser(name: "5", place: "eee", profilePic: "Movie5"),
            TinderUser(name: "6", place: "aaa", profilePic: "Movie6"),
            TinderUser(name: "7", place: "bbb", profilePic: "Movie7"),
            TinderUser(name: "8", place: "ccc", profilePic: "Movie8"),
            TinderUser(name: "DDD", place: "ddd", profilePic: "Movie9"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie10"),
            TinderUser(name: "AAA", place: "aaa", profilePic: "Movie11"),
            TinderUser(name: "BBB", place: "bbb", profilePic: "Movie12"),
            TinderUser(name: "CCC", place: "ccc", profilePic: "Movie13"),
            TinderUser(name: "DDD", place: "ddd", profilePic: "Movie14"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie15"),
            TinderUser(name: "AAA", place: "aaa", profilePic: "Movie16"),
            TinderUser(name: "BBB", place: "bbb", profilePic: "Movie17"),
            TinderUser(name: "CCC", place: "ccc", profilePic: "Movie18"),
            TinderUser(name: "DDD", place: "ddd", profilePic: "Movie19"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie20"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie21"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie22"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie23"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie24"),
            TinderUser(name: "FFF", place: "eee", profilePic: "Movie25")
        ]
        
        // storing it in displaying users..
        // what is displaying users?
        // it will be updated/removed based on user interaction to reduce memory usage...
        // and the same time we need all the fetched users data...
        displaying_users = fetched_users
    }
    
    func getIndex(user: TinderUser) -> Int {
        displaying_users?.firstIndex(where: { user.id == $0.id }) ?? 0
    }
}
