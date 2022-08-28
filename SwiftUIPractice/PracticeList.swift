//
//  PracticeList.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/08/27.
//

import SwiftUI

struct CustomViewType: Identifiable {
    let id: UUID = UUID()
    var anyView: AnyView
}

struct PracticeList: View {

    let practiceViews : [Any] = [ListColorChange.self,
                                 VideoGridView.self,
                                 CarouselView.self,
                                 StockView.self,
                                 TouchAnimationView.self,
                                 TestView.self]

    func buildView(types: [Any], index: Int) -> AnyView {
        switch types[index].self {
        case is ListColorChange.Type:
            return AnyView( ListColorChange() )
        case is VideoGridView.Type:
            return AnyView( VideoGridView())
        case is TestView.Type:
            return AnyView( TestView() )
        case is CarouselView.Type:
            return AnyView( CarouselView() )
        case is StockView.Type:
            return AnyView( StockView() )
        case is TouchAnimationView.Type:
            return AnyView( TouchAnimationView() )
        default: return AnyView(EmptyView())
        }
    }

    @State private var selectedItem: String = ""
    @State private var isActive: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(0..<practiceViews.count, id: \.self) { index in

                    let studyTitle : String = String(describing: practiceViews[index])
                    NavigationLink {
                        buildView(types: practiceViews, index: index)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarTitle(studyTitle)
                            .onAppear {
                                isActive = true
                            }.onDisappear {
                                isActive = false
                            }
                    } label: {
                        Text(studyTitle)
                    }
                }
            }
            .listStyle(DefaultListStyle())
            .navigationBarTitle(isActive ? "" : "SwiftUI Study")
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct PracticeList_Previews: PreviewProvider {
    static var previews: some View {
        PracticeList()
    }
}
