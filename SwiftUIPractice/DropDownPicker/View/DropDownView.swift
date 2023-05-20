//
//  DropDownView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/01/08.
//

import SwiftUI

struct DropDownView: View {
    let menus = ["Easy", "Normal", "Hard", "Expert"]
    @State private var selection: String = "Easy"
    @Environment(\.colorScheme) var scheme
    var body: some View {
        VStack {
            DropDown(content: menus,
                     selection: $selection,
                     activeTint: .primary.opacity(0.1),
                     inActiveTint: .primary.opacity(0.05),
                     dynamic: false // 하단으로만 나오게 하기 위해선 false
                     
            )
            .frame(width: 130)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            if scheme == .dark {
                Color("DropDownBG")
                    .ignoresSafeArea()
            }
        }
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView()
    }
}

struct DropDown: View {
    /// - Drop Down Properties
    var content: [String]
    @Binding var selection: String
    var activeTint: Color
    var inActiveTint: Color
    var dynamic: Bool = true // 드롭박스 위로도 메뉴가 표시되도록 하려면 true
    /// - View Properties
    @State private var expandView: Bool = false
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                if !dynamic {
                    rowView(selection, size)
                }
                ForEach(content.filter {
                    dynamic ? true : $0 != selection
                }, id: \.self) { title in
                    rowView(title, size)
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(inActiveTint)
            }
            /// - Moving View Based on the Selection
            .offset(y: dynamic ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -55) : 0)
        }
        .frame(height: 55)
        .overlay(alignment: .trailing) {
            Image(systemName: "chevron.up.chevron.down")
                .padding(.trailing, 10)
        }
        .mask(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: expandView ? CGFloat(content.count) * 55 : 55)
                .offset(y: dynamic && expandView ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -55) : 0)
        }
    }
    
    @ViewBuilder
    func rowView(_ title: String, _ size: CGSize) -> some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .frame(width: size.width, height: size.height, alignment: .leading)
            .background {
                if selection == title {
                    Rectangle()
                        .fill(activeTint)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    
                    /// - If Expanded then Make Selection
                    if expandView {
                        expandView = false
                        if dynamic {
                            selection = title
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                selection = title
                            }
                        }
                    } else {
                        // expandView = true
                        /// - disabling Outside Taps
                        if selection == title {
                            expandView = true
                        }
                    }
                }
            }
    }
}
