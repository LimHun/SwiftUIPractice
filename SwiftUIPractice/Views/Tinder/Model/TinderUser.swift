//
//  TinderUser.swift
//  SwiftUIPractice
//
//  Created by tunko on 3/19/24.
//

import SwiftUI

struct TinderUser: Identifiable {
    var id = UUID().uuidString
    var name: String
    var place: String
    var profilePic: String
} 
