//
//  SpotifyResponvieUI.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/01/28.
//

import SwiftUI

struct SpotifyResponvieUI: View {
    
    // MARK: for smooth Sliding Effect
    @Namespace var animation
    
    @State var currentType: String = "Popular"
    @State var _albums: [Album] = albums
    
    @State var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                HeaderView()
                
                // MARK: Pinned Header with Content
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        SongList()
                    } header: {
                        PinnedHeaderView()
                            .background(Color.black)
                            .offset(y: headerOffsets.1 > 0 ? 0 : 40)//-headerOffsets.1 / 8)
                            .modifier(SpotifyOffsetModifier(offset: $headerOffsets.0, returnFromStart: false))
                            .modifier(SpotifyOffsetModifier(offset: $headerOffsets.1))
                    }
                }
                
            }
        }
        .overlay(content: {
            Rectangle()
                .fill(.black)
                .frame(height: 50)
                .frame(maxHeight: .infinity, alignment: .top)
                .opacity(headerOffsets.0 < 5 ? 1 : 0)
        })
        .coordinateSpace(name: "SCROLL")
        .ignoresSafeArea(.container, edges: .vertical)
    }
    
    @ViewBuilder
    func SongList()->some View {
        VStack(spacing: 25) {
            ForEach($_albums) { $albums in
                HStack(spacing: 12) {
                    
                    Text("#\(getIndex(album: albums) + 1)")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Image(albums.albumImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 55)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(albums.albumName)
                            .fontWeight(.semibold)
                        
                        Label {
                            Text("65,587,909")
                        } icon: {
                            Image(systemName: "beats.headphones")
                                .foregroundColor(.white)
                        }
                        .foregroundColor(.gray)
                        .font(.caption)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        albums.isLiked.toggle()
                    } label: {
                        Image(systemName: albums.isLiked ? "suit.heart.fill" : "suit.heart")
                            .font(.title3)
                            .foregroundColor(albums.isLiked ? Color("Green") : .white)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        .padding(.top, 25)
        .padding(.bottom, 100)
    }
    
    func getIndex(album: Album) -> Int {
        return _albums.firstIndex { currentAlbum in
            return album.id == currentAlbum.id
        } ?? 0
    }
    
    // MARK: Header View
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = (size.height + minY)
            
            Image("Movie2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: height, alignment: .top)
                .overlay {
                    ZStack(alignment: .bottom) {
                        LinearGradient(colors: [
                            .clear, .black.opacity(0.8)
                        ], startPoint: .top, endPoint: .bottom)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("ARTIST")
                                .foregroundColor(.gray)
                                .font(.callout)
                            
                            HStack(alignment: .bottom, spacing: 10) {
                                Text("Ariana Grande")
                                    .font(.title.bold())
                                
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                                    .background {
                                        Circle()
                                            .fill(.white)
                                            .padding(3)
                                    }
                            }
                            
                            Label {
                                Text("Monthly Listeners")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white.opacity(0.7))
                            } icon: {
                                Text("62,354,659")
                                    .fontWeight(.semibold)
                            }
                            .font(.caption)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 25)
                        .hAlign(.leading)
                    }
                }
                .cornerRadius(15)
                .offset(y: -minY)
        }
        .frame(height: 1250)
    }
    
    // MARK: Pinned Header
    @ViewBuilder
    func PinnedHeaderView() -> some View {
        let types: [String] = ["Popular", "Albums", "Songs", "Fans also like", "About"]
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach(types, id: \.self) { type in
                    VStack(spacing: 12) {
                        Text(type)
                            .fontWeight(.semibold)
                            .foregroundColor(currentType == type ? .white : .gray)
                        
                        ZStack {
                            if currentType == type {
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .fill(.white)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            } else {
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .fill(.clear)
                            }
                        }
                        .padding(.horizontal, 8)
                        .frame(height: 4)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            currentType = type
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 25)
            .padding(.bottom, 5)
        }
    }
}

struct SpotifyResponvieUI_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyResponvieUI()
            .preferredColorScheme(.dark)
    }
}
