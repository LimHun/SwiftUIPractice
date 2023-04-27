//
//  ShimmerView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2023/04/27.
//

import SwiftUI

struct ShimmerView: View {
    var body: some View {
        VStack(spacing: 20) {
//            Text("Hello world!")
//                .font(.title)
//                .fontWeight(.black)
//                // shimmer Effect
//                .shimmer(.init(tint: .white.opacity(0.5), highlight: .white, blur: 5))
//                .padding()
//                .background {
//                    RoundedRectangle(cornerRadius: 15, style: .continuous)
//                        .fill(.red.gradient)
//                }
//            
//            HStack(spacing: 15) {
//                ForEach(["suit.heart.fill", "box.truck.badge.clock.fill", "sun.max.trianglebadge.exclamationmark.fill"], id: \.self) { sfImage in
//                    Image(systemName: sfImage)
//                        .font(.title)
//                        .fontWeight(.black)
//                        .shimmer(.init(tint: .white.opacity(0.4), highlight: .white, blur: 5))
//                        .frame(width: 40, height: 40)
//                        .padding()
//                        .background {
//                            RoundedRectangle(cornerRadius: 15, style: .continuous)
//                                .fill(.indigo.gradient)
//                        }
//                }
//            }
            
            Image("ic_header_logo-1")
                .font(.title)
                .fontWeight(.black)
                .shimmer(.init(tint: .white.opacity(0.7), highlight: .white, blur: 5))
                .frame(width: 120, height: 40)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color("ReadLogMainColor"))
                }
            
            Image("ic_header_logo-1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .font(.title)
                .fontWeight(.black)
                .shimmer(.init(tint: .white.opacity(0.7), highlight: .white, blur: 5))
                .frame(width: 200, height: 50)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color("ReadLogMainColor"))
                }
            
            Image("ic_header_logo-1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .font(.title)
                .fontWeight(.black)
                .shimmer(.init(tint: .white.opacity(0.7), highlight: .white, blur: 5))
                .frame(width: 360, height: 80)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color("ReadLogMainColor"))
                }
        }
    }
}

struct ShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        ShimmerView()
    }
}
