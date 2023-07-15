//
//  ProSwiftUIView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/06.
//

import SwiftUI

struct ProSwiftUIView: View {
    var body: some View {
        Text("안녕하세요. Tunko 입니다.안녕하세요. Tunko 입니다.안녕하세요. Tunko 입니다.안녕하세요. Tunko 입니다.안녕하세요. Tunko 입니다.안녕하세요. Tunko 입니다.안녕하세요. Tunko 입니다.안녕하세요. Tunko 입니다.안녕하세요. Tunko 입니다.")
        .frame(width: 300, height: 100)
        .border(.blue)
        .onTapGesture {
                print(type(of: self.body))
        }
    }
}

struct ProSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProSwiftUIView()
    }
}
