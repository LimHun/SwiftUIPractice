//
//  SpotifyHeaderAnimationHomeView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/05/04.
//

import SwiftUI

struct SpotifyHeaderAnimationHomeView: View {
 
    var safeArea: EdgeInsets
    var size: CGSize
    
    let screenHeaderHeightRatio: CGFloat = 0.70
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ArtWork()
                
                GeometryReader { proxy in
                    // MARK: Since We Ignored Top Edge
                    let minY = proxy.frame(in: .named("SCROLL")).minY - safeArea.top
                    Button {
                        
                    } label: {
                        Text("SHUFFLE PLAY")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 45)
                            .padding(.vertical, 12)
                            .background {
                                Capsule()
                                    .fill(Color.green.gradient)
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .offset(y: minY < 50 ? -(minY - 50) : 0)
                }
                .frame(height: 50)
                .padding(.top, -34)
                .zIndex(1)
                
                VStack {
                    Text("Popular")
                        .fontWeight(.heavy)
                    
                    AlbumView()
                }
                .padding(.top, 10)
                .zIndex(0)
            }
            .overlay(alignment: .top) {
                HeaderView()
            }
        }
        .coordinateSpace(name: "SCROLL")
    }
    
    @ViewBuilder
    func ArtWork() -> some View {
        let height = size.height * screenHeaderHeightRatio // 화면 높이에 45% 구나
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            
            Image("Movie4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .clipped()
                .overlay {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(
                                .linearGradient(colors: [
                                    .black.opacity(0 - progress),
                                    .black.opacity(0.1 - progress),
                                    .black.opacity(0.3 - progress),
                                    .black.opacity(0.5 - progress),
                                    .black.opacity(0.8 - progress),
                                    .black.opacity(1)
                                ], startPoint: .top, endPoint: .bottom)
                            )
                        
                        VStack(spacing: 0) {
                            Text("Jen\nBlomqvist")
                                .font(.system(size: 45))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            Text("509,082 Monthy Listeners".uppercased())
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .padding(.top, 15)
                        }
                        .opacity(1 + (progress > 0 ? -progress : progress))
                        .padding(.bottom, 55)
                        .offset(y: minY < 0 ? minY : 0)
                    }
                }
                .offset(y: -minY)
        }
        .frame(height: height + safeArea.top)
    }
    
    @ViewBuilder
    func AlbumView() -> some View {
        VStack(spacing: 25) {
            ForEach(spotifyAlbums.indices, id: \.self) { index in
                HStack(spacing: 25) {
                    Text("\(index + 1)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(spotifyAlbums[index].albumName)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Text("2,282,928")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(15)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * screenHeaderHeightRatio
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress = minY / height
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                }

                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Text("FOLLOWING")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .border(.white, width: 1.5)
                }
                .opacity(1 + progress)
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            .overlay(content: {
                Text("Jan Blomqvist")
                    .fontWeight(.semibold)
                    .offset(y: -titleProgress > 0 ? 0 : 45)
                    .clipped()
                    .animation(.easeInOut(duration: 0.25), value: -titleProgress > 0)
            })
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal, .bottom], 15)
            .background {
                Color.black
                    .opacity(-progress > 1 ? 1 : 0)
            }
            .offset(y: -minY)
        }
        .frame(height: 35)
    }
}

struct SpotifyHeaderAnimationHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyHeaderAnimationView()
    }
}
