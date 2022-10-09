//
//  ReelsAPIView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/03.
//

import SwiftUI
import AVKit

var sampleText : String = "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."

struct ReelsAPIView: View {

    @State var showMore : Bool = false
    @State var isMuted = false
    @State var volumeAnimation = false
    
    var player : AVPlayer

    var body: some View {
        ZStack {
            CustomVideoPlayer(player: player)

            GeometryReader { proxy -> Color in
                let minY = proxy.frame(in: .global).minY
                let size = proxy.size
                DispatchQueue.main.async {
                    if -minY < (size.height / 2) && minY < (size.height / 2) {
                        player.play()
//                        print("PLAY")
                    } else {
                        player.pause()
//                        print("PAUSE")
//                        if showMore {
//                            withAnimation {
//                                showMore = false
//                            }
//                        }
                    }
                }
                return Color.clear
            }

            Color.black
                .opacity(0.01)
                .frame(width: 150, height: 150)
                .onTapGesture {
                    if volumeAnimation {
                        return
                    }

                    isMuted.toggle()
                    player.isMuted = isMuted
                    withAnimation{
                        volumeAnimation.toggle()
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation{
                            volumeAnimation.toggle()
                        }
                    }
                }

            VStack {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 15) {
                            Image("Hun")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())

                            Text("LimHun")
                                .font(.callout.bold())
                                .foregroundColor(.white)

                            Button {

                            } label: {
                                Text("Follow")
                                    .font(.caption.bold())
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.leading, 12)

                        ZStack {
                            if showMore {
                                VStack(spacing: 0) {
                                    ScrollView(.vertical, showsIndicators: false) {
                                        Text("Title" + sampleText)
                                            .foregroundColor(.white)
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                    }
                                    HStack {
                                        Button {
                                            withAnimation{
                                                showMore.toggle()
                                            }
                                        } label: {
                                            Text("hide")
                                                .font(.callout.bold())
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                    }
                                }
                                .frame(height: 120)
                                .padding()
                            } else {
                                Button {
                                    withAnimation{
                                        showMore.toggle()
                                    }
                                } label: {
                                    HStack {
                                        Text("Description")
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .lineLimit(1)

                                        Text("more")
                                            .font(.callout.bold())
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .frame(maxWidth:.infinity, alignment: .leading)
                                }
                            }
                        }
                    }

                    Spacer(minLength: 20)

                    // List of Button
                    ReelsAPIActionButton()
                        .padding(10) 
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)

            Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(.secondary)
                .clipShape(Circle())
                .foregroundColor(.black)
                .opacity(volumeAnimation ? 1 : 0)
        }
    }
}


struct ReelsAPIActionButton : View {
    var body: some View {
        VStack(spacing:25) {
            Button {

            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "suit.heart")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("223K")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                }
            }
            Button {

            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "bubble.right")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("120")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                }
            }
            Button {

            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "paperplane")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

//struct ReelsAPIView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReelsAPIView()
//    }
//}
