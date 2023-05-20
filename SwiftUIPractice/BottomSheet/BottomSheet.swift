//
//  BottomSheet.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/10/26.
//

import SwiftUI

// bottom
struct BottomSheet: View {
    
    // Search Text Binding Value
    @State var searchText = ""
    
    // Gesture Properties...
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let frame = proxy.frame(in: .global)
                
                Image("Movie1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width, height: frame.height)
            }
            .blur(radius: getBlurRadius())
            .ignoresSafeArea()
            
            // BottomSheet
            
            GeometryReader { proxy in
                let height = proxy.frame(in: .global).height
                AnyView(
                    ZStack {
                        BlurView(style: .systemThinMaterialDark)
                            .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
                        
                        VStack {
                            VStack {
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: 60, height: 4)
                                
                                TextField("Search", text: $searchText)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(BlurView(style: .dark))
                                    .cornerRadius(10)
                                    .colorScheme(.dark)
                                    .padding(.top, 10)
                            }
                            .frame(height: 100)
                                                        
                            // ScrollView Content..
                            ScrollView(.vertical, showsIndicators: false) {
                                BottomContent()
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxHeight: .infinity, alignment: .top)

                    }
                    .offset(y: height - 100)
                    .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
                    .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.height
                        onChange()
                    }).onEnded({ value in
                        
                        let maxHeight = height - 100
                        withAnimation {
                            // Logic Conditions for moving states...
                            // Up down or mid
                            if -offset > 100 && -offset < maxHeight / 2 {
                                // Mid..
                                offset = -(maxHeight / 3)
                            } else if -offset > maxHeight / 2 {
                                offset = -maxHeight
                            } else {
                                offset = 0
                            }
                        }
                        
                        // Storing Last offset
                        // so that the gesture can contiue from the last position
                        lastOffset = offset
                    }))
                )
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
    
    // Blur Radius for Bg
    func getBlurRadius() -> CGFloat {
        let progress = -offset / (UIScreen.main.bounds.height - 100)
        return progress * 20
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet()
    }
}

struct BottomContent: View {
    var body: some View {
        VStack {
            HStack {
                Text("Favourites")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("See All")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }

            }
            .padding(.top, 20)
            
            Divider()
                .background(Color.white)
                
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    VStack(spacing: 8) {
                        Button {
                            
                        } label: {
                            Image(systemName: "house.fill")
                                .font(.title)
                                .frame(width: 65, height: 65)
                                .background(BlurView(style: .dark))
                                .clipShape(Circle())
                        }
                        
                        Text("Home")
                    }
                    .foregroundColor(.white)
                    
                    VStack(spacing: 8) {
                        Button {
                            
                        } label: {
                            Image(systemName: "briefcase.fill")
                                .font(.title)
                                .frame(width: 65, height: 65)
                                .background(BlurView(style: .dark))
                                .clipShape(Circle())
                        }
                        
                        Text("Work")
                    }
                    .foregroundColor(.white)
                    
                    VStack(spacing: 8) {
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .frame(width: 65, height: 65)
                                .background(BlurView(style: .dark))
                                .clipShape(Circle())
                        }
                        
                        Text("Add")
                    }
                    .foregroundColor(.white)
                }
            }
            .padding(.top)
            
            HStack {
                Text("Editor's Pick")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("See All")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }

            }
            .padding(.top, 25)
            
            Divider()
                .background(Color.white)
            
            ForEach(1...5, id: \.self) { index in
                Image("Movie\(index)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                    .cornerRadius(15)
                    .padding(.top)
            }
        }
    }
}
