//
//  StickyHeaderView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/04.
//

import SwiftUI

struct StickyHeaderView: View {
    @Environment(\.dismiss) private var dismiss

    let maxHeight = UIScreen.main.bounds.height / 2.3
    let topEdge : CGFloat

    @State var offset : CGFloat = 0

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                GeometryReader { proxy in
                    StickyTopBar(topEdge: topEdge, offset: $offset, maxHeight: maxHeight)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: getHandeerHeight(), alignment: .bottom)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        .background(
                            Color(.black), in: CustomCornner(conners: [.bottomRight], radius: getCornerRadius())
                        )
                        .overlay(
                            HStack(spacing: 15) {
                                Button {
                                    dismiss()
                                } label: {
                                    Image(systemName: "xmark")
                                        .font(.body.bold())
                                }

                                Group {
                                    Image("Hun")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 35, height: 35)
                                        .clipShape(Circle())

                                    Text("LimHun")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)

                                }
                                .opacity(topBarTitleOpacity())

                                Spacer()
                                Button {

                                } label: {
                                    Image(systemName: "line.3.horizontal.decrease")
                                        .font(.body.bold())
                                }
                            }
                                .padding(.horizontal)
                                .frame(height: 60)
                                .foregroundColor(.white)
                                .padding(.top, topEdge)
                            , alignment: .top)
                }
                .frame(height: maxHeight)
                .offset(y: -offset)
                .zIndex(1)

                // Sample Message

                VStack(spacing: 15) {
                    ForEach(allMessages) { message in
                        MessageCardView(message: message)
                    }
                }
                .zIndex(0)
            }
            .modifier(OffsetModifier(offset: $offset))
        }
    }

    func getHandeerHeight() -> CGFloat {

        let topHeight = maxHeight + offset

        print("maxHeight : \(maxHeight) + offset : \(offset) = \(topHeight) topEdge:(\(topEdge)")
        return topHeight > (60 + topEdge) ? topHeight : (60 + topEdge)
    }

    func getCornerRadius() -> CGFloat {
        let profress = -offset / (maxHeight - (60 + topEdge))
        let value = 1 - profress
        let radius = value * 50
        return offset < 0 ? radius : 50
    }

    func topBarTitleOpacity() -> CGFloat {
        let progress = -(offset + 60) / (maxHeight - (60 + topEdge))
        return progress
    }
}

struct StickyHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        StickyContentView()
    }
}
