//
//  ReelsView2.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/09.
//

import SwiftUI
import AVFoundation



struct ReelsView2: View {
    
    @EnvironmentObject var reelsViewModel : ReelsViewModel
    @State var selectedIndex : Int = 0
    @State var currentReel : Int = -1
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            TabView(selection: $selectedIndex) {
                ForEach(reelsViewModel.reelsList, id: \.self) { reelsItem in 
//                    let url = URL(string: "\(WeegleServer.convertedAWS)/\(reelsItem.videoFilename)")
//                    let avPlayer = AVPlayer(url: url!)
                    ReelsAPIView(player: reelsItem.avPlayer!)
                        .frame(width: size.width)
                        .rotationEffect(.init(degrees: -90))
                        .ignoresSafeArea(.all, edges: .top)
                        .tag(reelsItem.uid)
                }
            }
            .onChange(of: selectedIndex, perform: { index in
                print("index : \(index)")
                if let lastElement = reelsViewModel.reelsList.last {
                    if lastElement.uid == index {
                        print("lastElement.uid == index \(lastElement.uid)")
                        Task.init {
                            await reelsViewModel.requestFeedList(reelsViewModel.reelsList.count)
                        }
                    }
                }
//                if let lastElement = videos.last {
//                    if lastElement.id == index {
//                        print("lastElement.id == index \(lastElement.id)")
//                        videoManager.nextPage()
//                    }
//                }
            })
            .rotationEffect(.init(degrees: 90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            currentReel = reelsViewModel.reelsList.first?.uid ?? -1 //reels.first?.id ?? ""
        }
        .onDisappear {
            for item in reelsViewModel.reelsList {
                item.avPlayer!.pause()
            }
        }
    }
}

struct ReelsView2_Previews: PreviewProvider {
    static var previews: some View {
        ReelsView2()
    }
}
