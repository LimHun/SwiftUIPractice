//
//  EnvironmentTest.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/29.
//

import SwiftUI

class EnvironmentClass: ObservableObject {
    @Published var name: String
    @Published var option: String
    init(name: String, option: String) {
        self.name = name
        self.option = option
    }
}

struct EnvironmentTest: View {
    @StateObject var envClass = EnvironmentClass(name: "Tunk", option: "😀")
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor: Bool
    @Environment(\.description) var description: String
    
    var body: some View {
        ScrollView {
            VStack {
                Text("description : \(description)")
                    .textSelection(.enabled)
                NextView()
                    .environmentObject(envClass)
            }
        }
    }
}

struct NextView: View {
    @EnvironmentObject var envClass: EnvironmentClass
    var body: some View {
        Text("NextView name :\(envClass.name) option :\(envClass.option)")
    }
}

struct EnvironmentTest_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentTest()
    }
}
