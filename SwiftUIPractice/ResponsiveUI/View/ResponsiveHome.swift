//
//  ResponsiveHome.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/06.
//

import SwiftUI
import Charts // iOS14+

struct ResponsiveHome: View {
    var props: Properties
    
    // MARK: View Properties
    @State var currentTab: String = "Home"
    @State var showSideBar: Bool = false
    @Namespace var animation
    var body: some View {
        HStack(spacing: 0) {
            // MARK: Showing Only For iPad
            if props.isAdoptable {
                ViewThatFits {
                    SideBar()
                    ScrollView(.vertical, showsIndicators: false) {
                        SideBar()
                    }
                    .background(Color.white.ignoresSafeArea())
                }
                .onAppear {
                    withAnimation(.easeInOut) { showSideBar = false }
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    HeaderView()
                    InfoCards()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            DailySalesView()
                            PieChartView()
                        }
                    }
                    
                    TrendingItemsView()
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
            ViewThatFits {
                SideBar()
                ScrollView(.vertical, showsIndicators: false) {
                    SideBar()
                }
                .background(Color.white.ignoresSafeArea())
            }
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
    
    // MARK: Trending Item View
    @ViewBuilder
    func TrendingItemsView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Trending Dishes")
                .font(.title3.bold())
                .padding(.bottom)
            
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: props.isAdoptable ? 2 : 1), spacing: props.isAdoptable ? 20 : 15) {
                ForEach(trendingDishes) { item in
                    HStack(spacing: 15) {
                        Image(item.image)
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .padding(10)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color("Orange").opacity(0.1))
                            }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.title)
                                .fontWeight(.bold)
                                .lineLimit(1)
                            
                            Label {
                                Text(item.title)
                                    .foregroundColor(Color("Orange"))
                            } icon: {
                                Text("\(item.subTitle)")
                                    .foregroundColor(.gray)
                            }
                            .font(.callout)
                            .fontWeight(.semibold)
                        }
                        .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(alignment: .topTrailing, content: {
                        Button("View All") {}
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Orange"))
                            .offset(y: 6)
                    })
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
        .background{
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
        }
        .padding(.top, 10)
    }
    
    // MARK: PieChart View
    func PieChartView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Total Income")
                .font(.title3.bold())
            
            ZStack{
                Circle()
                    .trim(from: 0.5, to: 1)
                    .stroke(.red, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Circle()
                    .trim(from: 0.2, to: 0.5)
                    .stroke(.yellow, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Circle()
                    .trim(from: 0, to: 0.2)
                    .stroke(.green, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Circle()
                    .trim(from: 0.2, to: 0.25)
                    .stroke(.blue, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                
                Text("$200K")
                    .font(.title)
                    .fontWeight(.heavy)
            }
        }
        .padding(15)
        .frame(width: 250, height: 250)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
        }
    }
    
    // MARK: Graph View
    @ViewBuilder
    func DailySalesView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Daily Sales")
                .font(.title3.bold())
            
            Chart {
                ForEach(dailySales) { sale in
                    // MARK: Area Mark For Gradient BG
                    AreaMark(
                        x: .value("Time", sale.time),
                        y: .value("Sale", sale.sales)
                    )
                    .foregroundStyle(.linearGradient(colors:[
                        Color("Orange").opacity(0.6),
                        Color("Orange").opacity(0.5),
                        Color("Orange").opacity(0.3),
                        Color("Orange").opacity(0.1),
                        .clear
                    ], startPoint: .top, endPoint: .bottom))
                    .interpolationMethod(.catmullRom)
                    
                    // MARK: Line Mark
                    LineMark(
                        x: .value("Time", sale.time),
                        y: .value("Sale", sale.sales)
                    )
                    .foregroundStyle(Color("Orange"))
                    .interpolationMethod(.catmullRom)
                    
                    PointMark(
                        x: .value("Time", sale.time),
                        y: .value("Sale", sale.sales)
                    )
                    .foregroundStyle(Color("Orange"))
                }
            }
            .frame(height: 180)
        }
        .padding(15)
        .background(content: {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
        })
        // MARK: 400 -> side bar(100) + padding(30) + piecherview(250) + spacing(20)
        .frame(minWidth: props.isAdoptable ? props.size.width - 400 : props.size.width - 30)
    }
    
    // MARK: Info Cards View
    @ViewBuilder
    func InfoCards() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(infos) { info in
                    VStack(alignment: .leading, spacing: 18) {
                        HStack(spacing: 15) {
                            Text(info.title)
                                .font(.title3.bold())
                            
                            Spacer()
                            
                            HStack(spacing: 8) {
                                Image(systemName: info.loss ? "arrow.down" : "arrow.up")
                                Text("\(info.percentage)%")
                            }
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(info.loss ? .red : .green)
                        }
                        
                        HStack(spacing: 18) {
                            Image(systemName: info.icon)
                                .font(.title3)
                                .foregroundColor(.white)
                                .frame(width: 45, height: 45)
                                .background {
                                    Circle()
                                        .fill(info.iconColor)
                                }
                            
                            Text(info.amount)
                                .font(.title.bold())
                        }
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.white)
                    }
                }
            }
            .padding(15)
        }
        .padding(.horizontal, -15)
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
                if !props.isAdoptable {
                    Button {
                        withAnimation(.easeInOut) { showSideBar.toggle() }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                }
                
                TextField("Search", text: .constant(""))
                
                Image("Search")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
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
