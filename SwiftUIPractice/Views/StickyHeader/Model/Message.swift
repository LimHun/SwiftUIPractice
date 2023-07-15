//
//  Message.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/04.
//

import SwiftUI

struct Message: Identifiable {
    var id = UUID().uuidString
    var message: String
    var userName: String
    var tintColor: Color
}

var allMessages: [Message] = [
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink),
    Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink)
]
