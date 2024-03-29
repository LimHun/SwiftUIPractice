//
//  MovieVerticalView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/30.
//

import SwiftUI

struct MovieVerticalView: View {

    @State var index = 0
    @State var top = 0

    var body: some View {
        ZStack {
            VStack {

                // MARK: Following & For You
                HStack(spacing: 15) {
                    Button {
                        self.top = 0
                    } label: {
                        Text("Following")
                            .foregroundColor(self.top == 0 ? .white : Color.white.opacity(0.45))
                            .fontWeight(self.top == 0 ? .bold : .none)
                            .padding(.vertical)
                    }

                    Button {
                        self.top = 1
                    } label: {
                        Text("For You")
                            .foregroundColor(self.top == 1 ? .white : Color.white.opacity(0.45))
                            .fontWeight(self.top == 1 ? .bold : .none)
                            .padding(.vertical)
                    }
                }

                Spacer()

                // MARK: 우측 하단 버튼 (좋아요 수, 댓글 수, 공유하기)
                HStack {

                    Spacer()

                    VStack(spacing: 35) {
                        Button {

                        } label: {
                            Image("Hun")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                        }

                        VStack(spacing: 8) {
                            Button {

                            } label: {
                                Image(systemName: "suit.heart.fill")
                                    .font(.title)
                                    .foregroundColor(.white)

                                Text("22K")
                                    .foregroundColor(.white)
                            }

                            Button {

                            } label: {
                                Image(systemName: "message.fill")
                                    .font(.title)
                                    .foregroundColor(.white)

                                Text("1021")
                                    .foregroundColor(.white)
                            }

                            Button {

                            } label: {
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                    .font(.title)
                                    .foregroundColor(.white)

                                Text("Share")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                        .padding(.bottom, 55)
                        .padding(.trailing)
                }

                // MARK: 하단탭
                HStack(spacing: 0) {
                    Button {
                        print("button")
                        self.index = 0
                    } label: {
                        Image("HomeWhite")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 0 ? .white : Color.white.opacity(0.35))
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button {
                        print("button")
                        self.index = 1
                    } label: {
                        Image("SearchWhite")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 0 ? .white : Color.white.opacity(0.35))
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button {
                        print("button")
                        self.index = 2
                    } label: {
                        Image("Plus")
                            .resizable()
                            .frame(width: 50, height: 35)
                            .foregroundColor(self.index == 0 ? .white : Color.white.opacity(0.35))
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button {
                        print("button")
                        self.index = 3
                    } label: {
                        Image("Comment")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button {
                        print("button")
                        self.index = 4
                    } label: {
                        Image("ProfileWhite")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 0 ? .white : Color.white.opacity(0.35))
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
} 

struct MovieVerticalView_Previews: PreviewProvider {
    static var previews: some View {
        MovieVerticalView()
    }
}
