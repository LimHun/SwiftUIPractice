//
//  MultiOneView.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/29.
//

import SwiftUI

var rainbowColors = [Color.red, Color.orange, Color.yellow, Color.green, Color.cyan, Color.blue, Color.purple]

class MutiViewModel : ObservableObject {
    var viewsPresentation : [Binding<PresentationMode>] = []
    @Published var isShowViewList : [Bool] = []
}

struct TestView1 : View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var mutiViewModel = MutiViewModel()
    @State var isShow : Bool = false
    
    var body: some View {
        VStack{
            NavigationLink {
                TestView2()
                    .environmentObject(mutiViewModel)
            } label: {
                Text("TestView1")
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(rainbowColors[0])
        }
        .onAppear{
            mutiViewModel.viewsPresentation.append(presentationMode)
            mutiViewModel.isShowViewList.append(isShow)
        }
    }
}

struct TestView2 : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mutiViewModel : MutiViewModel
    @State var isShow : Bool = false
    var body: some View {
        VStack{
            NavigationLink {
                TestView3()
                    .environmentObject(mutiViewModel)
            } label: {
                Text("TestView2")
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(rainbowColors[1])
        }
        .onAppear{
            mutiViewModel.viewsPresentation.append(presentationMode)
            mutiViewModel.isShowViewList.append(isShow)
        }
    }
}

struct TestView3 : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mutiViewModel : MutiViewModel
    @State var isShow : Bool = false
    var body: some View {
        VStack{
            NavigationLink {
                TestView4()
                    .environmentObject(mutiViewModel)
            } label: {
                Text("TestView3")
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(rainbowColors[2])
        }
        .onAppear{
            mutiViewModel.viewsPresentation.append(presentationMode)
            mutiViewModel.isShowViewList.append(isShow)
        }
    }
}

struct TestView4 : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mutiViewModel : MutiViewModel
    @State var isShow : Bool = false
    var body: some View {
        VStack{
            NavigationLink {
                TestView5()
                    .environmentObject(mutiViewModel)
            } label: {
                Text("TestView4")
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(rainbowColors[3])
        }
        .onAppear{
            mutiViewModel.viewsPresentation.append(presentationMode)
            mutiViewModel.isShowViewList.append(isShow)
        }
    }
}

struct TestView5 : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mutiViewModel : MutiViewModel
    @State var isShow : Bool = false
    var body: some View {
        VStack{
            NavigationLink {
                TestView6()
                    .environmentObject(mutiViewModel)
            } label: {
                Text("TestView5")
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(rainbowColors[4])
        }
        .onAppear{
            mutiViewModel.viewsPresentation.append(presentationMode)
            mutiViewModel.isShowViewList.append(isShow)
        }
    }
}

struct TestView6 : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mutiViewModel : MutiViewModel
    @State var isShow : Bool = false
    var body: some View {
        VStack{
            NavigationLink {
                TestView7()
                    .environmentObject(mutiViewModel)
            } label: {
                Text("TestView6")
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(rainbowColors[5])
        }
        .onAppear{
            mutiViewModel.viewsPresentation.append(presentationMode)
            mutiViewModel.isShowViewList.append(isShow)
        }
    }
}


struct TestView7 : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mutiViewModel : MutiViewModel
    @State var isShow : Bool = false
    var body: some View {
        VStack{
            NavigationLink {
                TestViewEnd()
                    .environmentObject(mutiViewModel)
            } label: {
                Text("TestView7")
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(rainbowColors[6])
        }
        .onAppear{
            mutiViewModel.viewsPresentation.append(presentationMode)
            mutiViewModel.isShowViewList.append(isShow)
        }
    }
}

struct TestViewEnd : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mutiViewModel : MutiViewModel
    @State var isShow : Bool = false
    var body: some View {
        VStack{
            Button {
                for presentView in mutiViewModel.viewsPresentation {
                    presentView.wrappedValue.dismiss()
                }
            } label: {
                Text("TestViewEnd")
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.random)
        }
        .onAppear{
            mutiViewModel.viewsPresentation.append(presentationMode)
            mutiViewModel.isShowViewList.append(isShow)
        }
    }
}

struct PresentationKey: EnvironmentKey {
    static let defaultValue: [Binding<Bool>] = []
}

extension EnvironmentValues {
    var presentations: [Binding<Bool>] {
        get { return self[PresentationKey.self] }
        set { self[PresentationKey.self] = newValue }
    }
}

struct MultiView: View {

    @Environment(\.presentations) private var presentations
    @Environment(\.presentationMode) var presentationMode

    @State var num = 0
    @State private var isShowView = false

    var body: some View {
        VStack {
            MultiNextView(num: $num)
                .navigationBarHidden(true)
                .environment(\.presentations, presentations + [$isShowView])
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("f first View Close")
            }
            .onChange(of: isShowView) { newValue in
                presentationMode.wrappedValue.dismiss()
            }

            NavigationLink("title", destination: MultiNextView(num: $num), isActive: $isShowView)

        }

    }
}

struct MultiNextView: View {

    @Environment(\.presentations) private var presentations
    @Environment(\.presentationMode) var presentationMode
    @Binding var num : Int
    @State private var isShowView = false

    var body: some View {
//        if num < 10 {
            VStack{
                NavigationLink {
                    MultiNextView(num: $num)
                        .environment(\.presentations, presentations + [$isShowView])
                } label: {
                    Text("View\n\(num)\nButton")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(Color.random)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.random)
                .navigationBarHidden(true)
                .onAppear {
                    num += 1
                }

                if num == 0 {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("first View Close")
                    }
                }
                else if num > 10 {
                    Button {
                        num = 0
                        presentations.forEach { isShowView in
                            isShowView.wrappedValue = false
                        }
                    } label: {
                        Text("All Close")
                    }
                }
            }
//        }
    }
}

struct MultiView_Previews: PreviewProvider {
    static var previews: some View {
        MultiView()
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
