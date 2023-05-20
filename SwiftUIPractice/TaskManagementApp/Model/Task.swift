//
//  Task.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/01/08.
//

import SwiftUI

struct TaskData: Identifiable {
    var id: UUID = .init()
    var dateAdded: Date
    var taskName: String
    var taskDescription: String
    var taskCategory: TaskCategory
}

var sampleTasks: [TaskData] = [
    .init(dateAdded: Date(timeIntervalSince1970: 1673187965), taskName: "Edit YT Video", taskDescription: "tewqtqwetqasdufhiasodijjfhaisdjfhisaoduhfoiasufheiufhasoiefuhaoiseufhoaiseufhaoiseufhoasiuefhaoisuefhaosiufhoisdaufhosaiuehfoiafuheoaisufhsaioufheasoifuheasofiuhsaofiusahfoiasuhfoiseufhwt", taskCategory: .general),
    .init(dateAdded: Date(timeIntervalSince1970: 1673185065), taskName: "Edit YT Video", taskDescription: "qweilorjhqwo\n\n\n\niejnaosdifun", taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: 1673186265), taskName: "Edit YT Video", taskDescription: "qw;eorjnwqeo;jrinskjdnfkjsdnfa", taskCategory: .challenge),
    .init(dateAdded: Date(timeIntervalSince1970: 1673187865), taskName: "Edit YT Video", taskDescription: "eoeoeoeoeoeoeo", taskCategory: .idea),
    .init(dateAdded: Date(timeIntervalSince1970: 1673187965), taskName: "Edit YT Video", taskDescription: "123-098213-091283-129", taskCategory: .challenge),
    .init(dateAdded: Date(timeIntervalSince1970: 1673107965), taskName: "Edit YT Video", taskDescription: "asdkjnfalskdjnf", taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: 1673107965), taskName: "Edit YT Video", taskDescription: "qwpoekj;asldkhfpoqiwe3", taskCategory: .general),
    .init(dateAdded: Date(timeIntervalSince1970: 1673087965), taskName: "Edit YT Video", taskDescription: "qpwoeirnmsdkdkkdkdkdkdkdkdkdk", taskCategory: .modifiers)
]
