//
//  StateBindingTest.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/27.
//

import SwiftUI

struct FirstView: View {
    @State private var isToggle : Bool = false
    var body: some View {
        VStack {
            Text("isToggle : \(isToggle ? "true" : "false")")
            SecondView(isToggle: $isToggle)
        }
    }
}

struct SecondView: View {
    @Binding var isToggle : Bool
    var body: some View {
        Button {
            isToggle.toggle()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.cyan)
                Text("Toggle")
                    .foregroundColor(.white)
            }
            .frame(width: 150, height: 80)
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
