//
//  ReelsPlayer.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/08.
//

import SwiftUI

struct ReelsPlayer: View {

    @Binding var reel: Reel
    @Binding var currentReel: String
    
    @State var showMore: Bool = false
    @State var isMuted = false
    @State var volumeAnimation = false

    var body: some View {
        ZStack {
            if let player = reel.player {  
                CustomVideoPlayer(player: player)

                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .global).minY
                    let size = proxy.size
                    DispatchQueue.main.async {
                        if -minY < (size.height / 2) && minY < (size.height / 2) && currentReel == reel.id {
                            player.play()
                        } else {
                            player.pause()
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
                        withAnimation {
                            volumeAnimation.toggle()
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            withAnimation {
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

                                Text("iJustine")
                                    .font(.callout.bold())
                                    .foregroundColor(.white)

                                Button {

                                } label: {
                                    Text("Follow")
                                        .font(.caption.bold())
                                        .foregroundColor(.white)
                                }
                            }

                            ZStack {
                                if showMore {

                                    ScrollView(.vertical, showsIndicators: false) {
                                        Text(reel.mediaFile.title + sampleText)
                                            .foregroundColor(.white)
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                    }
                                    .frame(height: 120)
 
                                } else {
                                    Button {
                                        withAnimation {
                                            showMore.toggle()
                                        }
                                    } label: {
                                        HStack {
                                            Text(reel.mediaFile.title)
                                                .font(.callout)
                                                .fontWeight(.semibold)
                                                .lineLimit(1)

                                            Text("more")
                                                .font(.callout.bold())
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.top, 6)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                            }
                        }

                        Spacer(minLength: 20)

                        // List of Button
                        ActionButton(reel: reel)
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
}

struct ReelsPlayer_Previews: PreviewProvider {
    static var previews: some View {
        ReelsApp()
    }
}
