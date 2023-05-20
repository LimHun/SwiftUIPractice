//
//  MessageCardView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/04.
//

import SwiftUI

struct MessageCardView: View {

    var message: Message

    var body: some View {

        HStack(spacing: 15) {
            Circle()
                .fill(message.tintColor)
                .frame(width: 50, height: 50)
                .opacity(0.8)

            VStack(alignment: .leading, spacing: 8) {
                Text(message.userName)
                    .fontWeight(.bold)

                Text(message.message)
                    .foregroundColor(.secondary)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .padding()
    }
}

struct MessageCardView_Previews: PreviewProvider {
    static var previews: some View {
        MessageCardView(message: Message(message: "message test test tes  test test", userName: "LimHun", tintColor: .pink))
    }
}
