//
//  TestView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/28.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
            Text("Hello, World!")
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
