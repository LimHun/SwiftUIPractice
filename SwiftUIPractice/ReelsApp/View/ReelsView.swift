//
//  ReelsView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/02.
//

import SwiftUI
import AVFoundation

struct ReelsView: View {

    @Binding var videos : [Video]
    @ObservedObject var videoManager : VideoManager
    @State var currentReel = ""
    @State var reels = MediaFileJSON.map { item -> Reel in
        let url = Bundle.main.path(forResource: item.url, ofType: "MOV") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        return Reel(player: player, mediaFile: item)
    }

    @State var selectedIndex: Int = 0

    var body: some View {

        GeometryReader { proxy in
            let size = proxy.size

//            TabView(selection: $currentReel) {
            TabView(selection: $selectedIndex) {

//                ForEach($reels) { $reel in
//
//                    ReelsPlayer(reel: $reel, currentReel: $currentReel)
//                        .frame(width: size.width)
//                        .rotationEffect(.init(degrees: -90))
//                        .ignoresSafeArea(.all, edges: .top)
//                        .tag(reel.id)
//                }

                ForEach(videos) { video in
                    let avPlayer = AVPlayer(url: URL(string: video.videoFiles[0].link)!)
                    ReelsAPIView(player: avPlayer)
                        .frame(width: size.width)
                        .rotationEffect(.init(degrees: -90))
                        .ignoresSafeArea(.all, edges: .top)
                        .tag(video.id)
                }
            }
            .onChange(of: selectedIndex, perform: { index in
                print("index : \(index)")
                if let lastElement = videos.last {
                    if lastElement.id == index {
                        print("lastElement.id == index \(lastElement.id)")
                        videoManager.nextPage()
                    }
                }
            })
            .rotationEffect(.init(degrees: 90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            currentReel = reels.first?.id ?? ""
        }
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ReelsApp()
    }
}

struct ReelsPlayer: View {

    @Binding var reel : Reel
    @Binding var currentReel : String

    @State var showMore : Bool = false
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
                                        withAnimation{
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
                                        .frame(maxWidth:.infinity, alignment: .leading)
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


struct ActionButton : View {
    var reel : Reel
    var body: some View {
        VStack(spacing:25) {
            Button {

            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "suit.heart")
                        .font(.title)
                    Text("223K")
                        .font(.caption.bold())
                }
            }
            Button {

            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "bubble.right")
                        .font(.title)
                    Text("120")
                        .font(.caption.bold())
                }
            }
            Button {

            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "paperplane")
                        .font(.title)
                }
            }
        }
    }
}
