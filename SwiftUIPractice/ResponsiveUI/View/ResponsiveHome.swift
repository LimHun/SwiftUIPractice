//
//  ResponsiveHome.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/06.
//

import SwiftUI

struct ResponsiveHome: View {
    var props: Properties

    // MARK: View Properties
    @State var currentTab: String = "Home"
    @State var showSideBar: Bool = false
    @Namespace var animation
    var body: some View {
        HStack(spacing: 0) {
            // MARK: Showing Only For iPad
            if props.isiPad {
                ViewThatFits {
                    SideBar()
                    ScrollView(.vertical, showsIndicators: false) {
                        SideBar()
                    }
                    .background(Color.white.ignoresSafeArea())
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    HeaderView()
                }
                .padding(15)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background {
            Color.black
                .opacity(0.04)
                .ignoresSafeArea()
        }
        .overlay(alignment: .leading) {
            // MARK: Side Bar For Non iPad Devices
            SideBar()
                .offset(x: showSideBar ? 0 : -100)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    Color.black
                        .opacity(showSideBar ? 0.25 : 0)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut) { showSideBar.toggle() }
                        }
                }
            
        }
    }
    
    // MARK: Header View
    @ViewBuilder
    func HeaderView() -> some View {
        // MARK: Dynamic Layout(iOS 16+)
        let layout = props.isiPad && !props.isMaxSplit ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout(spacing: 22))
        
        layout {
            VStack(alignment: .leading, spacing: 8) {
                Text("Seattle, New York")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // MARK: Search Bar With Menu Button
            HStack(spacing: 10) {
                if !(props.isiPad && !props.isMaxSplit) {
                    Button {
                        withAnimation(.easeInOut) { showSideBar.toggle() }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    
                    TextField("Search", text: .constant(""))
                    
                    Image("Search")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)

                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background {
                Capsule()
                    .fill(.white)
            }
        }
    }

    // MARK: Side bar
    @ViewBuilder
    func SideBar() -> some View {
        // MARK: Side Bar
        let tabs: [String] = [
            "Home", "Table", "Menu", "Order", "History", "Report", "Alert", "Settings"
        ]

        VStack(spacing: 10) {
            Image("starbucks")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55)
                .padding(.bottom, 10)

            ForEach(tabs, id:\.self) { tab in
                VStack(spacing: 8) {
                    Image(tab)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)

                    Text(tab)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundColor(currentTab == tab ? Color("Orange") : .gray)
                .padding(.vertical, 13)
                .frame(width: 65)
                .background {
                    if currentTab == tab {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color("Orange").opacity(0.1))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) { currentTab = tab }
                }
            }

            Button {

            } label: {
                VStack {
                    Image("Hun")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())

                    Text("Profile")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 20)

        }
        .padding(.vertical)
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(width: 100)
        .background{
            Color.white
                .ignoresSafeArea()
        }
    }
}

struct ResponsiveHome_Previews: PreviewProvider {
    static var previews: some View {
        ResponsiveContent()
    }
}
